import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kpopmerchapplication/presentation/controllers/auth_controller.dart';
import 'package:kpopmerchapplication/presentation/controllers/profile_controller.dart';
import 'package:kpopmerchapplication/presentation/controllers/store_controller.dart';
import 'package:kpopmerchapplication/presentation/pages/dashboard/manage/page/profile/user_profile_screen.dart';

class ManagePage extends StatefulWidget {
  const ManagePage({super.key});

  @override
  State<ManagePage> createState() => _ManagePageState();
}

class _ManagePageState extends State<ManagePage> {
  final AuthController authController = Get.find<AuthController>();
  final ProfileController profileController = Get.put(ProfileController());
  final StoreController storeController = Get.put(StoreController());

  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // ดึงข้อมูลโปรไฟล์และข้อมูลร้านค้าของผู้ใช้คนปัจจุบัน
    final userId = authController.auth.currentUser!.uid;
    _fetchData(userId);

    // ตั้งค่า Timer เพื่อรีเฟรชข้อมูลทุกๆ 10 วินาที
    _timer = Timer.periodic(const Duration(seconds: 10), (Timer t) {
      _fetchData(userId);
    });
  }

  // ฟังก์ชันดึงข้อมูลโปรไฟล์และร้านค้าของผู้ใช้
  void _fetchData(String userId) {
    profileController.fetchUserProfile(userId);
    storeController.fetchStoresForUser(userId);
  }

  @override
  void dispose() {
    _timer.cancel(); // ยกเลิก Timer เมื่อออกจากหน้าจอ
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Manage'),
            Divider(),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          // ส่วนของข้อมูลโปรไฟล์ผู้ใช้
          Obx(() {
            if (profileController.userProfile.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            final userProfile = profileController.userProfile;
            return Row(
              children: [
                // รูปโปรไฟล์ผู้ใช้
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(userProfile['profile_image'] ??
                      'https://via.placeholder.com/150'),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${userProfile['name']}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() =>
                            ProfileScreen(userId: '${userProfile['uid']}'));
                      },
                      child: const Text(
                        'View profile >',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                // QR Code Icon
                IconButton(
                  icon: const Icon(Icons.qr_code),
                  onPressed: () {},
                ),
              ],
            );
          }),
          const SizedBox(height: 5),
          const Divider(),
          const SizedBox(height: 5),
          // ส่วนของข้อมูลร้านค้า
          Obx(() {
            if (storeController.stores.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            final storeData = storeController.storesProfile;
            return Row(
              children: [
                // รูปโปรไฟล์ร้านค้า
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(storeData['profile_image'] ??
                      'https://via.placeholder.com/150'),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${storeData['name']}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed('/storeprofile?sid=${storeData['sid']}');
                      },
                      child: const Text(
                        'View profile >',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                // QR Code Icon
                IconButton(
                  icon: const Icon(Icons.qr_code),
                  onPressed: () {
                    // ฟังก์ชันเมื่อกดปุ่ม QR Code
                    authController.unlinkProvider('twitter.com');
                  },
                ),
              ],
            );
          }),
          const SizedBox(height: 15),
          const Divider(),
          // รายการเมนูต่าง ๆ
          Text(
            "How you use",
            style: GoogleFonts.inter(
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.bookmark_border),
            title: const Text('Saved Products'),
            onTap: () {
              // ฟังก์ชันเมื่อกด Saved posts
            },
          ),
          ListTile(
            leading: const Icon(Icons.history_rounded),
            title: const Text('Your activity'),
            onTap: () {
              // ฟังก์ชันเมื่อกด Saved posts
            },
          ),
          const Divider(),
          Text(
            "Your Store",
            style: GoogleFonts.inter(
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.bar_chart),
            title: const Text('Statistics'),
            onTap: () {
              // ฟังก์ชันเมื่อกด Statistics
            },
          ),
          ListTile(
            leading: const Icon(Icons.people_outline),
            title: const Text('Following'),
            onTap: () {
              // ฟังก์ชันเมื่อกด Following
            },
          ),
          ListTile(
            leading: const Icon(Icons.store),
            title: const Text('Link Your Store'),
            onTap: () {
              // ฟังก์ชันเมื่อกดเชื่อมโยงกับร้าน
            },
          ),
          const Divider(),
          Text(
            "Admin Commands",
            style: GoogleFonts.inter(
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.report),
            title: const Text('Reports Received'),
            onTap: () {
              // ฟังก์ชันเมื่อกดดูรายงานที่ได้รับมา
            },
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('Report History'),
            onTap: () {
              // ฟังก์ชันเมื่อกดดูประวัติการรายงานที่แก้ไขแล้ว
            },
          ),
          const Divider(),
          Text(
            "Application and Account Settings",
            style: GoogleFonts.inter(
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.settings_applications),
            title: const Text('App Settings'),
            onTap: () {
              // ฟังก์ชันเมื่อกด App Settings
            },
          ),
          const Divider(),
          // ส่วนของปุ่ม Logout
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Logout', style: TextStyle(color: Colors.black)),
            onTap: () {
              authController.signOut();
            },
          ),
          const SizedBox(height: 5),
          const Center(child: Text("Version 0.2.55")),
        ],
      ),
    );
  }
}
