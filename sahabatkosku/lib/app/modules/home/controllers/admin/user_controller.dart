import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserController_Admin extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RxString name = ''.obs;
  RxString email = ''.obs;
  RxString noTelp = ''.obs;
  RxString role = ''.obs;

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
      });
      Get.snackbar("Success", "Personal data updated successfully");
    } catch (e) {
      Get.snackbar("Error", "Failed to update data: ${e.toString()}");
    }
  }
}
