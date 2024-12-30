import 'dart:ffi';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahabatkosku/app/page/page_pemilik_kos/nav_bar_pencari_kos.dart';
import 'package:sahabatkosku/app/page/page_pemilik_kos/properti_page.dart';

class DataKamarScreen extends StatelessWidget {
  final TextEditingController NomorKamarController = TextEditingController();
  final TextEditingController lantaiConntroller = TextEditingController();
  final TextEditingController luasConntroller = TextEditingController();
  final TextEditingController fotoDalamController = TextEditingController();
  final TextEditingController fotoDepanController = TextEditingController();
  final TextEditingController fotoKamarMandiController =
      TextEditingController();
  final TextEditingController hargaController = TextEditingController();
  final TextEditingController tiapController = TextEditingController();

  String namaKosController = "";
  String aturanController = "";
  String provinsiController = "";
  String kotaController = "";
  String kecamatanController = "";
  String alamatController = "";
  String longTitudeController = "";
  String latTitudeController = "";
  String gender = '';
  String pembayaran = '';
  final Map<String, dynamic> fasilitasUmum;
  final Map<String, dynamic> fasilitasParkir;

  final String kosId;
  final User? user = FirebaseAuth.instance.currentUser;

  DataKamarScreen(
      {required this.namaKosController,
      required this.aturanController,
      required this.provinsiController,
      required this.kotaController,
      required this.kecamatanController,
      required this.alamatController,
      required this.longTitudeController,
      required this.latTitudeController,
      required this.gender,
      required this.kosId,
      required this.fasilitasUmum,
      required this.fasilitasParkir});

  // List fasilitas dengan RxBool untuk status terpilih dan TextEditingController untuk deskripsi
  final List<Map<String, dynamic>> fasilitasKamar = [
    {
      "name": "TV",
      "isSelected": false.obs,
      "controller": TextEditingController(),
    },
    {
      "name": "Lemari",
      "isSelected": false.obs,
      "controller": TextEditingController(),
    },
    {
      "name": "Meja Belajar",
      "isSelected": false.obs,
      "controller": TextEditingController(),
    },
    {
      "name": "Kasur",
      "isSelected": false.obs,
      "controller": TextEditingController(),
    },
  ];

  final List<Map<String, dynamic>> fasilitasKamarMandi = [
    {
      "name": "Handuk",
      "isSelected": false.obs,
      "controller": TextEditingController(),
    },
    {
      "name": "Exhaust",
      "isSelected": false.obs,
      "controller": TextEditingController(),
    },
    {
      "name": "Wather Heater",
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
              "Data Kamar",
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(height: 5),
            const Text(
              "Langkah 2 dari 2",
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
              Row(
                children: [
                  const Text("Nomor Kamar "),
                  const Text(
                    "*",
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
              TextField(
                controller: NomorKamarController,
                decoration: InputDecoration(
                  hintText: "Masukkan nomor kamar",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text("Lantai "),
                  const Text(
                    "*",
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
              TextField(
                controller: lantaiConntroller,
                decoration: InputDecoration(
                  hintText: "Masukkan nomor lantai",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              Row(
                children: [
                  const Text("Luas Kamar "),
                  const Text(
                    "*",
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
              TextField(
                controller: luasConntroller,
                decoration: InputDecoration(
                  hintText: "Masukkan luas kamar",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),
              // Section Foto Kos
              const Text(
                "Foto Kamar",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              // Foto Kos Tampak Depan
              buildUploadField(
                label: "Foto kamar tampak depan *",
                controller: fotoDepanController,
              ),
              const SizedBox(height: 16),

              // Foto Dalam Bangunan
              buildUploadField(
                label: "Foto dalam kamar *",
                controller: fotoDalamController,
              ),
              const SizedBox(height: 16),

              // Foto Dalam Bangunan
              buildUploadField(
                label: "Foto kamar mandi dalam ",
                controller: fotoKamarMandiController,
              ),

              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),

              // Section Fasilitas Kos
              const Text(
                "Fasilitas Kamar",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(children: [
                const Text(
                  "Fasilitas dalam kamar ",
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
                children: fasilitasKamar.map((fasilitas) {
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

              const Text(
                "Fasilitas kamar mandi ",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              // Dynamic Checkbox List for Facilities with Descriptions
              Column(
                children: fasilitasKamarMandi.map((fasilitas) {
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

              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 16),
              const Text(
                "Harga Kamar",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(children: [
                SizedBox(
                  width: 140,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Text("Harga kamar "),
                          const Text(
                            "*",
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                      TextField(
                        controller: hargaController,
                        decoration: InputDecoration(
                          prefix: Text("Rp. "),
                          border: OutlineInputBorder(),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(width: 10),
                SizedBox(
                    width: 120,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Text("Pembayaran "),
                            const Text(
                              "*",
                              style: TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                        DropdownButtonFormField<String>(
                          items: ["Harian", "Bulanan", "Tahunan"]
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            pembayaran = value!;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    )),
                SizedBox(width: 10),
                SizedBox(
                  width: 80,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Text("Tiap? "),
                          const Text(
                            "*",
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                      TextField(
                        controller: tiapController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      )
                    ],
                  ),
                ),
              ]),

              const SizedBox(height: 16),
              // Button Selanjutnya
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    tambahDataKos();
                    tambahDataKamar();
                    Get.off(RoomAvailabilityScreen());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text(
                    "Tambah Kos",
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

  Future<void> tambahDataKos() async {
    if (user == null) return;

    final uid = user!.uid;
    final databaseRef = FirebaseDatabase.instanceFor(
            app: FirebaseDatabase.instance.app,
            databaseURL:
                'https://sahabatkosku-default-rtdb.asia-southeast1.firebasedatabase.app')
        .ref("users/$uid/kos/$kosId");

    await databaseRef.set({
      "namaKos": namaKosController,
      "aturan": aturanController,
      "provinsi": provinsiController,
      "kota": kotaController,
      "kecamatan": kecamatanController,
      "alamat": alamatController,
      "longTitude": longTitudeController,
      "latTitude": latTitudeController,
      "gender": gender,
      "email": user!.email,
      "nama_pemilik": user!.displayName ?? "Nama Pemilik",
      "nomor_telepon":
          "08123456789", // Misalnya, Anda bisa ambil dari controller lain atau profil pengguna
      "fasilitasUmum": fasilitasUmum,
      "fasilitasParkir": fasilitasParkir,
      "kosId": kosId
    });
  }

  Future<void> tambahDataKamar() async {
    if (user == null) return;

    final uid = user!.uid;
    final databaseRef = FirebaseDatabase.instanceFor(
            app: FirebaseDatabase.instance.app,
            databaseURL:
                'https://sahabatkosku-default-rtdb.asia-southeast1.firebasedatabase.app')
        .ref("users/$uid/kos/$kosId/kamar")
        .push();

    await databaseRef.set({
      'kamarId': "${kosId}+${Random().nextDouble() * 1000}",
      "nomorKamar": NomorKamarController.text,
      "lantai": lantaiConntroller.text,
      "luas": luasConntroller.text,
      "fotoDalam": fotoDalamController.text,
      "fotoDepan": fotoDepanController.text,
      "fotoKamarMandi": fotoKamarMandiController.text,
      "harga": hargaController.text,
      "tiap": tiapController.text,
      "pembayaran": pembayaran,
      "fasilitasKamar": convertFasilitasToMap(fasilitasKamar),
      "fasilitasKamarMandi": convertFasilitasToMap(fasilitasKamarMandi),
    });
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
