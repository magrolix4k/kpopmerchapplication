import 'dart:async'; // นำเข้า Timer
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kpopmerchapplication/presentation/controllers/auth_controller.dart';
import 'package:kpopmerchapplication/models/user_model.dart';
import 'package:kpopmerchapplication/services/api_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  final AuthController authController = Get.find<AuthController>();
  final ApiService apiService = ApiService();
  late Timer _timer;
  UserModel? _userData;
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();
  bool _showUsername = false;

  @override
  void initState() {
    super.initState();
    _fetchUserData();

    // ตั้งค่า TabController
    _tabController = TabController(length: 3, vsync: this);

    // ตั้งค่า ScrollController เพื่อตรวจจับการเลื่อน
    _scrollController.addListener(_scrollListener);

    // ตั้งค่า Timer ให้ดึงข้อมูลใหม่ทุกๆ 30 วินาที
    _timer = Timer.periodic(const Duration(seconds: 30), (Timer t) {
      _fetchUserData();
    });
  }

  // ฟังก์ชันสำหรับตรวจจับการเลื่อน
  void _scrollListener() {
    if (_scrollController.position.pixels > 200) {
      // เมื่อเลื่อนไปถึง 200px
      setState(() {
        _showUsername = true; // แสดง username
      });
    } else {
      setState(() {
        _showUsername = false; // ซ่อน username
      });
    }
  }

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
    _tabController.dispose();
    _scrollController.dispose(); // ปิด ScrollController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _showUsername
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _userData?.name ?? "",
                    style: const TextStyle(fontSize: 20),
                  ),
                  const Text(
                    "0 tweets",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ) // แสดง username ที่นี่เมื่อเลื่อนสุด
            : null, // ไม่แสดงเมื่อไม่เลื่อนถึง
        actions: _showUsername
            ? null
            : [
                IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    // authController.signOut();
                    Get.toNamed('/settings');
                  },
                ),
              ],
      ),
      body: _userData != null
          ? NestedScrollView(
              controller: _scrollController, // เชื่อม ScrollController
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundImage: _userData!.profileImage != null
                                    ? CachedNetworkImageProvider(
                                        _userData!.profileImage!)
                                    : null,
                                child: _userData!.profileImage == null
                                    ? const Icon(Icons.person, size: 50)
                                    : null,
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          '${_userData!.following}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        const Text('Following'),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          '${_userData!.followers}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        const Text('Followers'),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '${_userData!.name}',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '@${_userData!.username}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '${_userData!.bio}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Joined ${_userData!.createAt}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _SliverAppBarDelegate(
                      TabBar(
                        controller: _tabController,
                        labelColor: Colors.blue,
                        indicatorColor: Colors.blue,
                        indicatorWeight: 4.0,
                        indicatorSize: TabBarIndicatorSize.tab,
                        tabs: const [
                          Tab(text: 'Tweets'),
                          Tab(text: 'Replies'),
                          Tab(text: 'Media'),
                        ],
                      ),
                    ),
                  ),
                ];
              },
              body: TabBarView(
                controller: _tabController,
                children: [
                  _buildTweets(),
                  _buildReplies(),
                  _buildMedia(),
                ],
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}

Widget _buildTweets() {
  return ListView.builder(
    itemCount: 20, // ตัวอย่างจำนวนข้อมูลทวีตมากขึ้น
    itemBuilder: (context, index) {
      return ListTile(
        title: Text(
            'Tweet $index: This is some example tweet content.'), // เนื้อหาทวีตตัวอย่าง
        subtitle: const Text('Time and other details...'),
      );
    },
  );
}

Widget _buildReplies() {
  return ListView.builder(
    itemCount: 10, // จำนวน replies ตัวอย่าง
    itemBuilder: (context, index) {
      return ListTile(
        title: Text('Reply $index: This is an example reply...'),
        subtitle: const Text('Reply details...'),
      );
    },
  );
}

Widget _buildMedia() {
  return GridView.builder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2, // สร้างคอลัมน์ 2 ช่องสำหรับการแสดงรูปภาพ
    ),
    itemCount: 6, // ตัวอย่างจำนวน media
    itemBuilder: (context, index) {
      return Image.network(
        'https://via.placeholder.com/150', // URL รูปภาพตัวอย่าง
      );
    },
  );
}

// SliverPersistentHeader Delegate สำหรับ TabBar Sticky
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
