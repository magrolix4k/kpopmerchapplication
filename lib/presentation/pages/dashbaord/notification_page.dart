import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text(
                  'Discover creators',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                ),
              ),
              const SizedBox(height: 10),
              _buildCreatorTile(
                imageUrl:
                    'https://via.placeholder.com/150', // รูปตัวอย่างของครีเอเตอร์
                creatorName: 'กับข้าวบ้านๆ',
                description: 'ชอบทำอาหารง่ายๆ ท่านเอง ลงคลิปใหม่',
                likes: 28480,
              ),
              _buildCreatorTile(
                imageUrl:
                    'https://via.placeholder.com/150', // รูปตัวอย่างของครีเอเตอร์
                creatorName: 'ดูดวง | พามู',
                description: 'ดูดวง เบอร์มงคล ฝากถามได้เลย',
                likes: 27137,
              ),
              _buildCreatorTile(
                imageUrl:
                    'https://via.placeholder.com/150', // รูปตัวอย่างของครีเอเตอร์
                creatorName: 'ลดไขมัน No Gym',
                description: 'ที่อยากสุขภาพดีไม่ต้องเข้ายิม',
                likes: 23561,
              ),
              _buildCreatorTile(
                imageUrl:
                    'https://via.placeholder.com/150', // รูปตัวอย่างของครีเอเตอร์
                creatorName: 'ความลับนางฟ้า',
                description: 'รีวิวตามใจ อะไรทำแล้วสวยชื่นใจ',
                likes: 6623,
              ),
            ],
          )
        ],
      ),
    );
  }

  // ฟังก์ชันสร้างรายการ Creator Tile
  Widget _buildCreatorTile({
    required String imageUrl,
    required String creatorName,
    required String description,
    required int likes,
  }) {
    return ListTile(
      leading: CircleAvatar(
        radius: 30, // ปรับขนาดของ CircleAvatar
        backgroundImage: NetworkImage(imageUrl),
      ),
      title: Text(creatorName),
      subtitle: Text('$description\nถูกใจ $likes ครั้ง'),
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
