import 'package:get/get.dart';

class FilterController extends GetxController {
  var selectedGender = ''.obs;
  var paymentOption = ''.obs;
  var isNotificationEnabled = false.obs;

  void resetFilters() {
    selectedGender.value = '';
    paymentOption.value = '';
  }
}
