// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'api_service.dart';
// import 'product_page.dart'; // ต้อง import ไฟล์ product_page.dart

// class UserPage extends StatefulWidget {
//   const UserPage({super.key});

//   @override
//   _UserPageState createState() => _UserPageState();
// }

// class _UserPageState extends State<UserPage> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final ApiService apiService = ApiService();

//   User? currentUser; // ผู้ใช้ที่ล็อกอินเข้ามา
//   String? userEmail;
//   String userName = 'John Doe'; // ชื่อผู้ใช้ตัวอย่าง

//   @override
//   void initState() {
//     super.initState();
//     _checkUser();
//   }

//   // ตรวจสอบสถานะการล็อกอิน
//   void _checkUser() async {
//     currentUser = _auth.currentUser;
//     if (currentUser != null) {
//       // ดึงข้อมูลจาก MySQL ถ้ามีผู้ใช้ล็อกอิน
//       await fetchUserData(currentUser!.uid);
//     }
//     setState(() {});
//   }

//   // ฟังก์ชันล็อกอินด้วยอีเมลและรหัสผ่าน
//   Future<void> _login(String email, String password) async {
//     try {
//       UserCredential userCredential = await _auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       currentUser = userCredential.user;

//       // สร้างผู้ใช้ใน MySQL ถ้ายังไม่มี
//       // await apiService.createUser(currentUser!.uid, email, userName);

//       setState(() {});
//     } catch (e) {
//       print('Failed to login: $e');
//     }
//   }

//   // ดึงข้อมูลผู้ใช้จาก API ที่เชื่อมต่อ MySQL
//   Future<void> fetchUserData(String uid) async {
//     try {
//       final userData = await apiService.getUser(uid);
//       setState(() {
//         userEmail = userData['email'];
//         userName = userData['name'];
//       });
//       print('User data: $userData');
//     } catch (e) {
//       print(e);
//     }
//   }

//   // อัปเดตข้อมูลผู้ใช้
//   Future<void> _updateUserData(String newName) async {
//     if (currentUser != null) {
//       try {
//         await apiService.updateUser(
//             currentUser!.uid, currentUser!.email!, newName);
//         setState(() {
//           userName = newName;
//         });
//         print('User updated');
//       } catch (e) {
//         print(e);
//       }
//     }
//   }

//   // UI สำหรับแสดงข้อมูลผู้ใช้และการล็อกอิน
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('User Page')),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             if (currentUser != null) ...[
//               Text('Logged in as: $userEmail'),
//               Text('Name: $userName'),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () async {
//                   await _updateUserData('New Name'); // อัปเดตชื่อผู้ใช้
//                 },
//                 child: const Text('Update Name'),
//               ),
//               ElevatedButton(
//                 onPressed: () async {
//                   await _auth.signOut();
//                   setState(() {
//                     currentUser = null;
//                   });
//                 },
//                 child: const Text('Logout'),
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   // นำไปสู่ ProductPage
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const ProductPage()),
//                   );
//                 },
//                 child: const Text('Go to Products'),
//               ),
//             ] else ...[
//               const Text('Not logged in'),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () async {
//                   await _login('newuser@example.com', 'password123');
//                 },
//                 child: const Text('Login with Email/Password'),
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }
