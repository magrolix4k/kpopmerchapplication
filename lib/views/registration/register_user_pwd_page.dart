import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kpopmerchapplication/controllers/auth_controller.dart';
import 'package:kpopmerchapplication/views/registration/register_profile.dart';


class RegisterUsernamePasswordPage extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  RegisterUsernamePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register - Step 2')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // บันทึกข้อมูล username และ password ไว้ใน controller
                authController.username.value = usernameController.text;
                authController.password.value = passwordController.text;
                // ไปหน้าถัดไป
                Get.to(() => RegisterProfilePage());
              },
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
