import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kpopmerchapplication/presentation/controllers/auth_controller.dart';
import 'package:kpopmerchapplication/presentation/pages/auth/registration/register_role_page.dart';

class RegisterProfilePage extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();

  RegisterProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register - Step 2')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  authController.pickImage();
                },
                child: Obx(() {
                  return CircleAvatar(
                    radius: 90.0,
                    backgroundColor: Colors.grey[300],
                    backgroundImage:
                        authController.profileImage.value.isNotEmpty
                            ? FileImage(File(authController.profileImage.value))
                            : null,

                    child: authController.profileImage.value.isEmpty
                        ? const Icon(
                            Icons.add_a_photo,
                            size: 40,
                            color: Colors.white,
                          ) // ถ้าไม่มีรูปแสดงไอคอน
                        : null, // ถ้ามีรูปภาพแล้วจะไม่แสดง Icon
                  );
                }),
              ),
            ),
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
