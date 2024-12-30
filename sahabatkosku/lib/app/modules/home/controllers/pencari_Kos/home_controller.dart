import 'package:get/get.dart';

class KostModel {
  final String name;
  final String location;
  final String facilities;
  final String price;
  final String rating;
  final String gender;

  KostModel({
    required this.name,
    required this.location,
    required this.facilities,
    required this.price,
    required this.rating,
    required this.gender,
  });
}

class HomeController extends GetxController {
  var kostList = <KostModel>[].obs;
  //TODO: Implement HomeController
  var selectedTab = 0.obs;

  void changeTab(int index) {
    selectedTab.value = index;
  }

  void fetchKosts() {
    var kosts = [
      KostModel(
          name: 'Kost A',
          location: 'Jakarta',
          facilities: 'WiFi, AC',
          price: 'Rp 1.000.000',
          rating: '5.0',
          gender: 'Laki-laki'),
      KostModel(
          name: 'Kost B',
          location: 'Bandung',
          facilities: 'WiFi, Parkir',
          price: 'Rp 800.000',
          rating: '4.5',
          gender: 'Perempuan'),
      KostModel(
          name: 'Kost C',
          location: 'Surabaya',
          facilities: 'WiFi, AC, TV',
          price: 'Rp 1.500.000',
          rating: '4.8',
          gender: 'Laki-laki'),
      KostModel(
          name: 'Kost A',
          location: 'Jakarta',
          facilities: 'WiFi, AC',
          price: 'Rp 1.000.000',
          rating: '5.0',
          gender: 'Laki-laki'),
      KostModel(
          name: 'Kost A',
          location: 'Jakarta',
          facilities: 'WiFi, AC',
          price: 'Rp 1.000.000',
          rating: '5.0',
          gender: 'Laki-laki'),
      // Tambahkan data kost lainnya
    ];
    kostList.value = kosts;
  }

  final tabIndex = 0.obs;

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    fetchKosts();
  }
}
