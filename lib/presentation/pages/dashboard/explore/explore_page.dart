import 'package:flutter/material.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: const TextField(
            decoration: InputDecoration(
              hintText: 'แอปเปลี่ยนทรงผม',
              border: InputBorder.none,
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: Colors.black),
          ),
        ],
      ),
      body: ListView(
        // แทน Column ด้วย ListView เพื่อให้สามารถเลื่อนคอนเทนต์ได้
        children: [
          // PageView Section (สำหรับรูปภาพที่เลื่อนซ้ายขวาได้)
          SizedBox(
            height: 150,
            child: PageView(
              children: [
                _buildImagePage(
                    "https://via.placeholder.com/350x150", "ใช้สไตล์ใหม่เลย"),
                _buildImagePage(
                    "https://via.placeholder.com/350x150", "ลองใช้สไตล์ใหม่"),
              ],
            ),
          ),

          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "🔥 Rising Stars",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  "See more",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          _buildRisingStars(),
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "# ข่าววันนี้",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  "1.8M views",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          _buildNewsSection(),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "# ข่าววันนี้",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  "1.8M views",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          _buildNewsSection(),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "# ข่าววันนี้",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  "1.8M views",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          _buildNewsSection(),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "# ข่าววันนี้",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  "1.8M views",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          _buildNewsSection(),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "# ข่าววันนี้",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  "1.8M views",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          _buildNewsSection(),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "# ข่าววันนี้",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  "1.8M views",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          _buildNewsSection(),
        ],
      ),
    );
  }

  // Function สำหรับสร้างหน้าแต่ละหน้าของ PageView
  Widget _buildImagePage(String imageUrl, String title) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(imageUrl),
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 10,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pinkAccent,
            ),
            child: Text(title),
          ),
        ),
      ],
    );
  }

// Function สำหรับสร้าง Section Rising Stars
  Widget _buildRisingStars() {
    return SizedBox(
      height: 150, // เพิ่มความสูงให้พอดีกับ CircleAvatar ขนาด 50
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildRisingStarItem(
              "mi ni mint", "926 Followers", "https://via.placeholder.com/100"),
          _buildRisingStarItem(
              "Mj Attack", "50 Followers", "https://via.placeholder.com/100"),
          _buildRisingStarItem("เฟิร์นอยากเล่า", "139 Followers",
              "https://via.placeholder.com/100"),
        ],
      ),
    );
  }

// Function สำหรับสร้าง item ใน Rising Stars
  Widget _buildRisingStarItem(String name, String followers, String imageUrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min, // ปรับให้ Column หดตัวตามเนื้อหา
        children: [
          CircleAvatar(
            radius: 50, // ปรับจาก 35 เป็น 50
            backgroundImage: NetworkImage(imageUrl),
          ),
          const SizedBox(height: 5),
          Flexible(
            // ใช้ Flexible เพื่อป้องกันการล้นของ Text
            child: Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis, // ป้องกันข้อความล้น
            ),
          ),
          Text(
            followers,
            style: const TextStyle(color: Colors.grey),
            overflow: TextOverflow.ellipsis, // ป้องกันข้อความล้น
          ),
        ],
      ),
    );
  }

  // Function สำหรับสร้างข่าว (เช่น "ข่าววันนี้")
  Widget _buildNewsSection() {
    return SizedBox(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildNewsItem("https://via.placeholder.com/100"),
          _buildNewsItem("https://via.placeholder.com/100"),
          _buildNewsItem("https://via.placeholder.com/100"),
        ],
      ),
    );
  }

  // Function สำหรับสร้างข่าวแต่ละ item
  Widget _buildNewsItem(String imageUrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Image.network(imageUrl),
    );
  }
}
