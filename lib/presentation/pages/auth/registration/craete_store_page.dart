import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kpopmerchapplication/presentation/controllers/auth_controller.dart';

class CreateStorePage extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();

  CreateStorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Store')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Connect your Twitter account to create your store'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // เรียกใช้ฟังก์ชันการสร้างร้านค้า
                // await authController.createStore();
              },
              child: const Text('Connect Twitter'),
            ),
          ],
        ),
      ),
    );
  }
}
