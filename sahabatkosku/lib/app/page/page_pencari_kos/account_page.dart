import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahabatkosku/app/modules/home/controllers/pencari_Kos/user_controller.dart';
import 'package:sahabatkosku/app/page/page_pencari_kos/riwayat_transaksi.dart';
import 'package:sahabatkosku/app/page/root_page/login.dart';

class ProfileView_PencariKos extends StatelessWidget {
  final UserController_PencariKos controller =
      Get.put(UserController_PencariKos());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.grey[300],
                      child: const Icon(Icons.person, size: 50),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(controller.name.value,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold)),
                        Text(controller.role.value,
                            style: const TextStyle(color: Colors.grey)),
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => Get.to(AddPersonalDataView()),
                      icon: const Icon(Icons.edit),
                    )
                  ],
                )),
            const SizedBox(height: 20),
            TabBarSection(),
          ],
        ),
      ),
    );
  }
}

class TabBarSection extends StatelessWidget {
  const TabBarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TabBar(
            labelColor: Colors.blue,
            indicatorColor: Colors.blue,
            tabs: [
              Tab(text: "Data Pribadi"),
              Tab(text: "Lainnya"),
            ],
          ),
          SizedBox(
            height: 300,
            child: TabBarView(
              children: [
                PersonalDataForm(),
                LainnyaTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PersonalDataForm extends StatelessWidget {
  final UserController_PencariKos controller =
      Get.find<UserController_PencariKos>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          PersonalDataField(
              label: "Jenis Kelamin", value: controller.jenisKelamin.value),
          PersonalDataField(
              label: "Tanggal Lahir",
              value: controller.tanggal_lahir.toString()),
          PersonalDataField(
              label: "Pekerjaan", value: controller.pekerjaan.value),
          PersonalDataField(
              label: "Pendidikan Terakhir",
              value: controller.pendidikanTerakhir.value),
          PersonalDataField(
              label: "Status Pernikahan",
              value: controller.statusPernikahan.value),
          PersonalDataField(
              label: "Provinsi", value: controller.provinsi.value),
          PersonalDataField(
              label: "Kota Asal", value: controller.kotaAsal.value),
        ],
      );
    });
  }
}

class PersonalDataField extends StatelessWidget {
  final String label;
  final String value;

  const PersonalDataField(
      {super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 4),
          Container(
            height: 30,
            color: Colors.grey[300],
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(value),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LainnyaTab extends StatelessWidget {
  const LainnyaTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8.0),
      children: [
        ListTile(
          leading: const Icon(Icons.receipt_long, size: 30),
          title: const Text("Riwayat Transaksi"),
          onTap: () => Get.to(riwayatTransaksiView()),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.help_outline, size: 30),
          title: const Text("Bantuan"),
          onTap: () {
            // Navigate to help section
          },
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.logout, size: 30),
          title: const Text("Keluar dari akun"),
          onTap: () => Get.off(LoginScreen()),
        ),
      ],
    );
  }
}

class AddPersonalDataView extends StatelessWidget {
  final UserController_PencariKos controller =
      Get.put(UserController_PencariKos());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Data Pribadi'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey[300],
              child: const Icon(Icons.person, size: 50),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                maximumSize: Size(120, 40),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.edit,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Ubah Foto",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  _buildTextField(
                      label: 'Nama Lengkap',
                      hint: 'Masukkan Nama Lengkap',
                      onChanged: (value) {
                        controller.name.value = value;
                      }),
                  _buildDropdownField(
                      label: 'Jenis Kelamin',
                      hint: 'Pilih Jenis Kelamin',
                      items: ['Laki-laki', 'Perempuan'],
                      onChanged: (value) {
                        controller.jenisKelamin.value = value!;
                      }),
                  _buildTextField(
                      label: 'Tanggal Lahir',
                      hint: 'Masukkan Tanggal Lahir',
                      onChanged: (value) {
                        controller.tanggal_lahir.value = value;
                      }),
                  _buildDropdownField(
                      label: 'Pekerjaan',
                      hint: 'Pilih Pekerjaan',
                      items: ['Mahasiswa', 'Karyawan', 'Wirausaha'],
                      onChanged: (value) {
                        controller.pekerjaan.value = value!;
                      }),
                  _buildDropdownField(
                      label: 'Pendidikan Terakhir',
                      hint: 'Pilih Pendidikan Terakhir',
                      items: ['SMA', 'Diploma', 'Sarjana', 'Magister'],
                      onChanged: (value) {
                        controller.pendidikanTerakhir.value = value!;
                      }),
                  _buildDropdownField(
                      label: 'Status Pernikahan',
                      hint: 'Pilih Status Pernikahan',
                      items: ['Belum Menikah', 'Menikah'],
                      onChanged: (value) {
                        controller.statusPernikahan.value = value!;
                      }),
                  _buildTextField(
                      label: 'Provinsi',
                      hint: 'Masukkan Provinsi',
                      onChanged: (value) {
                        controller.provinsi.value = value;
                      }),
                  _buildTextField(
                      label: 'Kota',
                      hint: 'Masukkan Kota Asal',
                      onChanged: (value) {
                        controller.kotaAsal.value = value;
                      }),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: controller.saveData,
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
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      {required String label,
      required String hint,
      required Function(String) onChanged}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 4),
          TextField(
            decoration: InputDecoration(
              hintText: hint,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownField(
      {required String label,
      required String hint,
      required List<String> items,
      required Function(String?) onChanged}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 4),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            hint: Text(hint),
            items: items
                .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    ))
                .toList(),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
