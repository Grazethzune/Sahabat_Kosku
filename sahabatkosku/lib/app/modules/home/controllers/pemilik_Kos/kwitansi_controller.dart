import 'package:get/get.dart';

class KwitansiController extends GetxController {
  var namaPenghuni = ''.obs;
  var telpPenghuni = ''.obs;
  var selectedKos = ''.obs;
  var selectedLantai = ''.obs;
  var selectedKamar = ''.obs;
  var selectedWaktu = ''.obs;
  var sampaiKe = ''.obs;
  var hariIni = ''.obs;
  var sampaiTanggal = ''.obs;
  var totalBayar = ''.obs;
  var statusPembayaran = 'Lunas'.obs;
  var reminder = ''.obs;
  var tanggalKwitansi = DateTime.parse('2024-10-30').obs;
  var selectedTab = 'Pencari Kos'.obs;

  List<String> kosList = ['Kos A', 'Kos B', 'Kos C'];
  List<String> lantaiList = ['Lantai 1', 'Lantai 2', 'Lantai 3'];
  List<String> kamarList = ['Kamar 101', 'Kamar 102', 'Kamar 103'];
  List<String> statusList = ['Lunas', 'Belum Lunas'];
  List<String> tenggatWaktuList = ['Harian', 'Bulanan', 'Tahunan'];
  List<String> sampaiKeList = ['1', '2', '3'];
  List<String> reminderList = [
    '1 H Sebelumnya',
    '2 H Sebelumnya',
    '3 H Sebelumnya'
  ];

  void selectTab(String tab) {
    selectedTab.value = tab;
  }
}
