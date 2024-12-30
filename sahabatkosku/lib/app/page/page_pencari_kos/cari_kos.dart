import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:open_route_service/open_route_service.dart';
import 'package:sahabatkosku/app/modules/home/controllers/pencari_Kos/home_controller.dart';
import 'package:sahabatkosku/app/page/page_pencari_kos/filter_pencarian.dart';
import 'package:sahabatkosku/app/page/page_pencari_kos/metode_pembayaran.dart';

class KostView extends StatelessWidget {
  const KostView({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue, // Tambahkan warna biru untuk background
        title: Row(
          // Row untuk mengatur agar icon filter sejajar dengan TextField
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 280,
              height: 40,
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  fillColor: const Color.fromARGB(255, 235, 233, 233),
                  filled: true,
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Telusuri Kos',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
              ),
            ),
            IconButton(
              color: Colors.white,
              icon: const Icon(Icons.filter_alt),
              onPressed: () => Get.to(FilterPage()),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Kos yang baru ditambahkan',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.kostList.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              return SingleChildScrollView(
                child: GridView.builder(
                  shrinkWrap:
                      true, // Mencegah gridview mengambil ruang lebih dari yang diperlukan
                  physics:
                      const NeverScrollableScrollPhysics(), // Mencegah scroll dalam GridView, cukup scroll di luar
                  padding: const EdgeInsets.all(16.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio:
                        0.75, // Adjust ratio to fit content better
                  ),
                  itemCount: controller.kostList.length,
                  itemBuilder: (context, index) {
                    var kost = controller.kostList[index];
                    return GestureDetector(
                      onTap: () {
                        // Navigasi ke KosDetailPage saat KostCard ditekan
                        Get.to(KosDetailPage());
                      },
                      child: _buildKostCard(kost),
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildKostCard(KostModel kost) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 94,
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://via.placeholder.com/150'), // Ganti dengan URL gambar
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    kost.gender,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
              const Positioned(
                top: 8,
                right: 8,
                child: Icon(Icons.bookmark_border, color: Colors.white),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              kost.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                const Icon(Icons.location_on, size: 16, color: Colors.red),
                const SizedBox(width: 4),
                Text(kost.location, style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Text(kost.facilities, style: const TextStyle(fontSize: 12)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                const Icon(Icons.star, size: 16, color: Colors.yellow),
                const SizedBox(width: 4),
                Text('${kost.rating}/5.0',
                    style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(kost.price,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          ),
        ],
      ),
    );
  }
}

class KosDetailPage extends StatefulWidget {
  const KosDetailPage({super.key});

  State<KosDetailPage> createState() => _MapScreenState();
}

class _MapScreenState extends State<KosDetailPage> {
  LatLng myPoint =
      LatLng(-8.923303951223144, 13.182696707942991); // Inisialisasi awal
  LatLng endPoint =
      LatLng(-7.9666204, 112.63263210000001); // Titik akhir yang diberikan
  bool isLoading = true; // Default jadi loading hingga lokasi ditemukan
  bool locationPermissionDenied = false; // Indikator izin ditolak
  final MapController mapController = MapController();

  @override
  void initState() {
    super.initState();
    _determinePosition(); // Dapatkan lokasi pengguna saat ini
  }

  List<LatLng> points = [];

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Pastikan layanan lokasi diaktifkan
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Lokasi tidak diaktifkan, handle sesuai kebutuhan
      setState(() {
        isLoading = false;
      });
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          isLoading = false;
          locationPermissionDenied = true;
        });
        // Jika izin ditolak, handle error
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        isLoading = false;
        locationPermissionDenied = true;
      });
      // Handle ketika pengguna menolak izin secara permanen
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // Dapatkan posisi sekarang jika izin sudah diberikan
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      myPoint = LatLng(position.latitude, position.longitude);
      mapController.move(endPoint, 16); // Pindahkan peta ke lokasi saat ini
      isLoading = false; // Setelah posisi didapat, hapus indikator loading
    });

    print('Lokasi saya: ${position.latitude}, ${position.longitude}');

    // Panggil fungsi untuk mendapatkan rute setelah mendapatkan posisi
    await getCoordinates(myPoint, endPoint);
  }

  Future<void> getCoordinates(LatLng lat1, LatLng lat2) async {
    setState(() {
      isLoading = true;
    });

    final OpenRouteService client = OpenRouteService(
      apiKey: '5b3ce3597851110001cf6248421262b326f1472a95f658a82f7e7024',
    );

    final List<ORSCoordinate> routeCoordinates =
        await client.directionsRouteCoordsGet(
      startCoordinate:
          ORSCoordinate(latitude: lat1.latitude, longitude: lat1.longitude),
      endCoordinate:
          ORSCoordinate(latitude: lat2.latitude, longitude: lat2.longitude),
    );

    final List<LatLng> routePoints = routeCoordinates
        .map((coordinate) => LatLng(coordinate.latitude, coordinate.longitude))
        .toList();

    setState(() {
      points = routePoints;
      isLoading = false;
    });

    // Fit bounds to route
    LatLngBounds bounds = LatLngBounds.fromPoints([lat1, lat2]);
    mapController.fitBounds(bounds);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_border),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Image Section
            Stack(children: [
              Image.network(
                'https://via.placeholder.com/150', // Placeholder for image
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
              Positioned(
                left: 16,
                bottom: 5,
                child: Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.camera_alt),
                      label: const Text("Foto"),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.videocam),
                      label: const Text("Video"),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 16,
                bottom: 5,
                child: IconButton(
                  onPressed: () => Get.to(()),
                  icon: const Icon(Icons.fullscreen, color: Colors.black),
                ),
              ),
            ]),
            // Information Section
            Container(
              color: Colors.blue,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Nama Kos",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          "Laki-laki",
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.location_pin, color: Colors.red),
                      const Text(
                        "Lokasi",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow),
                      Text(
                        "5.0 / 5.0",
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        " · (8 dari 11 penghuni)",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Rp ______ / Bulan · Status Kamar",
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Spesifikasi Tipe Kamar",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              const Text("____"),
                              Divider(),
                              const Text("Fasilitas",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              const Text("____"),
                              Divider(),
                              const Text("Peraturan",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              const Text("____"),
                              Divider(),
                              const Text("Ketentuan Pengajuan Sewa",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              const Text("____"),
                              Divider(),
                              const Text("Peta Lokasi Kos",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: 10,
                              ),
                              locationPermissionDenied
                                  ? const Center(
                                      child: Text(
                                          "Izinkan lokasi terlebih dahulu untuk melihat peta lokasi kos"))
                                  : Container(
                                      width: double.infinity,
                                      height: 250,
                                      child: Stack(
                                        children: [
                                          FlutterMap(
                                            mapController: mapController,
                                            options: MapOptions(
                                              zoom: 16,
                                              center: locationPermissionDenied
                                                  ? endPoint // Jika izin ditolak, fokus ke titik akhir
                                                  : myPoint, // Gunakan myPoint yang sudah diinisialisasi, // Gunakan myPoint yang sudah diinisialisasi
                                            ),
                                            children: [
                                              TileLayer(
                                                urlTemplate:
                                                    "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                                                userAgentPackageName:
                                                    'dev.fleaflet.flutter_map.example',
                                              ),
                                              MarkerLayer(
                                                markers: [
                                                  if (!locationPermissionDenied) // Tampilkan marker pengguna hanya jika izin diberikan
                                                    Marker(
                                                      point: myPoint,
                                                      width: 80,
                                                      height: 80,
                                                      child: Container(
                                                        child: const Icon(
                                                          Icons.location_on,
                                                          color: Colors.blue,
                                                          size: 45,
                                                        ),
                                                      ),
                                                    ),
                                                  Marker(
                                                    point: endPoint,
                                                    width: 80,
                                                    height: 80,
                                                    child: Container(
                                                      child: const Icon(
                                                        Icons.location_on,
                                                        color: Colors.red,
                                                        size: 45,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              PolylineLayer(
                                                polylineCulling: false,
                                                polylines: [
                                                  Polyline(
                                                    points: points,
                                                    color: Colors.black,
                                                    strokeWidth: 5,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Visibility(
                                            visible: isLoading,
                                            child: Container(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              child: const Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                              Divider(),
                              const Text("Review",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              const Text("____"),
                            ],
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // Bagian BottomNavigationBar
      // Bagian BottomNavigationBar
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Stack(
          clipBehavior: Clip.none, // Memungkinkan posisi elemen di luar Stack
          children: [
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      side: const BorderSide(color: Colors.blue),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Booking Kamar",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Get.to(MetodePembayaranScreen()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text("Ajukan Sewa"),
                  ),
                ),
              ],
            ),
            // Elemen sticky yang di kanan bawah dengan z-index paling atas
            Positioned(
              right: 0,
              bottom: 70, // Mengatur jarak dari tombol
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.green,
                    child: IconButton(
                      icon: const Icon(
                        Icons.phone,
                        color: Colors.white,
                        size: 35,
                      ),
                      onPressed: () {
                        // Aksi ketika tombol phone diklik
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 223, 223, 223),
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: const Text("Dikelola Oleh"),
                      ),
                      const SizedBox(width: 10),
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                            'https://via.placeholder.com/100'), // URL gambar profil
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
