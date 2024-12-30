import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahabatkosku/app/modules/home/controllers/pemilik_Kos/tagihan_otomatis.dart';

class tagihOtomatisScreen extends StatelessWidget {
  final TagihanOtomatis controller = Get.put(TagihanOtomatis());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jadwalkan Tagihan Otomatis'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dropdown Pilih Penghuni
            Text('Penghuni *'),
            Obx(() => DropdownButton<String>(
                  isExpanded: true,
                  value: controller.selectedTenant.value.isEmpty
                      ? null
                      : controller.selectedTenant.value,
                  hint: Text('Pilih penghuni'),
                  items: ['Penghuni 1', 'Penghuni 2', 'Penghuni 3']
                      .map((tenant) => DropdownMenuItem<String>(
                            value: tenant,
                            child: Text(tenant),
                          ))
                      .toList(),
                  onChanged: (value) {
                    controller.selectedTenant.value = value ?? '';
                  },
                )),

            SizedBox(height: 20),

            // Isi Pesan
            Text('Isi Pesan *'),
            TextField(
              onChanged: (value) {
                controller.messageContent.value = value;
              },
              decoration: InputDecoration(
                hintText: 'Silahkan isi pesan',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),

            SizedBox(height: 20),

            // Waktu Pengiriman
            Text('Waktu Pengiriman *'),
            Obx(() => DropdownButton<String>(
                  isExpanded: true,
                  value: controller.deliveryTime.value,
                  items: [
                    'Kirim 1 H sebelum pembayaran',
                    'Kirim 3 H sebelum pembayaran',
                    'Kirim 7 H sebelum pembayaran',
                  ]
                      .map((time) => DropdownMenuItem<String>(
                            value: time,
                            child: Text(time),
                          ))
                      .toList(),
                  onChanged: (value) {
                    controller.deliveryTime.value = value ?? '';
                  },
                )),

            SizedBox(height: 20),

            // Status Penagihan Otomatis
            Text('Status penagihan otomatis *'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() => Text(controller.status_tagihan.value)),
                Obx(() => Switch(
                      activeTrackColor: Colors.blue,
                      value: controller.isTagihOtomatisActive.value,
                      onChanged: (value) {
                        controller.isTagihOtomatisActive.value = value;
                        if (controller.status_tagihan.value == 'Tidak aktif') {
                          controller.status_tagihan.value = 'Aktif';
                          print('aktif');
                        } else {
                          controller.status_tagihan.value = 'Tidak aktif';
                        }
                      },
                    )),
              ],
            ),

            SizedBox(height: 20),

            // Tombol Simpan
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => {},
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  'Simpan',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
