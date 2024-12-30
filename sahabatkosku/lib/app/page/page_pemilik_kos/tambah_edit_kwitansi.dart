import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sahabatkosku/app/modules/home/controllers/pemilik_Kos/kwitansi_controller.dart';

class TambahKwitansiPage extends StatelessWidget {
  final KwitansiController controller = Get.put(KwitansiController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambahkan Kwitansi'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // No. Kwitansi (Read-Only)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'No. Kwitansi',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 20),
                  Container(
                    width: 120,
                    height: 40,
                    color: Colors.grey[300],
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Detail Sewa
              Text('Detail Sewa *',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),

              // Nama Penghuni
              TextField(
                decoration: InputDecoration(
                  labelText: 'Nama Penghuni',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  controller.namaPenghuni.value = value;
                },
              ),
              SizedBox(height: 16),

              // No. Telp Penghuni
              TextField(
                decoration: InputDecoration(
                  labelText: 'No. Telp Penghuni',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  controller.telpPenghuni.value = value;
                },
              ),
              SizedBox(height: 16),

              // Dropdown Nama Kos, Lantai, No. Kamar
              Row(
                children: [
                  SizedBox(
                    width: 110,
                    child: Obx(() => DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: 'Pilih Kos',
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
                  ),
                  SizedBox(width: 8),
                  SizedBox(
                    width: 107,
                    child: Obx(() => DropdownButtonFormField<String>(
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
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Obx(() => DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: 'No. Kamar',
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
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Detail Tenggat Waktu
              Text('Detail Tenggat Waktu *',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),

              // Bulanan
              Obx(() => DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Pilih waktu',
                      border: OutlineInputBorder(),
                    ),
                    value: controller.selectedWaktu.value.isEmpty
                        ? null
                        : controller.selectedWaktu.value,
                    onChanged: (value) {
                      controller.selectedWaktu.value = value!;
                    },
                    items: controller.tenggatWaktuList
                        .map((kamar) => DropdownMenuItem(
                              value: kamar,
                              child: Text(kamar),
                            ))
                        .toList(),
                  )),
              SizedBox(height: 16),

              // Sampai Bulan ke
              Obx(() => DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Sampai ${controller.selectedWaktu.value} ke',
                      border: OutlineInputBorder(),
                    ),
                    value: controller.sampaiKe.value.isEmpty
                        ? null
                        : controller.sampaiKe.value,
                    onChanged: (value) {
                      controller.sampaiKe.value = value!;
                    },
                    items: controller.sampaiKeList
                        .map((kamar) => DropdownMenuItem(
                              value: kamar,
                              child: Text(kamar),
                            ))
                        .toList(),
                  )),
              SizedBox(height: 16),

              // Tanggal Hari Ini dan Sampai
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Hari ini',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        controller.hariIni.value = value;
                      },
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Sampai',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        controller.sampaiTanggal.value = value;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Total Bayar dan Status Pembayaran
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Total Bayar',
                        border: OutlineInputBorder(),
                        prefixText: 'Rp ',
                      ),
                      onChanged: (value) {
                        controller.totalBayar.value = value;
                      },
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Obx(() => DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: 'Status Pembayaran',
                            border: OutlineInputBorder(),
                          ),
                          value: controller.statusPembayaran.value.isEmpty
                              ? null
                              : controller.statusPembayaran.value,
                          onChanged: (value) {
                            controller.statusPembayaran.value = value!;
                          },
                          items: controller.statusList
                              .map((status) => DropdownMenuItem(
                                    value: status,
                                    child: Text(status),
                                  ))
                              .toList(),
                        )),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Dropdown Remainder
              Obx(() => DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Remainder',
                      border: OutlineInputBorder(),
                    ),
                    value: controller.reminder.value.isEmpty
                        ? null
                        : controller.reminder.value,
                    onChanged: (value) {
                      controller.reminder.value = value!;
                    },
                    items: controller.reminderList
                        .map((reminder) => DropdownMenuItem(
                              value: reminder,
                              child: Text(reminder),
                            ))
                        .toList(),
                  )),
              SizedBox(height: 24),

              // Button Buat Kwitansi
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[700],
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                  ),
                  onPressed: () {
                    // Logika untuk membuat kwitansi
                    print('Kwitansi dibuat');
                  },
                  child: Text(
                    'Buat Kwitansi',
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
}

