import 'dart:async'; // นำเข้า Timer
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kpopmerchapplication/presentation/controllers/auth_controller.dart';
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
  late Timer _timer;
  UserModel? _userData;

  @override
  void initState() {
    super.initState();
    _fetchUserData();

    _timer = Timer.periodic(const Duration(seconds: 30), (Timer t) {
      _fetchUserData();
    });
  }

  // ฟังก์ชันดึงข้อมูลผู้ใช้จาก API
  void _fetchUserData() async {
    try {
      UserModel? userData =
          await apiService.getUser(authController.auth.currentUser!.uid);
      setState(() {
        _userData = userData;
      });
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  @override
  void dispose() {
    _timer.cancel();
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
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: _userData!.profileImage != null
                              ? CachedNetworkImageProvider(
                                  '${_userData!.profileImage}')
                              : null,
                          child: _userData!.profileImage == null
                              ? const Icon(Icons.person,
                                  size: 50) // แสดง Icon ถ้าไม่มีรูปโปรไฟล์
                              : null,
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
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Get.offAllNamed('/profile');
                        },
                        child: const Text('Next'),
                      ),
                    ],
                  )
                ],
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}
