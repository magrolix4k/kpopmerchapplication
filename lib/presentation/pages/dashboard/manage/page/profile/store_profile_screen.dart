// //lib/presentation/pages/dashboard/sitepage/profile_page.dart

// import 'dart:async';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:kpopmerchapplication/models/store_model.dart';
// import 'package:kpopmerchapplication/models/user_model.dart';
// import 'package:kpopmerchapplication/presentation/widgets/reusable_button.dart';

// class StoreProfileScreen extends StatefulWidget {
//   final String? sid;
//   const StoreProfileScreen({
//     this.sid,
//     super.key,
//   });

//   @override
//   _StoreProfileScreenState createState() => _StoreProfileScreenState();
// }

// class _StoreProfileScreenState extends State<StoreProfileScreen>
//     with SingleTickerProviderStateMixin {
//   final ApiService apiService = ApiService();
//   late Timer _timer;
//   UserModel? _userData;
//   StoreModel? _storeData;
//   late TabController _tabController;
//   final ScrollController _scrollController = ScrollController();
//   bool _showUsername = false;
//   late String sid;
//   bool isMyProfile = false;

//   // ตรวจสอบว่าโปรไฟล์นี้เป็นของผู้ใช้ที่ล็อกอินอยู่หรือไม่
//   void _checkIfMyProfile() async {
//     String? currentUserId = FirebaseAuth.instance.currentUser?.uid;
//     String? currentStore = widget.sid;

//     print("currentUserId $currentUserId");
//     print("currentStoreId $currentStore");
//     if (currentUserId == widget.sid) {
//       setState(() {
//         isMyProfile = true;
//       });
//     }

//     if (currentUserId != null && currentStore != null) {
//       String isMyProfileFromDb = await apiService.checkProfile(currentUserId);
//       print("isMyProfileFromDb $isMyProfileFromDb");
//       if (currentUserId == isMyProfileFromDb) {
//         setState(() {
//           isMyProfile = true;
//         });
//       }
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     _fetchUserData();
//     _checkIfMyProfile();

//     _tabController = TabController(length: 3, vsync: this);
//     _scrollController.addListener(_scrollListener);

//     _timer = Timer.periodic(const Duration(seconds: 30), (Timer t) {
//       _fetchUserData();
//     });
//   }

//   // ฟังก์ชันสำหรับตรวจจับการเลื่อน
//   void _scrollListener() {
//     if (_scrollController.position.pixels > 200) {
//       setState(() {
//         _showUsername = true;
//       });
//     } else {
//       setState(() {
//         _showUsername = false;
//       });
//     }
//   }

// // ฟังก์ชันดึงข้อมูลผู้ใช้หรือร้านค้า
//   void _fetchUserData() async {
//     try {
//       dynamic profileData = await apiService.getStoreProfile(widget.sid!);

//       setState(() {
//         if (profileData is StoreModel) {
//           // ถ้าเป็นข้อมูลของ store
//           _storeData = profileData;
//         }
//       });
//     } catch (e) {
//       print('Error fetching data: $e');
//     }
//   }

//   @override
//   void dispose() {
//     _timer.cancel();
//     _tabController.dispose();
//     _scrollController.dispose();
//     super.dispose();
//   }

