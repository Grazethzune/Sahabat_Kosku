import 'dart:ffi';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahabatkosku/app/page/page_pemilik_kos/buat_kos/atur_kamar.dart';

class DataKosScreen extends StatelessWidget {
  final TextEditingController namaKosController = TextEditingController();
  final TextEditingController aturanController = TextEditingController();
  final TextEditingController provinsiController = TextEditingController();
  final TextEditingController kotaController = TextEditingController();
  final TextEditingController kecamatanController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController longTitudeController = TextEditingController();
  final TextEditingController latTitudeController = TextEditingController();
  final TextEditingController fotoDepanController = TextEditingController();
  final TextEditingController fotoDalamController = TextEditingController();
  final TextEditingController fotoSekitarController = TextEditingController();
  late String gender = '';

  final User? user = FirebaseAuth.instance.currentUser;

  // List fasilitas dengan RxBool untuk status terpilih dan TextEditingController untuk deskripsi
  final List<Map<String, dynamic>> fasilitasUmum = [
    {
      "name": "TV",
      "isSelected": false.obs,
      "controller": TextEditingController(),
    },
    {
      "name": "Kamar Mandi Luar",
      "isSelected": false.obs,
      "controller": TextEditingController(),
    },
    {
      "name": "Ruang Istirahat",
      "isSelected": false.obs,
      "controller": TextEditingController(),
    },
    {
      "name": "Wi-Fi",
      "isSelected": false.obs,
      "controller": TextEditingController(),
    },
    {
      "name": "Dapur",
      "isSelected": false.obs,
      "controller": TextEditingController(),
    },
  ];

