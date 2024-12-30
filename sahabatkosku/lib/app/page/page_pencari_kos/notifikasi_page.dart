import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahabatkosku/app/modules/home/controllers/pencari_Kos/filter_controller.dart';

class NotificationSettingsPage extends StatelessWidget {
  final FilterController controller = Get.put(FilterController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Ada dua tab: Info dan Setelan
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Notifikasi"),
          centerTitle: true,
          bottom: const TabBar(
            labelColor: Colors.blue,
            indicatorColor: Colors.blue,
            tabs: [
              Tab(text: 'Info'),
              Tab(text: 'Setelan'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Halaman untuk tab Info
            NotificationInfoPage(),
            // Halaman untuk tab Setelan
            NotificationSettingsBody(controller: controller),
          ],
        ),
      ),
    );
  }
}

class NotificationInfoPage extends StatelessWidget {
  const NotificationInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Notifikasi Info', style: TextStyle(fontSize: 20)),
    );
  }
}

class NotificationSettingsBody extends StatelessWidget {
  final FilterController controller;
  const NotificationSettingsBody({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Beritahu ada kos baru sesuai keinginan saya"),
                Obx(() => Switch(
                      activeTrackColor: Colors.blue,
                      value: controller.isNotificationEnabled.value,
                      onChanged: (value) {
                        controller.isNotificationEnabled.value = value;
                      },
                    )),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min, // Adjust the size to content
                  children: [
                    const Text('Kos untuk?',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        genderButton('Laki-laki', Icons.male),
                        genderButton('Perempuan', Icons.female),
                        genderButton('Campur', Icons.transgender),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text('Berapa Orang?',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),
                    const Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: 'Minimal',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: 'Maksimal',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text('Pembayaran Kos Tiap?',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        paymentOption('Mingguan'),
                        paymentOption('Bulanan'),
                        paymentOption('Tahunan'),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                        'Harga                                                    Mulai dari',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: 'Minimal',
                              border: OutlineInputBorder(),
                              prefixText: 'Rp',
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: 'Maksimal',
                              border: OutlineInputBorder(),
                              prefixText: 'Rp',
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        DropdownButton<String>(
                          value: 'Minimal',
                          items: <String>['Minimal', 'Maksimal']
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (newValue) {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget genderButton(String gender, IconData icon) {
    return Obx(() {
      return GestureDetector(
        onTap: () {
          controller.selectedGender.value = gender;
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(
              color: controller.selectedGender.value == gender
                  ? Colors.blue
                  : Colors.grey,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Icon(icon),
              const SizedBox(height: 5),
              Text(gender),
            ],
          ),
        ),
      );
    });
  }

  Widget paymentOption(String option) {
    return Obx(() {
      return RadioListTile(
        value: option,
        groupValue: controller.paymentOption.value,
        onChanged: (value) {
          controller.paymentOption.value = value.toString();
        },
        title: Text(option),
      );
    });
  }
}
