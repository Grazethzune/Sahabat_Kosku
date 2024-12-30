import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahabatkosku/app/modules/home/controllers/pencari_Kos/home_controller.dart';
import 'package:sahabatkosku/app/page/page_pemilik_kos/account_page.dart';
import 'package:sahabatkosku/app/page/page_pemilik_kos/properti_page.dart';
import 'package:sahabatkosku/app/page/page_pemilik_kos/kwitansi_page.dart';
import 'package:sahabatkosku/app/page/page_pemilik_kos/penghuni_page.dart';
import 'package:sahabatkosku/app/page/page_pemilik_kos/statistik_page.dart';

class LandingPage_PemilikKos extends GetView {
  final TextStyle unselectedLabelStyle = TextStyle(
      color: Colors.white.withOpacity(0.5),
      fontWeight: FontWeight.w500,
      fontSize: 12);

  final TextStyle selectedLabelStyle = const TextStyle(
      color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12);

  LandingPage_PemilikKos({super.key});

  buildBottomNavigationMenu(context, landingPageController) {
    return Obx(() => MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1.0)),
        child: SizedBox(
          height: 54,
          child: BottomNavigationBar(
            showUnselectedLabels: true,
            showSelectedLabels: true,
            onTap: landingPageController.changeTabIndex,
            currentIndex: landingPageController.tabIndex.value,
            backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
            unselectedItemColor: const Color.fromARGB(255, 156, 151, 151),
            selectedItemColor: const Color.fromARGB(255, 0, 0, 0),
            unselectedLabelStyle: unselectedLabelStyle,
            selectedLabelStyle: selectedLabelStyle,
            items: [
              BottomNavigationBarItem(
                icon: Column(
                  children: [
                    Container(
                      width: 20,
                      color: landingPageController.tabIndex.value == 0
                          ? const Color.fromARGB(255, 0, 0, 0)
                          : null,
                    ),
                    const Icon(Icons.home_filled, size: 20.0),
                  ],
                ),
                label: 'Properti',
                backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
              ),
              BottomNavigationBarItem(
                icon: Column(
                  children: [
                    Container(
                      width: 20,
                      color: landingPageController.tabIndex.value == 1
                          ? const Color.fromARGB(255, 0, 0, 0)
                          : null,
                    ),
                    const Icon(Icons.people, size: 20.0),
                  ],
                ),
                label: 'Penghuni',
                backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
              ),
              BottomNavigationBarItem(
                icon: Column(
                  children: [
                    Container(
                      width: 20,
                      color: landingPageController.tabIndex.value == 2
                          ? const Color.fromARGB(255, 0, 0, 0)
                          : const Color.fromARGB(255, 255, 255, 255),
                    ),
                    const Icon(Icons.auto_graph, size: 20.0),
                  ],
                ),
                label: 'Statistik',
                backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
              ),
              BottomNavigationBarItem(
                icon: Column(
                  children: [
                    Container(
                      width: 20,
                      color: landingPageController.tabIndex.value == 2
                          ? const Color.fromARGB(255, 0, 0, 0)
                          : const Color.fromARGB(255, 255, 255, 255),
                    ),
                    const Icon(Icons.receipt, size: 20.0),
                  ],
                ),
                label: 'Kwitansi',
                backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
              ),
              BottomNavigationBarItem(
                icon: Column(
                  children: [
                    Container(
                      width: 20,
                      color: landingPageController.tabIndex.value == 2
                          ? const Color.fromARGB(255, 0, 0, 0)
                          : const Color.fromARGB(255, 255, 255, 255),
                    ),
                    const Icon(Icons.account_circle, size: 20.0),
                  ],
                ),
                label: 'Akun',
                backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
              ),
            ],
          ),
        )));
  }

  @override
  Widget build(BuildContext context) {
    final HomeController landingPageController =
        Get.put(HomeController(), permanent: false);
    return SafeArea(
        child: Scaffold(
      bottomNavigationBar:
          buildBottomNavigationMenu(context, landingPageController),
      body: Obx(() => IndexedStack(
            index: landingPageController.tabIndex.value,
            children: [
              PropertyScreen(),
              PenghuniView(),
              StatistikView(),
              KwitansiView(),
              ProfileView_PemilikKos()
            ],
          )),
    ));
  }
}
