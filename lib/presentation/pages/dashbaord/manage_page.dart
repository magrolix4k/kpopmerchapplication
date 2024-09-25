import 'package:flutter/material.dart';

class ManagePage extends StatefulWidget {
  const ManagePage({super.key});

  @override
  State<ManagePage> createState() => _ManagePageState();
}

class _ManagePageState extends State<ManagePage> {
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
        padding: const EdgeInsets.only(left: 16.0, right: 16),
        children: [
          // ส่วนของข้อมูลโปรไฟล์
          Row(
            children: [
              // รูปโปรไฟล์
              const CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(
                    'https://example.com/profile-image.jpg'), // ใส่ URL ของรูปภาพ
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'magrolix4k',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // ฟังก์ชันเมื่อกดปุ่ม View Profile
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
                },
              ),
            ],
          ),
          const SizedBox(height: 5),
          const Divider(),
          const SizedBox(height: 5),
          Row(
            children: [
              // รูปโปรไฟล์
              const CircleAvatar(
                radius: 40,
                backgroundImage:
                    NetworkImage('https://example.com/profile-image.jpg'),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'store of magrolix4k',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // ฟังก์ชันเมื่อกดปุ่ม View Store
                    },
                    child: const Text(
                      'View Store >',
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
                },
              ),
            ],
          ),
          const SizedBox(height: 15),
          const Divider(),
          // รายการเมนูต่าง ๆ
          ListTile(
            leading: const Icon(Icons.bar_chart),
            title: const Text('Statistics'),
            onTap: () {
              // ฟังก์ชันเมื่อกด Statistics
            },
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('Following'),
            onTap: () {
              // ฟังก์ชันเมื่อกด Following
            },
          ),
          ListTile(
            leading: const Icon(Icons.bookmark),
            title: const Text('Saved posts'),
            onTap: () {
              // ฟังก์ชันเมื่อกด Saved posts
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('App Settings'),
            onTap: () {
              // ฟังก์ชันเมื่อกด Creator Settings
            },
          ),

          const Divider(),
          // ส่วนของปุ่ม Logout
          ListTile(
            leading:
                const Icon(Icons.logout, color: Colors.red), // ไอคอนปุ่ม Logout
            title: const Text('Logout',
                style: TextStyle(color: Colors.black)), // ข้อความ Logout
            onTap: () {
              // ฟังก์ชันเมื่อต้องการ logout
            },
          ),
          const SizedBox(height: 5),
          const Center(child: Text("Version 0.1.36")),
        ],
      ),
      // Bottom Navigation Bar
    );
  }
}
