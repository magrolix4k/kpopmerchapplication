import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kpopmerchapplication/presentation/controllers/auth_controller.dart';

class RegisterRolePage extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();

  RegisterRolePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register - Step 3')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Select Your Role'),
            Obx(() => RadioListTile(
                  title: const Text('User'),
                  value: 'user',
                  groupValue: authController.role.value, // ฟังค่าจาก role
                  onChanged: (value) {
                    authController.role.value = value.toString();
                  },
                )),
            Obx(() => RadioListTile(
                  title: const Text('Shop Owner'),
                  value: 'shop_owner',
                  groupValue: authController.role.value, // ฟังค่าจาก role
                  onChanged: (value) {
                    authController.role.value = value.toString();
                  },
                )),
            Obx(() => RadioListTile(
                  title: const Text('Admin'),
                  value: 'admin',
                  groupValue: authController.role.value, // ฟังค่าจาก role
                  onChanged: (value) {
                    authController.role.value = value.toString();
                  },
                )),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // ส่งข้อมูลทั้งหมดไปที่ API
                authController.register();
                // กลับไปหน้าหลัก
                Get.offAllNamed('/home');
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