// // ฟังก์ชันสร้าง UI ของหน้าโปรไฟล์
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 255, 254, 254),
//       appBar: AppBar(
//         backgroundColor: const Color.fromARGB(255, 255, 254, 254),
//         title: _showUsername
//             ? Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     _userData?.name ??
//                         _storeData?.name ??
//                         "", // ใช้ _storeData ถ้า _userData เป็น null
//                     style: const TextStyle(fontSize: 20),
//                   ),
//                   const Text(
//                     "0 tweets",
//                     style: TextStyle(fontSize: 18),
//                   ),
//                 ],
//               ) // แสดง username ที่นี่เมื่อเลื่อนสุด
//             : null, // ไม่แสดงเมื่อไม่เลื่อนถึง
//       ),
//       body: _userData != null ||
//               _storeData != null // แสดงข้อมูลเมื่อมี userData หรือ storeData
//           ? NestedScrollView(
//               controller: _scrollController, // เชื่อม ScrollController
//               headerSliverBuilder:
//                   (BuildContext context, bool innerBoxIsScrolled) {
//                 return [
//                   SliverToBoxAdapter(
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               CircleAvatar(
//                                 radius: 50,
//                                 backgroundImage: (_userData?.profileImage ??
//                                             _storeData?.profileImage) !=
//                                         null
//                                     ? CachedNetworkImageProvider(
//                                         _userData?.profileImage ??
//                                             _storeData!.profileImage!)
//                                     : null,
//                                 child: (_userData?.profileImage == null &&
//                                         _storeData?.profileImage == null)
//                                     ? const Icon(Icons.person, size: 50)
//                                     : null,
//                               ),
//                               const SizedBox(width: 16),
//                               Expanded(
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     isMyProfile
//                                         ? Expanded(
//                                             child: Column(
//                                               children: [
//                                                 Text(
//                                                   '${_userData?.following ?? 0}',
//                                                   style: const TextStyle(
//                                                     fontWeight: FontWeight.bold,
//                                                     fontSize: 18,
//                                                   ),
//                                                 ),
//                                                 const Text('Following'),
//                                               ],
//                                             ),
//                                           )
//                                         : Container(),
//                                     //Divider จำลอง
//                                     isMyProfile
//                                         ? Container(
//                                             height: 30,
//                                             width: 1,
//                                             color: Colors.grey,
//                                           )
//                                         : Container(),
//                                     Expanded(
//                                       child: Column(
//                                         children: [
//                                           Text(
//                                             '${_userData?.followers ?? 0}',
//                                             style: const TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: 18,
//                                             ),
//                                           ),
//                                           const Text('Followers'),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Text(
//                             _userData?.name ?? _storeData?.name ?? "",
//                             style: const TextStyle(
//                               fontSize: 24,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Text(
//                             '@${_userData?.username ?? _storeData?.username ?? ""}',
//                             style: const TextStyle(
//                               fontSize: 16,
//                               color: Colors.grey,
//                             ),
//                           ),
//                           const SizedBox(height: 10),
//                           Text(
//                             _userData?.bio ?? _storeData?.bio ?? "",
//                             style: const TextStyle(
//                               fontSize: 16,
//                               color: Colors.black,
//                             ),
//                           ),
//                           const SizedBox(height: 10),
//                           Text(
//                             'Joined ${_storeData?.createAt ?? _userData?.createAt ?? ""}',
//                             style: const TextStyle(
//                               fontSize: 16,
//                               color: Colors.black,
//                             ),
//                           ),
//                           // ปุ่ม Edit profile และ Share profile
//                           const SizedBox(height: 10),
//                           Row(
//                             mainAxisSize: MainAxisSize.max,
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: isMyProfile
//                                 ? [
//                                     Expanded(
//                                       flex: 5, // ปุ่ม Message ขยาย 2 ส่วน
//                                       child: ReusableButton(
//                                         text: 'Edit profile',
//                                         onPressed: () {
//                                           // ฟังก์ชันเมื่อกดปุ่ม Edit profile
//                                         },
//                                         color: Colors.white, // สีของปุ่ม
//                                         textColor: Colors.black, // สีของข้อความ
//                                         padding: const EdgeInsets.symmetric(
//                                           vertical: 13,
//                                         ),
//                                       ),
//                                     ),
//                                     const SizedBox(width: 10),
//                                     Expanded(
//                                       flex: 2, // ปุ่ม Message ขยาย 2 ส่วน
//                                       child: ReusableButton(
//                                         text: 'Share profile',
//                                         onPressed: () {
//                                           // ฟังก์ชันเมื่อกดปุ่ม Share profile
//                                         },
//                                         color: Colors.white, // สีของปุ่ม
//                                         textColor: Colors.black, // สีของข้อความ
//                                         padding: const EdgeInsets.symmetric(
//                                           vertical: 13,
//                                         ),
//                                       ),
//                                     ),
//                                   ]
//                                 : [
//                                     Expanded(
//                                       flex: 5, // ปุ่ม Follow ขยาย 5 ส่วน
//                                       child: ReusableButton(
//                                         text: 'Follow',
//                                         onPressed: () {
//                                           // ฟังก์ชันเมื่อกดปุ่ม Follow
//                                         },
//                                         color: Colors.white, // สีของปุ่ม
//                                         textColor: Colors.black, // สีของข้อความ
//                                         padding: const EdgeInsets.symmetric(
//                                           vertical: 13,
//                                         ),
//                                       ),
//                                     ),
//                                     const SizedBox(width: 10),
//                                     Expanded(
//                                       flex: 2, // ปุ่ม Message ขยาย 2 ส่วน
//                                       child: ReusableButton(
//                                         text: 'Twitter',
//                                         onPressed: () {
//                                           // ฟังก์ชันเมื่อกดปุ่ม Message
//                                         },
//                                         color: Colors.white, // สีของปุ่ม
//                                         textColor: Colors.black, // สีของข้อความ
//                                         padding: const EdgeInsets.symmetric(
//                                           vertical: 13,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   SliverPersistentHeader(
//                     pinned: true,
//                     delegate: _SliverAppBarDelegate(
//                       TabBar(
//                         controller: _tabController,
//                         labelColor: Colors.blue,
//                         indicatorColor: Colors.blue,
//                         indicatorWeight: 4.0,
//                         indicatorSize: TabBarIndicatorSize.tab,
//                         tabs: const [
//                           Tab(text: 'Tweets'),
//                           Tab(text: 'Replies'),
//                           Tab(text: 'Media'),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ];
//               },
//               body: TabBarView(
//                 controller: _tabController,
//                 children: [
//                   _buildTweets(),
//                   _buildReplies(),
//                   _buildMedia(),
//                 ],
//               ),
//             )
//           : const Center(child: CircularProgressIndicator()),
//     );
//   }
// }

// Widget _buildTweets() {
//   return ListView.builder(
//     itemCount: 20, // ตัวอย่างจำนวนข้อมูลทวีตมากขึ้น
//     itemBuilder: (context, index) {
//       return ListTile(
//         title: Text(
//             'Tweet $index: This is some example tweet content.'), // เนื้อหาทวีตตัวอย่าง
//         subtitle: const Text('Time and other details...'),
//       );
//     },
//   );
// }

// Widget _buildReplies() {
//   return ListView.builder(
//     itemCount: 10, // จำนวน replies ตัวอย่าง
//     itemBuilder: (context, index) {
//       return ListTile(
//         title: Text('Reply $index: This is an example reply...'),
//         subtitle: const Text('Reply details...'),
//       );
//     },
//   );
// }

// Widget _buildMedia() {
//   return GridView.builder(
//     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//       crossAxisCount: 2, // สร้างคอลัมน์ 2 ช่องสำหรับการแสดงรูปภาพ
//     ),
//     itemCount: 6, // ตัวอย่างจำนวน media
//     itemBuilder: (context, index) {
//       return Image.network(
//         'https://via.placeholder.com/150', // URL รูปภาพตัวอย่าง
//       );
//     },
//   );
// }

// // SliverPersistentHeader Delegate สำหรับ TabBar Sticky
// class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
//   final TabBar _tabBar;

//   _SliverAppBarDelegate(this._tabBar);

//   @override
//   double get minExtent => _tabBar.preferredSize.height;
//   @override
//   double get maxExtent => _tabBar.preferredSize.height;

//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return Container(
//       color: const Color.fromARGB(255, 255, 254, 254),
//       child: _tabBar,
//     );
//   }

//   @override
//   bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
//     return false;
//   }
// }
