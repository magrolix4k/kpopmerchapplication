import 'dart:async'; // นำเข้า Timer
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kpopmerchapplication/controllers/auth_controller.dart';
import 'package:kpopmerchapplication/models/user_model.dart';
import 'package:kpopmerchapplication/services/api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthController authController = Get.find<AuthController>();
  final ApiService apiService = ApiService();
  late Timer _timer; // สร้างตัวแปร Timer
  UserModel? _userData; // เก็บข้อมูลผู้ใช้ในตัวแปร

  @override
  void initState() {
    super.initState();

    // ดึงข้อมูลผู้ใช้ครั้งแรก
    _fetchUserData();

    // ตั้งค่า Timer เพื่อดึงข้อมูลทุกๆ 30 วินาที
    _timer = Timer.periodic(const Duration(seconds: 30), (Timer t) {
      _fetchUserData(); // เรียกฟังก์ชันดึงข้อมูลใหม่
    });
  }

  // ฟังก์ชันดึงข้อมูลผู้ใช้จาก API
  void _fetchUserData() async {
    try {
      UserModel userData =
          await apiService.getUser(authController.auth.currentUser!.uid);
      setState(() {
        _userData = userData;
      });
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  // ปิด Timer เมื่อออกจากหน้าเพื่อป้องกัน memory leak
  @override
  void dispose() {
    _timer.cancel(); // ยกเลิกการทำงานของ Timer เมื่อหน้า HomePage ถูกปิด
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              authController.signOut(); // ออกจากระบบ
            },
          )
        ],
      ),
      body: Center(
        child: _userData != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Column(
                      children: [
                        const CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                            'https://lh3.googleusercontent.com/-IPUpAUT4ffs/AAAAAAAAAAI/AAAAAAAAAAA/ALKGfkll6lSLU4mfwJEvf3_O8njGL7tc9Q/photo.jpg?sz=46',
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text('@${_userData!.username}'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Text('Email: ${_userData!.email}'),
                      const SizedBox(height: 10),
                      Text('UID: ${_userData!.uid}'),
                      const SizedBox(height: 10),
                      Text('isVerified: ${_userData!.isVerified}'),
                      const SizedBox(height: 10),
                      Text('role: ${_userData!.role}'),
                      const SizedBox(height: 10),
                      Text('status: ${_userData!.status}'),
                      const SizedBox(height: 10),
                      Text('lastLoginAt: ${_userData!.lastLoginAt}'),
                    ],
                  )
                ],
              )
            : const CircularProgressIndicator(), // แสดง Loading ขณะดึงข้อมูล
      ),
    );
  }
}
