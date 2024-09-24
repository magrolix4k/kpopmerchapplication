import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kpopmerchapplication/controllers/auth_controller.dart';
import 'package:kpopmerchapplication/views/registration/register_role_page.dart';

class RegisterProfilePage extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();

  RegisterProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register - Step 3')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: bioController,
              decoration: const InputDecoration(labelText: 'Bio'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // บันทึกข้อมูล name, profile image และ bio ไว้ใน controller
                authController.name.value = nameController.text;
                authController.bio.value = bioController.text;
                // ไปหน้าถัดไป
                Get.to(() => RegisterRolePage());
              },
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
