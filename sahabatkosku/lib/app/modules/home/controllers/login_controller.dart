import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Untuk Firestore
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sahabatkosku/app/page/page_admin/nav_bar_admin.dart';
import 'package:sahabatkosku/app/page/page_pemilik_kos/nav_bar_pencari_kos.dart';
import 'package:sahabatkosku/app/page/page_pencari_kos/nav_bar_pencari_kos.dart';
import 'package:sahabatkosku/app/page/root_page/login.dart';

class LoginController extends GetxController {
  // Reactive variable for tab selection
  var selectedTab = 'Pencari Kos'.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance; // Instance Firestore
  RxBool isLoading = false.obs;

  // Fungsi untuk registrasi pengguna
  Future<void> registerUser(String email, String password, String fullName,
      String phoneNumber) async {
    try {
      isLoading.value = true;

      // Cek apakah nomor telepon sudah terdaftar di Firestore
      var phoneExists = await _firestore
          .collection('users')
          .where('phoneNumber', isEqualTo: phoneNumber)
          .get();

      if (phoneExists.docs.isNotEmpty) {
        Get.snackbar('Error', 'Nomor yang anda berikan telah terdaftar',
            backgroundColor: Colors.red);
        isLoading.value = false;
        return; // Berhenti jika nomor sudah terdaftar
      }

      // Registrasi pengguna dengan email dan password
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (selectedTab.value == 'Pencari Kos') {
        await _firestore.collection('users').doc(userCredential.user?.uid).set({
          'fullName': fullName,
          'email': email,
          'phoneNumber': phoneNumber, // Simpan nomor telepon
          'role': selectedTab.value,
          'jenisKelamin': '',
          'tanggal_lahir': '',
          'pekerjaan': '',
          'pendidikanTerakhir': '',
          'statusPernikahan': '',
          'provinsi': '',
          'kotaAsal': '',
          'createdAt': FieldValue.serverTimestamp(), // Tanggal registrasi
        });
      } else {
        // Simpan data pengguna ke Firestore
        await _firestore.collection('users').doc(userCredential.user?.uid).set({
          'fullName': fullName,
          'email': email,
          'phoneNumber': phoneNumber, // Simpan nomor telepon
          'role': selectedTab.value,
          'createdAt': FieldValue.serverTimestamp(), // Tanggal registrasi
        });
      }

      Get.snackbar('Success', 'Registration successful',
          backgroundColor: Colors.green);
      Get.off(LoginScreen()); // Beralih ke halaman Login setelah registrasi
    } catch (error) {
      Get.snackbar('Error', 'Registration failed: $error',
          backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  // Fungsi untuk login pengguna
  Future<void> loginUser(String email, String password) async {
    try {
      isLoading.value = true;
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      DocumentSnapshot userDoc = await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();
      String userRole = userDoc['role'];

      // Check if the user role matches the selected role
      if (userRole != selectedTab.value && userRole != 'Admin') {
        Get.snackbar(
          "Login Gagal",
          "Akun anda telah terdaftar sebagai $userRole. Silakan gunakan akun lainnya.",
        );
        print('nama user: ${userCredential.user?.uid}');
        await _auth.signOut(); // Log out user to prevent access
      } else {
        Get.snackbar('Success', 'Login successful',
            backgroundColor: Colors.green);
        if (selectedTab.value == 'Pencari Kos') {
          Get.to(LandingPage_PencariKos());
        }
        if (selectedTab.value == 'Pemilik Kos') {
          Get.to(LandingPage_PemilikKos());
        }
        if (selectedTab.value == 'Admin') {
          Get.to(LandingPage_Admin());
        }
      }
    } catch (error) {
      if (email.isEmpty || password.isEmpty) {
        Get.snackbar('Error', 'Email dan password tidak boleh kosong',
            backgroundColor: Colors.red);
      } else {
        Get.snackbar('Error', 'Login failed: $error',
            backgroundColor: Colors.red);
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      // Prompt the user to sign in with Google
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return; // User cancelled Google Sign-In

      // Obtain the authentication details from Google
      GoogleSignInAuthentication? googleAuth = await googleUser.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      // Sign in to Firebase with the Google credential
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      String uid = userCredential.user!.uid;

      // Retrieve the user's data from Firestore
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(uid).get();

      // Check if the user document exists
      if (userDoc.exists) {
        // Get the stored role of the user
        String storedRole = userDoc['role'];

        // If the stored role does not match the selected tab, show an error and log out
        if (storedRole != selectedTab.value) {
          Get.snackbar(
            "Login Gagal",
            "Akun anda telah terdaftar sebagai $storedRole. Silakan gunakan akun lainnya.",
            backgroundColor: Colors.red,
          );
          await _auth.signOut(); // Log out the user
          return;
        }
      } else {
        if (selectedTab.value == 'Pencari Kos') {
          await _firestore
              .collection('users')
              .doc(userCredential.user?.uid)
              .set({
            'fullName': userCredential.additionalUserInfo!.profile?['name'],
            'email': userCredential.additionalUserInfo!.profile?['email'],
            'phoneNumber': '', // Simpan nomor telepon
            'role': selectedTab.value,
            'jenisKelamin': '',
            'tanggal_lahir': '',
            'pekerjaan': '',
            'pendidikanTerakhir': '',
            'statusPernikahan': '',
            'provinsi': '',
            'kotaAsal': '',
            'createdAt': FieldValue.serverTimestamp(), // Tanggal registrasi
          });
        } else {
          // Simpan data pengguna ke Firestore
          await _firestore
              .collection('users')
              .doc(userCredential.user?.uid)
              .set({
            'fullName': userCredential.additionalUserInfo!.profile?['name'],
            'email': userCredential.additionalUserInfo!.profile?['email'],
            'phoneNumber': '', // Simpan nomor telepon
            'role': selectedTab.value,
            'createdAt': FieldValue.serverTimestamp(), // Tanggal registrasi
          });
        }
      }

      // Proceed with login and navigate to the correct landing page
      Get.snackbar('Success', 'Login successful',
          backgroundColor: Colors.green);
      if (selectedTab.value == 'Pencari Kos') {
        Get.to(LandingPage_PencariKos());
      } else if (selectedTab.value == 'Pemilik Kos') {
        Get.to(LandingPage_PemilikKos());
      } else if (selectedTab.value == 'Admin') {
        Get.to(LandingPage_Admin());
      }
    } catch (error) {
      Get.snackbar('Error', 'Login failed: $error',
          backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  // Method to select a tab
  void selectTab(String tab) {
    selectedTab.value = tab;
  }
}
