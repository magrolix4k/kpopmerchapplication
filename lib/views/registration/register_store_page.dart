import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kpopmerchapplication/controllers/auth_controller.dart';

class RegisterStorePage extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();

  RegisterStorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register Store')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Connect your Twitter account'),
            ElevatedButton(
              onPressed: () async {
                // เรียกใช้ฟังก์ชันเชื่อมต่อ Twitter
                await twitterAuthService.connectTwitter();
                // บันทึกข้อมูลร้านค้าในฐานข้อมูล
                authController.registerStore(); // เรียกใช้การลงทะเบียนร้าน
              },
              child: const Text('Connect Twitter'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // ไปยังหน้าหลักหลังจากลงทะเบียนเสร็จ
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
