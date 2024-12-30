import 'package:get/get.dart';

class TagihanOtomatis extends GetxController {
  var selectedTenant = ''.obs;
  var messageContent = ''.obs;
  var deliveryTime = 'Kirim 1 H sebelum pembayaran'.obs;
  var isTagihOtomatisActive = false.obs;
  var status_tagihan = 'Tidak aktif'.obs;

  void save() {
    // Simpan logika, misalnya mengirim data ke server
    print("Tenant: ${selectedTenant.value}");
    print("Pesan: ${messageContent.value}");
    print("Waktu Pengiriman: ${deliveryTime.value}");
    print("Status Penagihan Otomatis: ${isTagihOtomatisActive.value}");
  }
}
