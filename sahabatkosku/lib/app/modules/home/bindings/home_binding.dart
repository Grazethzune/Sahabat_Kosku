import 'package:get/get.dart';
import 'package:sahabatkosku/app/modules/home/controllers/pemilik_Kos/penghuni_controller.dart';
import 'package:sahabatkosku/app/modules/home/controllers/pencari_Kos/filter_controller.dart';
import 'package:sahabatkosku/app/modules/home/controllers/login_controller.dart';

import '../controllers/pencari_Kos/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
    Get.lazyPut<FilterController>(
      () => FilterController(),
    );
    Get.lazyPut<PenghuniController>(
      () => PenghuniController(),
    );
  }
}
