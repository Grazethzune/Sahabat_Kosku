import 'package:get/get.dart';

class KosController extends GetxController {
  var ownerName = 'Nama Pemilik Kos'.obs;
  var ownerPhone = 'No. Telepon'.obs;
  var kosName = 'Nama Kos'.obs;
  var lantai = 'Lantai'.obs;
  var no_Ruang = 'no Ruang'.obs;
  var location = 'Lokasi'.obs;
  var facilities = 'Fasilitas'.obs;
  var status_konfirmasi = 'Menunggu'.obs;

  void rejectKos() {
    // Logic for rejecting kos
  }

  void acceptKos() {
    // Logic for accepting kos
  }
}
