import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kpopmerchapplication/presentation/controllers/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  final ProfileController profileController = Get.put(ProfileController());
  
  // สามารถรับ userId ผ่าน constructor
  final String userId;

  ProfileScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    // ดึงข้อมูลโปรไฟล์เมื่อเข้าสู่หน้า
    profileController.fetchUserProfile(userId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Obx(() {
        if (profileController.isLoading.value) {
          // แสดงการโหลดข้อมูล
          return const Center(child: CircularProgressIndicator());
        }

        if (profileController.userProfile.isEmpty) {
          // กรณีที่ไม่มีข้อมูล (หรือดึงข้อมูลไม่สำเร็จ)
          return const Center(
            child: Text('Profile data not found'),
          );
        }

        final userProfile = profileController.userProfile;
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // แสดงรูปโปรไฟล์
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(userProfile['profile_image'] ?? 
                    'https://via.placeholder.com/150'),
                ),
              ),
              const SizedBox(height: 20),
              // แสดงชื่อผู้ใช้
              Text(
                'Name: ${userProfile['name']}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              // แสดง Username
              Text(
                'Username: @${userProfile['username']}',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 10),
              // แสดง Email
              Text(
                'Email: ${userProfile['email']}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              // แสดง Bio
              Text(
                'Bio: ${userProfile['bio'] ?? 'No bio available'}',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        );
      }),
    );
  }
}
