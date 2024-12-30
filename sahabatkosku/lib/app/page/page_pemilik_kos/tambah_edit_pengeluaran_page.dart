import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sahabatkosku/app/modules/home/controllers/pemilik_Kos/pengeluaran_controller.dart';

class TambahPengeluaranPage extends StatelessWidget {
  final PengeluaranController controller = Get.put(PengeluaranController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Pengeluaran'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Input Tanggal
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Tanggal',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      controller.tanggal.value = value;
                    },
                  ),
                  SizedBox(height: 16),

                  // Dropdown Nama Kos
                  Obx(() => DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Nama Kos',
                          border: OutlineInputBorder(),
                        ),
                        value: controller.selectedKos.value.isEmpty
                            ? null
                            : controller.selectedKos.value,
                        onChanged: (value) {
                          controller.selectedKos.value = value!;
                        },
                        items: controller.kosList
                            .map((kos) => DropdownMenuItem(
                                  value: kos,
                                  child: Text(kos),
                                ))
                            .toList(),
                      )),
                  SizedBox(height: 16),

                  // Dropdown Lantai
                  Obx(() => DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Lantai',
                          border: OutlineInputBorder(),
                        ),
                        value: controller.selectedLantai.value.isEmpty
                            ? null
                            : controller.selectedLantai.value,
                        onChanged: (value) {
                          controller.selectedLantai.value = value!;
                        },
                        items: controller.lantaiList
                            .map((lantai) => DropdownMenuItem(
                                  value: lantai,
                                  child: Text(lantai),
                                ))
                            .toList(),
                      )),
                  SizedBox(height: 16),

                  // Dropdown Kamar
                  Obx(() => DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Kamar',
                          border: OutlineInputBorder(),
                        ),
                        value: controller.selectedKamar.value.isEmpty
                            ? null
                            : controller.selectedKamar.value,
                        onChanged: (value) {
                          controller.selectedKamar.value = value!;
                        },
                        items: controller.kamarList
                            .map((kamar) => DropdownMenuItem(
                                  value: kamar,
                                  child: Text(kamar),
                                ))
                            .toList(),
                      )),
                  SizedBox(height: 16),

                  // Dropdown Kategori Pengeluaran
                  Obx(() => DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Kategori Pengeluaran',
                          border: OutlineInputBorder(),
                        ),
                        value: controller.selectedKategori.value.isEmpty
                            ? null
                            : controller.selectedKategori.value,
                        onChanged: (value) {
                          controller.selectedKategori.value = value!;
                        },
                        items: controller.kategoriList
                            .map((kategori) => DropdownMenuItem(
                                  value: kategori,
                                  child: Text(kategori),
                                ))
                            .toList(),
                      )),
                  SizedBox(height: 16),

                  // Input Keterangan
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Keterangan',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 4,
                    onChanged: (value) {
                      controller.keterangan.value = value;
                    },
                  ),
                  SizedBox(height: 16),

                  // Input Jumlah Pengeluaran
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Jumlah Pengeluaran',
                      border: OutlineInputBorder(),
                      prefixText: 'Rp ',
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      controller.jumlahPengeluaran.value = value;
                    },
                  ),
                  SizedBox(
                      height:
                          100), // Spacing agar konten tidak overlap dengan tombol
                ],
              ),
            ),
          ),

          // Sticky Button
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Logika untuk menyimpan data
                    print('Pengeluaran disimpan');
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    'Simpan',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EditPengeluaranPage extends StatelessWidget {
  final PengeluaranController controller = Get.put(PengeluaranController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Pengeluaran'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Input Tanggal
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Tanggal',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      controller.tanggal.value = value;
                    },
                  ),
                  SizedBox(height: 16),

                  // Dropdown Nama Kos
                  Obx(() => DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Nama Kos',
                          border: OutlineInputBorder(),
                        ),
                        value: controller.selectedKos.value.isEmpty
                            ? null
                            : controller.selectedKos.value,
                        onChanged: (value) {
                          controller.selectedKos.value = value!;
                        },
                        items: controller.kosList
                            .map((kos) => DropdownMenuItem(
                                  value: kos,
                                  child: Text(kos),
                                ))
                            .toList(),
                      )),
                  SizedBox(height: 16),

                  // Dropdown Lantai
                  Obx(() => DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Lantai',
                          border: OutlineInputBorder(),
                        ),
                        value: controller.selectedLantai.value.isEmpty
                            ? null
                            : controller.selectedLantai.value,
                        onChanged: (value) {
                          controller.selectedLantai.value = value!;
                        },
                        items: controller.lantaiList
                            .map((lantai) => DropdownMenuItem(
                                  value: lantai,
                                  child: Text(lantai),
                                ))
                            .toList(),
                      )),
                  SizedBox(height: 16),

                  // Dropdown Kamar
                  Obx(() => DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Kamar',
                          border: OutlineInputBorder(),
                        ),
                        value: controller.selectedKamar.value.isEmpty
                            ? null
                            : controller.selectedKamar.value,
                        onChanged: (value) {
                          controller.selectedKamar.value = value!;
                        },
                        items: controller.kamarList
                            .map((kamar) => DropdownMenuItem(
                                  value: kamar,
                                  child: Text(kamar),
                                ))
                            .toList(),
                      )),
                  SizedBox(height: 16),

                  // Dropdown Kategori Pengeluaran
                  Obx(() => DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Kategori Pengeluaran',
                          border: OutlineInputBorder(),
                        ),
                        value: controller.selectedKategori.value.isEmpty
                            ? null
                            : controller.selectedKategori.value,
                        onChanged: (value) {
                          controller.selectedKategori.value = value!;
                        },
                        items: controller.kategoriList
                            .map((kategori) => DropdownMenuItem(
                                  value: kategori,
                                  child: Text(kategori),
                                ))
                            .toList(),
                      )),
                  SizedBox(height: 16),

                  // Input Keterangan
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Keterangan',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 4,
                    onChanged: (value) {
                      controller.keterangan.value = value;
                    },
                  ),
                  SizedBox(height: 16),

                  // Input Jumlah Pengeluaran
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Jumlah Pengeluaran',
                      border: OutlineInputBorder(),
                      prefixText: 'Rp ',
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      controller.jumlahPengeluaran.value = value;
                    },
                  ),
                  SizedBox(
                      height:
                          100), // Spacing agar konten tidak overlap dengan tombol
                ],
              ),
            ),
          ),

          // Sticky Button
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Logika untuk menyimpan data
                    print('Pengeluaran disimpan');
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    'Simpan',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