class editKwitansiPage extends StatelessWidget {
  final KwitansiController controller = Get.put(KwitansiController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Kwitansi'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // No. Kwitansi (Read-Only)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'No. Kwitansi',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 20),
                  Container(
                    width: 120,
                    height: 40,
                    color: Colors.grey[300],
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Detail Sewa
              Text('Detail Sewa *',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),

              // Nama Penghuni
              TextField(
                decoration: InputDecoration(
                  labelText: 'Nama Penghuni',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  controller.namaPenghuni.value = value;
                },
              ),
              SizedBox(height: 16),

              // No. Telp Penghuni
              TextField(
                decoration: InputDecoration(
                  labelText: 'No. Telp Penghuni',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  controller.telpPenghuni.value = value;
                },
              ),
              SizedBox(height: 16),

              // Dropdown Nama Kos, Lantai, No. Kamar
              Row(
                children: [
                  SizedBox(
                    width: 110,
                    child: Obx(() => DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: 'Pilih Kos',
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
                  ),
                  SizedBox(width: 8),
                  SizedBox(
                    width: 107,
                    child: Obx(() => DropdownButtonFormField<String>(
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
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Obx(() => DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: 'No. Kamar',
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
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Detail Tenggat Waktu
              Text('Detail Tenggat Waktu *',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),

              // Bulanan
              Obx(() => DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Pilih waktu',
                      border: OutlineInputBorder(),
                    ),
                    value: controller.selectedWaktu.value.isEmpty
                        ? null
                        : controller.selectedWaktu.value,
                    onChanged: (value) {
                      controller.selectedWaktu.value = value!;
                    },
                    items: controller.tenggatWaktuList
                        .map((kamar) => DropdownMenuItem(
                              value: kamar,
                              child: Text(kamar),
                            ))
                        .toList(),
                  )),
              SizedBox(height: 16),

              // Sampai Bulan ke
              Obx(() => DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Sampai ${controller.selectedWaktu.value} ke',
                      border: OutlineInputBorder(),
                    ),
                    value: controller.sampaiKe.value.isEmpty
                        ? null
                        : controller.sampaiKe.value,
                    onChanged: (value) {
                      controller.sampaiKe.value = value!;
                    },
                    items: controller.sampaiKeList
                        .map((kamar) => DropdownMenuItem(
                              value: kamar,
                              child: Text(kamar),
                            ))
                        .toList(),
                  )),
              SizedBox(height: 16),

              // Tanggal Hari Ini dan Sampai
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Hari ini',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        controller.hariIni.value = value;
                      },
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Sampai',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        controller.sampaiTanggal.value = value;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Total Bayar dan Status Pembayaran
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Total Bayar',
                        border: OutlineInputBorder(),
                        prefixText: 'Rp ',
                      ),
                      onChanged: (value) {
                        controller.totalBayar.value = value;
                      },
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Obx(() => DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: 'Status Pembayaran',
                            border: OutlineInputBorder(),
                          ),
                          value: controller.statusPembayaran.value.isEmpty
                              ? null
                              : controller.statusPembayaran.value,
                          onChanged: (value) {
                            controller.statusPembayaran.value = value!;
                          },
                          items: controller.statusList
                              .map((status) => DropdownMenuItem(
                                    value: status,
                                    child: Text(status),
                                  ))
                              .toList(),
                        )),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Dropdown Remainder
              Obx(() => DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Remainder',
                      border: OutlineInputBorder(),
                    ),
                    value: controller.reminder.value.isEmpty
                        ? null
                        : controller.reminder.value,
                    onChanged: (value) {
                      controller.reminder.value = value!;
                    },
                    items: controller.reminderList
                        .map((reminder) => DropdownMenuItem(
                              value: reminder,
                              child: Text(reminder),
                            ))
                        .toList(),
                  )),
              SizedBox(height: 24),

              // Button Buat Kwitansi
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[700],
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Simpan Kwitansi',
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
}
