import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahabatkosku/app/modules/home/controllers/admin/konfirmasiKos_controller.dart';

class KosConfirmationScreen extends StatelessWidget {
  final KosController controller = Get.put(KosController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Konfirmasi Kos'),
        centerTitle: true,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar and dropdowns
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: SizedBox(
                        child: TextField(
                          decoration: InputDecoration(
                            fillColor: const Color.fromARGB(255, 235, 233, 233),
                            labelText: 'Nama Kos',
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.0)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            fillColor: const Color.fromARGB(255, 235, 233, 233),
                            labelText: 'Pilih Status',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.0)),
                          ),
                          items: const [
                            DropdownMenuItem(
                                value: 'status', child: Text('Status')),
                          ],
                          onChanged: (value) {},
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    labelText: 'Urutkan Berdasarkan',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'a-z', child: Text('A - Z')),
                  ],
                  onChanged: (value) {},
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Kos information card
            Obx(() => Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.grey[300],
                              child: const Icon(Icons.person, size: 50),
                            ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [],
                                ),
                                Text(controller.ownerName.value,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                Text(controller.ownerPhone.value),
                              ],
                            ),
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      'https://via.placeholder.com/150'), // Ganti dengan URL gambar
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ), // Replace with your image
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 2, horizontal: 6),
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                                255, 107, 107, 107)
                                            .withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Text(
                                        'Laki-laki',
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 65,
                                    ),
                                    Text(controller.status_konfirmasi.value,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(controller.kosName.value,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.location_on),
                                    Text(controller.location.value),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(controller.facilities.value),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              // Show detailed information
                            },
                            child: const Text(
                              'Tampilkan Detail',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              flex: 2,
                              child: ElevatedButton(
                                onPressed: controller.rejectKos,
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  foregroundColor: Colors.blue,
                                  backgroundColor: Colors.white,
                                  side: const BorderSide(color: Colors.blue),
                                ),
                                child: const Text('Tolak'),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 2,
                              child: ElevatedButton(
                                onPressed: controller.acceptKos,
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.blue,
                                ),
                                child: const Text('Terima'),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )),
            // Action buttons
          ],
        ),
      ),
    );
  }
}
