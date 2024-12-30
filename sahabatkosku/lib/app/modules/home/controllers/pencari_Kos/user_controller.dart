import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserController_PencariKos extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RxString name = ''.obs;
  RxString email = ''.obs;
  RxString noTelp = ''.obs;
  RxString role = ''.obs;
  RxString jenisKelamin = ''.obs;
  RxString kotaAsal = ''.obs;
  RxString pekerjaan = ''.obs;
  RxString pendidikanTerakhir = ''.obs;
  RxString provinsi = ''.obs;
  RxString statusPernikahan = ''.obs;
  RxString tanggal_lahir = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  // Fetch user data from Firestore
  Future<void> fetchUserData() async {
    try {
      String uid = _auth.currentUser!.uid;
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(uid).get();

      if (userDoc.exists) {
        name.value = userDoc['fullName'];
        email.value = userDoc['email'];
        noTelp.value = userDoc['phoneNumber'];
        role.value = userDoc['role'];
        jenisKelamin.value = userDoc['jenisKelamin'];
        kotaAsal.value = userDoc['kotaAsal'];
        pekerjaan.value = userDoc['pekerjaan'];
        pendidikanTerakhir.value = userDoc['pendidikanTerakhir'];
        provinsi.value = userDoc['provinsi'];
        statusPernikahan.value = userDoc['statusPernikahan'];
        tanggal_lahir.value = userDoc['tanggal_lahir'];
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch user data: ${e.toString()}");
    }
  }

  // Save updated data to Firestore
  Future<void> saveData() async {
    try {
      String uid = _auth.currentUser!.uid;
      await _firestore.collection('users').doc(uid).update({
        'fullName': name.value,
        'email': email.value,
        'phoneNumber': noTelp.value,
        'jenisKelamin': jenisKelamin.value,
        'kotAsal': kotaAsal.value,
        'pekerjaan': pekerjaan.value,
        'pendidikanTerakhir': pendidikanTerakhir.value,
        'provinsi': provinsi.value,
        'statusPernikahan': statusPernikahan.value,
        'tanggal_lahir': tanggal_lahir.value
      });
      Get.snackbar("Success", "Personal data updated successfully");
    } catch (e) {
      Get.snackbar("Error", "Failed to update data: ${e.toString()}");
    }
  }
}
