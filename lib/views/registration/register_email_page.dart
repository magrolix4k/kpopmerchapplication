import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kpopmerchapplication/controllers/auth_controller.dart';
import 'package:kpopmerchapplication/views/registration/register_user_pwd_page.dart';

class RegisterEmailPage extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();
  final TextEditingController emailController = TextEditingController();

  RegisterEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register - Step 1')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // บันทึกข้อมูล email ไว้ใน controller
                authController.email.value = emailController.text;
                // ไปหน้าถัดไป
                Get.to(() => RegisterUsernamePasswordPage());
              },
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
