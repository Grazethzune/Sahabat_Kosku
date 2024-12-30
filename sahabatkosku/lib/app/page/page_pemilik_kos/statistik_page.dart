import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahabatkosku/app/modules/home/controllers/pemilik_Kos/statistik_controller.dart';
import 'package:sahabatkosku/app/page/page_pemilik_kos/tambah_edit_pengeluaran_page.dart';

// View
class StatistikView extends StatelessWidget {
  final StatistikController controller = Get.put(StatistikController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Statistik'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: DefaultTabController(
        length: 2, // Jumlah tab yang tersedia
        child: Column(
          children: [
            const TabBar(
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.black,
              indicatorColor: Colors.blue,
              tabs: [
                Tab(text: 'Keuangan'),
                Tab(text: 'Okupansi'),
              ],
            ),
            Divider(
              height: 1,
              thickness: 2,
              color: Colors.grey[300],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // Tab for "Keuangan"
                  Stack(
                    children: [
                      Column(
                        children: [
                          const SizedBox(height: 20),
                          SizedBox(
                            width: 350,
                            height: 80,
                            child: Card(
                              color: Colors.grey[200],
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: const [
                                  Text(
                                    'Pemasukkan\n-',
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(width: 30),
                                  Text(
                                    'Pengeluaran\n-',
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: const Text('Transaksi'),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: SizedBox(
                                    child: DropdownButtonFormField(
                                      decoration: InputDecoration(
                                        fillColor: const Color.fromARGB(
                                            255, 235, 233, 233),
                                        labelText: 'Waktu Transaksi',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(32.0),
                                        ),
                                      ),
                                      items: const [
                                        DropdownMenuItem(
                                          value: 'status',
                                          child: Text('Status'),
                                        ),
                                      ],
                                      onChanged: (value) {},
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Divider(),
                          // List of transactions
                          Expanded(
                            child: Obx(() {
                              return buildKeuanganList(
                                  controller.transaksiList);
                            }),
                          ),
                        ],
                      ),
                      // Floating action button at the bottom-right corner
                      Positioned(
                        bottom: 20, // Position it 20px from the bottom
                        right: 20, // Position it 20px from the right
                        child: FloatingActionButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          onPressed: () => Get.to(TambahPengeluaranPage()),
                          backgroundColor: Colors.blue,
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Tab for "Okupansi"
                  Obx(() => buildOkupansiView(controller)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Your other methods like buildKeuanganList and buildOkupansiView go here

  Widget buildKeuanganList(List<Transaksi> transaksiList) {
    // Check if the list is empty
    if (transaksiList.isEmpty) {
      return const Center(child: Text('No transactions available'));
    }

    return ListView.builder(
      itemCount: transaksiList.length,
      itemBuilder: (context, index) {
        var transaksi = transaksiList[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  // Icon showing whether it's an income or expense
                  SizedBox(
                    width: 64,
                    height: 100,
                    child: Icon(
                      (transaksi.isPemasukan == true
                          ? Icons.arrow_upward
                          : Icons.arrow_downward),
                      size: 45,
                      color: transaksi.isPemasukan == true
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Transaction name or description
                        Text(
                          transaksi.namaBarang,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Transaction date
                        Text(
                          '${transaksi.tanggal}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Display the transaction amount and edit/delete buttons
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => Get.to(EditPengeluaranPage()),
                            icon: const Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              // Action for deleting transaction
                              // You can implement delete functionality here
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                      // Transaction amount
                      Text(
                        (transaksi.isPemasukan == true
                            ? '+ Rp ${transaksi.jumlah}'
                            : '- Rp ${transaksi.jumlah}'),
                        style: TextStyle(
                          color: transaksi.isPemasukan == true
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildOkupansiView(StatistikController controller) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Nama Kos', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Obx(() => DropdownButtonFormField<String>(
                value: controller.selectedKos.value,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
                items: ['Semua', 'Kos A', 'Kos B']
                    .map((item) => DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    controller.selectedKos.value = value;
                  }
                },
              )),
          const SizedBox(height: 16),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Semua Kos',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  buildStatisticsRow(
                    icon: Icons.bed,
                    color: Colors.black,
                    label: 'Kamar yang tersedia',
                    value: controller.availableRooms.value.toString(),
                  ),
                  const SizedBox(height: 10),
                  buildStatisticsRow(
                    icon: Icons.check_circle,
                    color: Colors.green,
                    label: 'Kamar kosong',
                    value: controller.emptyRooms.value.toString(),
                  ),
                  const SizedBox(height: 10),
                  buildStatisticsRow(
                    icon: Icons.close,
                    color: Colors.red,
                    label: 'Kamar yang ditempati',
                    value: controller.occupiedRooms.value.toString(),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Tingkat Okupansi ',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      Obx(() => Text(
                            '${controller.occupancyRate.toStringAsFixed(1)}%',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildStatisticsRow({
    required IconData icon,
    required Color color,
    required String label,
    required String value,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(width: 8),
            Text(label),
          ],
        ),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
