import 'package:flutter/material.dart';
import 'package:get/get.dart'; // ใช้ GetX เพื่อควบคุมการนำทางและการ sign out
import 'package:kpopmerchapplication/presentation/controllers/auth_controller.dart'; // เรียกใช้ authController

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final AuthController authController =
      Get.find<AuthController>(); // เรียกใช้ AuthController

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'), // หัวข้อของหน้า Settings
      ),
      body: ListView(
        children: [
          // ส่วนของปุ่ม Logout
          ListTile(
            leading:
                const Icon(Icons.logout, color: Colors.red), // ไอคอนปุ่ม Logout
            title: const Text('Logout',
                style: TextStyle(color: Colors.red)), // ข้อความ Logout
            onTap: () {
              // ฟังก์ชันเมื่อต้องการ logout
              authController.signOut();
              Get.offAllNamed('/login'); // นำผู้ใช้กลับไปที่หน้า login
            },
          ),
        ],
      ),
    );
  }
}
