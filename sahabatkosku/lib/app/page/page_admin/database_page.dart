import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahabatkosku/app/modules/home/controllers/admin/database_controller.dart';

class DataManagementPage extends StatelessWidget {
  final DataController controller =
      Get.put(DataController()); // Inisialisasi Controller

  @override
  Widget build(BuildContext context) {
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
                  hintText: 'Cari data',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
              ),
            ),
            IconButton(
              color: Colors.white,
              icon: const Icon(Icons.filter_alt),
              onPressed: () => {},
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildUserTable(),
            _buildKosTable(),
          ],
        ),
      ),
    );
  }

  Widget _buildUserTable() {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Table Informasi User',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          // Aksi edit user
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          // Aksi tambah user
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(),
            _buildTable(controller.users, isUser: true),
          ],
        ));
  }

  Widget _buildKosTable() {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Table Informasi Kos',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          // Aksi edit user
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          // Aksi tambah user
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(),
            _buildTable(controller.kos, isUser: false),
          ],
        ));
  }

  Widget _buildTable(List data, {required bool isUser}) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Menyesuaikan layout tabel sesuai gambar
        childAspectRatio: 2,
      ),
      itemCount: data.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            // Aksi saat item diklik (untuk edit)
          },
          child: Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(isUser ? data[index].name : data[index].kosName,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(isUser ? data[index].email : data[index].location),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
