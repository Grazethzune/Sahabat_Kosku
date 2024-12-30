import 'package:get/get.dart';

class Transaksi {
  final String namaBarang;
  final DateTime tanggal;
  final int jumlah;
  final bool isPemasukan;

  Transaksi({
    required this.namaBarang,
    required this.tanggal,
    required this.jumlah,
    this.isPemasukan = false,
  });
}

// Controller
class StatistikController extends GetxController {
  var transaksiList = <Transaksi>[].obs;
  var selectedKos = 'Semua'.obs;
  var availableRooms = 5.obs;
  var emptyRooms = 0.obs;
  var occupiedRooms = 5.obs;

  double get occupancyRate =>
      (occupiedRooms.value / availableRooms.value) * 100;

  void fetchTransaksi() {
    var kosts = [
      Transaksi(
          namaBarang: 'Barang A',
          tanggal: DateTime.now(),
          jumlah: 100000,
          isPemasukan: true),
      Transaksi(
          namaBarang: 'Barang B',
          tanggal: DateTime.now(),
          jumlah: 50000,
          isPemasukan: false),
    ];
    transaksiList.value = kosts;
  }

  @override
  void onInit() {
    super.onInit();
    fetchTransaksi();
  }

  // Fungsi untuk menambahkan transaksi baru
  void tambahTransaksi() {
    // Implementasi untuk menambahkan transaksi baru
  }
}