  final List<Map<String, dynamic>> fasilitasParkir = [
    {
      "name": "Roda 2",
      "isSelected": false.obs,
      "controller": TextEditingController(),
    },
    {
      "name": "Roda 4",
      "isSelected": false.obs,
      "controller": TextEditingController(),
    },
    {
      "name": "Campur",
      "isSelected": false.obs,
      "controller": TextEditingController(),
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Column(
          children: [
            const Text(
              "Data Kos",
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(height: 5),
            const Text(
              "Langkah 1 dari 2",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              // Nama Kos
              Row(
                children: [
                  const Text("Apa nama kos ini? "),
                  const Text(
                    "*",
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
              TextField(
                controller: namaKosController,
                decoration: InputDecoration(
                  hintText: "Masukkan nama kos",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              // Gender
              Row(
                children: [
                  const Text("Kos untuk laki-laki/perempuan? "),
                  const Text(
                    "*",
                    style: TextStyle(color: Colors.red),
                  )
                ],
              ),
              DropdownButtonFormField<String>(
                items: ["Laki-laki", "Perempuan", "Campur"].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  gender = value!;
                },
                decoration: InputDecoration(
                  hintText: "Pilih Jenis Kelamin",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              // Peraturan Kos
              const Text("Peraturan kos"),
              TextField(
                controller: aturanController,
                decoration: InputDecoration(
                  hintText: "Masukkan aturan kos (Opsional)",
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),
              // Lokasi Kos
              const Text(
                "Lokasi Kos",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              // Tombol Lokasi
              Container(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // Add logic to get current location
                    },
                    icon: const Icon(Icons.location_on, color: Colors.red),
                    label: const Text("Posisikan kos tepat saya berada"),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.blue),
                    ),
                  )),

              const SizedBox(height: 16),
              // Provinsi
              Row(
                children: [
                  const Text("Provinsi "),
                  const Text(
                    "*",
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),

              TextField(
                controller: provinsiController,
                decoration: InputDecoration(
                  hintText: "Pilih provinsi",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              // Kabupaten/Kota
              Row(
                children: [
                  const Text("Kabupaten/Kota "),
                  const Text(
                    "*",
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
              TextField(
                controller: kotaController,
                decoration: InputDecoration(
                  hintText: "Pilih kabupaten/kota",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              // Kecamatan
              Row(
                children: [
                  const Text("Kecamatan "),
                  const Text(
                    "*",
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),

              TextField(
                controller: kecamatanController,
                decoration: InputDecoration(
                  hintText: "Pilih kecamatan",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              // Kecamatan
              Row(
                children: [
                  const Text("Alamat "),
                  const Text(
                    "*",
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),

              TextField(
                controller: alamatController,
                decoration: InputDecoration(
                  hintText: "Masukkan Alamat",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),
              // Section Foto Kos
              const Text(
                "Foto Kos",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              // Foto Kos Tampak Depan
              buildUploadField(
                label: "Foto kos tampak depan *",
                controller: fotoDepanController,
              ),
              const SizedBox(height: 16),

              // Foto Dalam Bangunan
              buildUploadField(
                label: "Foto dalam bangunan kos *",
                controller: fotoDalamController,
              ),
              const SizedBox(height: 16),

              // Foto Sekitar Kos
              buildUploadField(
                label: "Foto sekitar kos *",
                controller: fotoSekitarController,
              ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),

              // Section Fasilitas Kos
              const Text(
                "Fasilitas Kos",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(children: [
                const Text(
                  "Fasilitas Umum ",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "*",
                  style: TextStyle(color: Colors.red),
                )
              ]),
              const SizedBox(height: 8),

              // Dynamic Checkbox List for Facilities with Descriptions
              Column(
                children: fasilitasUmum.map((fasilitas) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() => Row(
                            children: [
                              Checkbox(
                                value: fasilitas["isSelected"].value,
                                onChanged: (value) {
                                  fasilitas["isSelected"].value =
                                      value ?? false;
                                },
                              ),
                              Text(fasilitas["name"]),
                            ],
                          )),
                      // Deskripsi Fasilitas (Tampil Jika Checkbox Terpilih)
                      Obx(() {
                        if (fasilitas["isSelected"].value) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 40.0),
                            child: TextField(
                              controller: fasilitas["controller"],
                              decoration: InputDecoration(
                                hintText:
                                    "Masukkan deskripsi ${fasilitas["name"]} (Opsional)",
                                border: OutlineInputBorder(),
                              ),
                              maxLines: 3,
                            ),
                          );
                        } else {
                          return Container();
                        }
                      }),
                      const SizedBox(height: 16),
                    ],
                  );
                }).toList(),
              ),
              SizedBox(height: 10),
              const SizedBox(height: 8),
              Row(children: [
                const Text(
                  "Fasilitas Umum ",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "*",
                  style: TextStyle(color: Colors.red),
                )
              ]),
              const SizedBox(height: 8),

              // Dynamic Checkbox List for Facilities with Descriptions
              Column(
                children: fasilitasParkir.map((fasilitas) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() => Row(
                            children: [
                              Checkbox(
                                value: fasilitas["isSelected"].value,
                                onChanged: (value) {
                                  fasilitas["isSelected"].value =
                                      value ?? false;
                                },
                              ),
                              Text(fasilitas["name"]),
                            ],
                          )),
                      // Deskripsi Fasilitas (Tampil Jika Checkbox Terpilih)
                      Obx(() {
                        if (fasilitas["isSelected"].value) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 40.0),
                            child: TextField(
                              controller: fasilitas["controller"],
                              decoration: InputDecoration(
                                hintText:
                                    "Masukkan deskripsi ${fasilitas["name"]} (Opsional)",
                                border: OutlineInputBorder(),
                              ),
                              maxLines: 3,
                            ),
                          );
                        } else {
                          return Container();
                        }
                      }),
                      const SizedBox(height: 16),
                    ],
                  );
                }).toList(),
              ),

              // Button Selanjutnya
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(DataKamarScreen(
                      namaKosController: namaKosController.text,
                      aturanController: aturanController.text,
                      provinsiController: provinsiController.text,
                      kotaController: kotaController.text,
                      kecamatanController: kecamatanController.text,
                      alamatController: alamatController.text,
                      longTitudeController: longTitudeController.text,
                      latTitudeController: latTitudeController.text,
                      gender: gender,
                      kosId:
                          '${user!.uid}_${Random().nextInt(999) + Random().nextInt(1000)}',
                      fasilitasUmum: convertFasilitasToMap(fasilitasUmum),
                      fasilitasParkir: convertFasilitasToMap(fasilitasParkir),
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text(
                    "Selanjutnya",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to create upload field
  Widget buildUploadField(
      {required String label, required TextEditingController controller}) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: "Pilih file",
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: () {
            // Add upload file logic here
          },
          child: const Text("Upload Foto"),
        ),
      ],
    );
  }

  Map<String, dynamic> convertFasilitasToMap(
      List<Map<String, dynamic>> fasilitas) {
    return {
      for (var item in fasilitas)
        item["name"]: {
          "isSelected": item["isSelected"].value, // Mengambil nilai boolean
          "description": item["controller"]
              .text, // Mengambil teks dari TextEditingController
        }
    };
  }
}
