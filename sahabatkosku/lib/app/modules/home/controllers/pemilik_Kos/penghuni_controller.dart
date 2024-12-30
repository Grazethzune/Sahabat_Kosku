import 'package:get/get.dart';

// Model Penghuni
class Penghuni {
  final String nama;
  final String namaKost;
  final String lantai;
  final String noRuang;
  final String status;
  final String bulananSisa;

  Penghuni({
    required this.nama,
    required this.namaKost,
    required this.lantai,
    required this.noRuang,
    required this.status,
    required this.bulananSisa,
  });
}

// Controller
class PenghuniController extends GetxController {
  var penghuni = <Penghuni>[].obs;
  var selectedTab = 0.obs;
  var nama = ''.obs;
  var namaKos = ''.obs;
  var lantai = ''.obs;
  var noRuang = ''.obs;
  var status = ''.obs;
  var bulananSisa = ''.obs;

  void fetchPenghuni() {
    var kosts = [
      Penghuni(
          nama: 'John Doe',
          namaKost: 'Kost Bahagia',
          lantai: '1',
          noRuang: '101',
          status: 'Aktif',
          bulananSisa: 'Rp 500.000'),
    ];
    penghuni.value = kosts;
  }

  // Fungsi untuk pencarian
  void searchPenghuni(String query) {
    // Implementasi logika pencarian
  }

  // Fungsi untuk mengirim pesan tagihan
  void kirimPesanTagihan() {
    // Implementasi logika mengirim pesan
  }
  // Method to select a tab
  void selectTab(int tab) {
    selectedTab.value = tab;
  }

  @override
  void onInit() {
    super.onInit();
    fetchPenghuni();
  }

  void rejectKos() {
    // Logic for rejecting kos
  }

  void acceptKos() {
    // Logic for accepting kos
  }
}
