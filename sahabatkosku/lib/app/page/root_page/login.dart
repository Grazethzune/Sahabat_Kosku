import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahabatkosku/app/modules/home/controllers/login_controller.dart';
import 'package:sahabatkosku/app/page/page_admin/nav_bar_admin.dart';
import 'package:sahabatkosku/app/page/page_pemilik_kos/nav_bar_pencari_kos.dart';
import 'package:sahabatkosku/app/page/page_pencari_kos/nav_bar_pencari_kos.dart';
import 'package:sahabatkosku/app/page/root_page/lupa_pasword.dart';
import 'package:sahabatkosku/app/page/root_page/register.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => LoginScreenStage();
}

class LoginScreenStage extends State<LoginScreen> {
  final LoginController controller = Get.put(LoginController());
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image placeholder (use your own image asset here)
              Image.asset(
                  'assets/images/SahabatKosku Cari & Manajemen kos jadi mudah.png',
                  height: 60),

              const SizedBox(height: 20),

              // Container for Tabs and Input Fields
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Masuk Sebagai',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),

                    // Tab Buttons wrapped in Obx to observe reactive state
                    Obx(() => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            _buildTabButton('Pencari Kos', controller),
                            const SizedBox(
                              width: 10,
                            ),
                            _buildTabButton('Pemilik Kos', controller),
                            const SizedBox(
                              width: 10,
                            ),
                            _buildTabButton('Admin', controller),
                          ],
                        )),

                    const SizedBox(height: 20),

                    // Email Input Field
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: 'Alamat Email',
                        prefixIcon: const Icon(Icons.email),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Password Input Field
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: const Icon(Icons.visibility),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Forgot password and register links
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () => Get.to(ForgotPasswordScreen()),
                          child: const Text('Lupa Sandi ?'),
                        ),
                        Obx(() => controller.selectedTab.value != 'Admin'
                            ? TextButton(
                                onPressed: () => Get.to(RegisterScreen()),
                                child: const Text('Belum punya akun ?'),
                              )
                            : const Text('')),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Login Button
                    ElevatedButton(
                      onPressed: () {
                        controller.loginUser(
                          _emailController.text,
                          _passwordController.text,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue, // Button color
                        padding: const EdgeInsets.symmetric(
                            horizontal: 120, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Masuk',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),

                    const SizedBox(height: 10),
                    Obx(() => controller.selectedTab.value != 'Admin'
                        ? const Text('atau')
                        : const SizedBox(height: 0)),
                    Obx(() => controller.selectedTab.value != 'Admin'
                        ? const SizedBox(height: 10)
                        : const SizedBox(height: 0)),
                    Obx(() => controller.selectedTab.value != 'Admin'
                        ? ElevatedButton.icon(
                            onPressed: () {
                              controller.signInWithGoogle();
                            },
                            style: ElevatedButton.styleFrom(
                              side: const BorderSide(color: Colors.blue),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            icon: const Icon(Icons.g_mobiledata,
                                color: Colors.blue),
                            label: const Text(
                              'Masuk dengan akun Google',
                              style: TextStyle(color: Colors.blue),
                            ),
                          )
                        : const SizedBox(height: 0)),
                    // Google Login Button
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Method to create tab buttons with reactive state observed
  Widget _buildTabButton(String label, LoginController controller) {
    return ElevatedButton(
      onPressed: () => controller.selectTab(label),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        backgroundColor: controller.selectedTab.value == label
            ? Colors.blue
            : Colors.grey[300],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 14.0,
          color: controller.selectedTab.value == label
              ? Colors.white
              : Colors.black,
        ),
      ),
    );
  }
}
