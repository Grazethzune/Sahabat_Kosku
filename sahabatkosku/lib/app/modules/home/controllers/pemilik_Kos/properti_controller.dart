import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class PropertiModel {
  final String kosId;
  final String namaKos;
  final String aturan;
  final String provinsi;
  final String kota;
  final String kecamatan;
  final String alamat;
  final String longTitude;
  final String latTitude;
  final String gender;
  final String email;
  final String namaPemilik;
  final String nomorTelepon;
  final List<Map> fasilitasUmum;
  final List<Map> fasilitasParkir;
  final List<Map> kamar;

  PropertiModel(
      {required this.kosId,
      required this.namaKos,
      required this.aturan,
      required this.provinsi,
      required this.kota,
      required this.kecamatan,
      required this.alamat,
      required this.longTitude,
      required this.latTitude,
      required this.gender,
      required this.email,
      required this.namaPemilik,
      required this.nomorTelepon,
      required this.fasilitasUmum,
      required this.fasilitasParkir,
      required this.kamar});

  // Factory method to create a PropertiModel from Firebase snapshot
  factory PropertiModel.fromSnapshot(DataSnapshot snapshot) {
    final data = snapshot.value as Map;

    // Convert fasilitasUmum and fasilitasParkir to List if they are maps
    List<Map> convertToList(dynamic value) {
      if (value is Map) {
        return value.entries.map((entry) {
          return {
            entry.key: {
              'description': entry.value['description'] ?? '',
              'isSelected': entry.value['isSelected'] ?? false,
            }
          };
        }).toList();
      } else if (value is List) {
        return value.cast<Map<String, dynamic>>();
      }
      return [];
    }

    List<Map> convertToKamarList(dynamic value) {
      if (value is Map) {
        return value.entries.map((entry) {
          return {
            entry.key: {
              'kamarId': entry.value['kamarId'] ?? '',
              'fotoDalam': entry.value['fotoDalam'] ?? '',
              'fotoDepan': entry.value['fotoDepan'] ?? '',
              'fotoKamarMandi': entry.value['fotoKamarMandi'] ?? '',
              'harga': entry.value['harga'] ?? '',
              'lantai': entry.value['lantai'] ?? '',
              'luas': entry.value['luas'] ?? '',
              'nomorKamar': entry.value['nomorKamar'] ?? '',
              'tiap': entry.value['tiap'] ?? '',
              'pembayaran': entry.value['pembayaran'] ?? '',
              'fasilitasKamar': entry.value['fasilitasKamar'] ?? '',
              'fasilitasKamarMandi': entry.value['fasilitasKamarMandi'] ?? '',
            }
          };
        }).toList();
      } else if (value is List) {
        return value.cast<Map<String, dynamic>>();
      }
      return [];
    }

    return PropertiModel(
        kosId: data['kosId'] ?? '',
        namaKos: data['namaKos'] ?? '',
        aturan: data['aturan'] ?? '',
        provinsi: data['provinsi'] ?? '',
        kota: data['kota'] ?? '',
        kecamatan: data['kecamatan'] ?? '',
        alamat: data['alamat'] ?? '',
        longTitude: data['longTitude'] ?? '',
        latTitude: data['latTitude'] ?? '',
        gender: data['gender'] ?? '',
        email: data['email'] ?? '',
        namaPemilik: data['nama_pemilik'] ?? '',
        nomorTelepon: data['nomor_telepon'] ?? '',
        fasilitasUmum: convertToList(data['fasilitasUmum']),
        fasilitasParkir: convertToList(data['fasilitasParkir']),
        kamar: convertToKamarList(data['kamar']));
  }
}

class PropertiController extends GetxController {
  RxList<PropertiModel> kostList = <PropertiModel>[].obs;

  final DatabaseReference databaseRef = FirebaseDatabase.instanceFor(
          app: FirebaseDatabase.instance.app,
          databaseURL:
              'https://sahabatkosku-default-rtdb.asia-southeast1.firebasedatabase.app')
      .ref("users/${FirebaseAuth.instance.currentUser?.uid}/kos");

  @override
  void onInit() {
    super.onInit();
    fetchDataFromFirebase();
    print("users/${FirebaseAuth.instance.currentUser?.uid}/kos");
  }

  // Function to fetch data from Firebase and listen to real-time updates
  void fetchDataFromFirebase() {
    databaseRef.onValue.listen((event) {
      if (event.snapshot.value != null) {
        final data = event.snapshot.children.map((snapshot) {
          return PropertiModel.fromSnapshot(snapshot);
        }).toList();

        kostList.assignAll(data);
      } else {
        print("clear");
        kostList.clear();
      }
    });
  }
}
