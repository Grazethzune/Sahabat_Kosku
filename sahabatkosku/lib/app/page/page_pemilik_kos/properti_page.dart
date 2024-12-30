import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahabatkosku/app/modules/home/controllers/pemilik_Kos/properti_controller.dart';
import 'package:sahabatkosku/app/modules/home/controllers/pencari_Kos/home_controller.dart';
import 'package:sahabatkosku/app/page/page_pemilik_kos/buat_kos/buat_kos.dart';
import 'package:sahabatkosku/app/page/page_pemilik_kos/buat_kos/tambah_kamar.dart';

class PropertyScreen extends StatelessWidget {
  final PropertiController controller = Get.put(PropertiController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Properti"),
        backgroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: const TextStyle(color: Colors.black, fontSize: 18),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Properti yang dimiliki",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Obx(() {
              // Check if kostList is empty
              if (controller.kostList.isEmpty) {
                return const Center(
                  child: Text(
                    "Anda belum memiliki properti atau kos apapun",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14),
                  ),
                );
              } else {
                return buildPropertiList(controller.kostList);
              }
            }),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  "Kelola Properti",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: () {
                    Get.to(() => RoomAvailabilityScreen());
                  },
                  icon: const Icon(Icons.meeting_room),
                  label: const Text("Atur Ketersediaan Kamar"),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    side: const BorderSide(color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: () {
                    Get.to(() => PriceSettingsScreen());
                  },
                  icon: const Icon(Icons.price_change),
                  label: const Text("Atur Harga"),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    side: const BorderSide(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RoomAvailabilityScreen extends StatelessWidget {
  final PropertiController controller = Get.put(PropertiController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Atur Ketersediaan Kamar"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(() {
              // Check if kostList is empty
              if (controller.kostList.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "Anda belum memiliki properti atau kos apapun",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                );
              } else {
                return SizedBox(
                    height: 550, child: buildPropertiList(controller.kostList));
              }
            }),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.to(DataKosScreen());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Button color
                padding:
                    const EdgeInsets.symmetric(horizontal: 120, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Tambah Kos',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
            const SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}

class PropertyDetailScreen extends StatelessWidget {
  final PropertiModel property;

  PropertyDetailScreen({required this.property});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(property.namaKos),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Alamat: ${property.alamat}", style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text("Aturan: ${property.aturan}", style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text("Fasilitas Parkir: ",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(
              property.fasilitasParkir
                  .where((fasilitas) =>
                      fasilitas.values.first['isSelected'] == true)
                  .map((fasilitas) =>
                      "${fasilitas.keys.first}: ${fasilitas.values.first['description']}")
                  .join("\n"),
            ),
            SizedBox(height: 10),
            Text("Fasilitas Umum:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(
              property.fasilitasUmum
                  .where((fasilitas) =>
                      fasilitas.values.first['isSelected'] == true)
                  .map((fasilitas) => fasilitas.keys.first)
                  .join("\n"),
            ),
            SizedBox(height: 10),
            Text("Gender: ${property.gender}", style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Text("Kamar:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: property.kamar.length,
                itemBuilder: (context, index) {
                  final room = property.kamar[index];
                  return buildRoomCard(room);
                },
              ),
            ),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(tambahKamarScreen(kosId: property.kosId));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Button color
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'tambah kamar',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

Widget buildPropertiList(List<PropertiModel> kostList) {
  return ListView.builder(
    shrinkWrap: true,
    itemCount: kostList.length,
    itemBuilder: (context, index) {
      var kos = kostList[index];
      return GestureDetector(
        onTap: () {
          Get.to(() => PropertyDetailScreen(property: kos));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  // Placeholder untuk gambar
                  Container(
                    width: 80,
                    height: 80,
                    color: Colors.grey[300],
                    child:
                        const Icon(Icons.image, size: 50, color: Colors.grey),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Gender Badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(kos.gender),
                        ),
                        const SizedBox(height: 5),
                        // Nama Kost
                        Text(
                          kos.namaKos,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        // Lokasi
                        Row(
                          children: [
                            const Icon(Icons.location_on, size: 16),
                            const SizedBox(width: 5),
                            Text(kos.latTitude),
                          ],
                        ),
                        const SizedBox(height: 5),
                        // Fasilitas
                        Text(
                          kos.fasilitasUmum
                              .where((fasilitas) =>
                                  fasilitas.values.first['isSelected'] == true)
                              .map((fasilitas) => fasilitas.keys.first)
                              .join(", "),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '${kos.kamar.length.toString()} Kamar tersedia',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

// Fungsi buildPropertiList untuk menampilkan daftar properti

Widget buildFasilitasList(Map fasilitas) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: fasilitas.entries
        .where((fasilitas) => fasilitas.value['isSelected'] == true)
        .map((entry) {
      return Text('${entry.key}: ${entry.value['description']}');
    }).toList(),
  );
}

Widget buildRoomCard(Map kamar) {
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 8),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    elevation: 2,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Nomor Kamar: ${kamar[kamar.entries.first.key]['nomorKamar']}",
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text("Lantai: ${kamar[kamar.entries.first.key]['lantai']}"),
          Text("Luas: ${kamar[kamar.entries.first.key]['luas']} m²"),
          Text(
              "Harga: ${kamar[kamar.entries.first.key]['harga']} per ${kamar[kamar.entries.first.key]['tiap']} ${kamar[kamar.entries.first.key]['pembayaran']}"),
          const SizedBox(height: 8),
          const Text("Fasilitas Kamar:",
              style: TextStyle(fontWeight: FontWeight.bold)),
          buildFasilitasList(kamar[kamar.entries.first.key]['fasilitasKamar']),
          const SizedBox(height: 8),
          const Text("Fasilitas Kamar Mandi:",
              style: TextStyle(fontWeight: FontWeight.bold)),
          buildFasilitasList(
              kamar[kamar.entries.first.key]['fasilitasKamarMandi']),
        ],
      ),
    ),
  );
}

class PriceSettingsScreen extends StatelessWidget {
  const PriceSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Atur Harga"),
      ),
      body: const Center(
        child: Text("Price Settings Screen"),
      ),
    );
  }
}
