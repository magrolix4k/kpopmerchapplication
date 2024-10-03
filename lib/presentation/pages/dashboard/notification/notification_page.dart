import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kpopmerchapplication/presentation/controllers/auth_controller.dart';
import 'package:kpopmerchapplication/presentation/controllers/store_controller.dart';

class NotificationPage extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();
  final StoreController storeController = Get.put(StoreController());

  NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Notifications'),
            Divider(),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        children: [
          // รายการเมนูการแจ้งเตือน
          ListTile(
            leading: CircleAvatar(
              radius: 30, // ปรับขนาดของ CircleAvatar
              backgroundColor: Colors.orange[100],
              child: Icon(Icons.person, color: Colors.orange[500]),
            ),
            title: const Text('New Followers'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // ฟังก์ชันเมื่อกดผู้ติดตามใหม่
            },
          ),
          const SizedBox(height: 20),
          ListTile(
            leading: CircleAvatar(
              radius: 30, // ปรับขนาดของ CircleAvatar
              backgroundColor: Colors.pink[100],
              child: const Icon(Icons.favorite, color: Colors.red),
            ),
            title: const Text('Likes and Saves'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // ฟังก์ชันเมื่อกดถูกใจและบันทึก
            },
          ),
          const SizedBox(height: 20),
          ListTile(
            leading: CircleAvatar(
              radius: 30, // ปรับขนาดของ CircleAvatar
              backgroundColor: Colors.blue[100],
              child: const Icon(Icons.comment, color: Colors.blue),
            ),
            title: const Text('Comments and Mentions'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // ฟังก์ชันเมื่อกดความคิดเห็นและการกล่าวถึง
            },
          ),
          const Divider(height: 32),
          ListTile(
            leading: CircleAvatar(
              radius: 30, // ปรับขนาดของ CircleAvatar
              backgroundColor: Colors.yellow[600],
              child: const Text(
                'KPM',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: const Text('Message Form K-POP Merch'),
            onTap: () {
              // ฟังก์ชันเมื่อกดข้อเสนอจาก Lemon8
            },
          ),
          const Divider(height: 32),
          // ใช้ข้อมูลจาก storeController เพื่อสร้างรายการร้านค้า
          Obx(() {
            if (storeController.stores.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      'Discover Sellers',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // สร้างรายการร้านค้าจากข้อมูลที่ดึงมา
                  ...storeController.stores.map((store) {
                    return _buildCreatorTile(
                      sid: store['owner_id'],
                      profileImage: store['profile_image'] ??
                          'https://via.placeholder.com/150', // รูปโปรไฟล์
                      name: store['name'] ?? 'Unknown Store',
                      username: store['username'] ?? 'No description',
                      follower: store['followers'] ?? 0, // จำนวนผู้ติดตาม
                    );
                  }).toList(),
                ],
              );
            }
          }),
        ],
      ),
    );
  }

  // ฟังก์ชันสร้างรายการ Creator Tile
  Widget _buildCreatorTile({
    required String sid,
    required String profileImage,
    required String name,
    required String username,
    required int follower,
  }) {
    return ListTile(
      onTap: () {
        Get.toNamed('/storeprofile?sid=$sid');
      },
      leading: CircleAvatar(
        radius: 30, // ปรับขนาดของ CircleAvatar
        backgroundImage: NetworkImage(profileImage),
      ),
      title: Text(name),
      subtitle: Text('@$username\n $follower Follows'),
      trailing: ElevatedButton(
        onPressed: () {
          // ฟังก์ชันเมื่อกดปุ่มติดตาม
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.yellow[500],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          minimumSize: const Size(100, 35),
          elevation: 0,
        ),
        child: const Text('Follow', style: TextStyle(color: Colors.black)),
      ),
    );
  }
}
