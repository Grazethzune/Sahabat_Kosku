import 'package:get/get.dart';

class PengeluaranController extends GetxController {
  var selectedKos = ''.obs;
  var selectedLantai = ''.obs;
  var selectedKamar = ''.obs;
  var selectedKategori = ''.obs;
  var tanggal = ''.obs;
  var keterangan = ''.obs;
  var jumlahPengeluaran = ''.obs;

  List<String> kosList = ['Kos A', 'Kos B', 'Kos C'];
  List<String> lantaiList = ['Lantai 1', 'Lantai 2', 'Lantai 3'];
  List<String> kamarList = ['Kamar 101', 'Kamar 102', 'Kamar 103'];
  List<String> kategoriList = ['Air', 'Listrik', 'Internet'];
}
