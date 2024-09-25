import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kpopmerchapplication/presentation/controllers/auth_controller.dart';
import 'package:kpopmerchapplication/presentation/pages/auth/registration/register_profile.dart';

class RegisterEmailPage extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () {
                // บันทึกข้อมูล email ไว้ใน controller
                authController.email.value = emailController.text;
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
