import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kpopmerchapplication/presentation/controllers/auth_controller.dart';

class HomeScreen extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              authController.signOut();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // แสดงข้อมูลผู้ใช้หลังจากเข้าสู่ระบบ
            Obx(() {
              var user = authController.firebaseUser.value;
              if (user == null) {
                return const Center(child: Text('No user logged in'));
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome, ${user.email}',
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text('UID: ${user.uid}'),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Get.toNamed('/profile');
                          },
                          child: const Text('View Profile'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            authController.linkWithTwitter();
                          },
                          child: const Text('Link Twitter'),
                        ),
                      ],
                    ),
                  ],
                );
              }
            }),

            const SizedBox(height: 30),

            // แสดงรายการอื่น ๆ เช่น ร้านค้า หรือสินค้า
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    title: const Text('Store Management'),
                    subtitle: const Text('Manage your store and products'),
                    leading: const Icon(Icons.store),
                    onTap: () {
                      Get.toNamed('/store');
                    },
                  ),
                  ListTile(
                    title: const Text('Product List'),
                    subtitle: const Text('View all products'),
                    leading: const Icon(Icons.shopping_bag),
                    onTap: () {
                      Get.toNamed('/products'); // ไปที่หน้ารายการสินค้า
                    },
                  ),
                  ListTile(
                    title: const Text('Followed Users & Stores'),
                    subtitle: const Text('View users and stores you follow'),
                    leading: const Icon(Icons.people),
                    onTap: () {
                      Get.toNamed('/follows');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
