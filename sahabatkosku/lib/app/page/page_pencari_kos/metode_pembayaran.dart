import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MetodePembayaranScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pembayaran Kos"),
        backgroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: const TextStyle(color: Colors.black, fontSize: 18),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Metode Pembayaran",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Divider(),
          const SizedBox(height: 80),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset('assets/images/BCA.png', height: 150),
                  Image.asset('assets/images/BRI.png', height: 65),
                ],
              ),
              Image.asset('assets/images/Dana.png', height: 40),
              SizedBox(height: 20),
              Text('atau'),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  Get.to(() => ScanQIRSScreen());
                },
                icon: const Icon(Icons.qr_code_scanner),
                label: const Text("Scan QRIS"),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  side: const BorderSide(color: Colors.grey),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {
                  Get.to(() => ReadQRISScreen());
                },
                icon: const Icon(Icons.qr_code),
                label: const Text("Baca QRIS"),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  side: const BorderSide(color: Colors.grey),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ScanQIRSScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan QRIS"),
      ),
      body: const Center(
        child: Icon(Icons.qr_code_scanner, size: 300),
      ),
    );
  }
}

class ReadQRISScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Baca QRIS"),
      ),
      body: const Center(
        child: Icon(Icons.qr_code, size: 300),
      ),
    );
  }
}
