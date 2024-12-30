import 'package:get/get.dart';

class UserModel {
  String name;
  String email;

  UserModel({required this.name, required this.email});
}

class KosModel {
  String kosName;
  String location;

  KosModel({required this.kosName, required this.location});
}

class DataController extends GetxController {
  // Data List untuk User dan Kos
  var users = <UserModel>[].obs;
  var kos = <KosModel>[].obs;

  // Menambah User
  void addUser(String name, String email) {
    users.add(UserModel(name: name, email: email));
  }

  // Mengedit User
  void editUser(int index, String name, String email) {
    users[index].name = name;
    users[index].email = email;
    users.refresh(); // Menyegarkan data agar UI terupdate
  }

  // Menambah Kos
  void addKos(String kosName, String location) {
    kos.add(KosModel(kosName: kosName, location: location));
  }

  // Mengedit Kos
  void editKos(int index, String kosName, String location) {
    kos[index].kosName = kosName;
    kos[index].location = location;
    kos.refresh();
  }
}
