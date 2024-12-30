import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahabatkosku/app/modules/home/controllers/login_controller.dart';
import 'package:sahabatkosku/app/page/root_page/login.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => RegisterPageStage();
}

class RegisterPageStage extends State<RegisterScreen> {
  final LoginController controller = Get.put(LoginController());
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.off(LoginScreen()),
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                      'Daftar Akun Sebagai',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),

                    // Tab Buttons wrapped in Obx to observe reactive state
                    Obx(() => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildTabButton('Pencari Kos', controller),
                            _buildTabButton('Pemilik Kos', controller),
                          ],
                        )),

                    const SizedBox(height: 20),

                    // Full Name Input Field
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: 'Nama Lengkap',
                        prefixIcon: const Icon(Icons.person),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Phone Number Input Field
                    TextField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: 'Nomor Telepon',
                        prefixIcon: const Icon(Icons.phone),
                      ),
                    ),

                    const SizedBox(height: 10),

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

                    const SizedBox(height: 10),

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

                    // Confirm Password Input Field
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: 'Konfirmasi Password',
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: const Icon(Icons.visibility),
                      ),
                    ),

                    const SizedBox(height: 5),

                    // Already have an account link
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () => Get.off(LoginScreen()),
                        // Action when "Sudah punya akun ?" is pressed
                        child: const Text('Sudah punya akun ?'),
                      ),
                    ),

                    const SizedBox(height: 5),

                    // Register Button
                    Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF0085FF), Color(0xFF005099)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: InkWell(
                            onTap: () => {
                                  controller.registerUser(
                                      _emailController.text,
                                      _passwordController.text,
                                      _nameController.text,
                                      _phoneController.text)
                                },
                            borderRadius: BorderRadius.circular(10),
                            child: const Center(
                                child: Text(
                              'Daftar',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ))))
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
        backgroundColor: controller.selectedTab.value == label
            ? Colors.blue
            : Colors.grey[300],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        minimumSize: const Size(130, 40), // Adjust the size of the button
      ),
      child: Text(
        label,
        style: TextStyle(
          color: controller.selectedTab.value == label
              ? Colors.white
              : Colors.black,
        ),
      ),
    );
  }
}
