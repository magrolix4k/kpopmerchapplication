// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class ApiService {
//   final String baseUrl = 'http://infinitehouse.tech:8080'; // URL ของ API

//   // สร้างผู้ใช้ใหม่ใน MySQL
//   Future<void> createUser(String uid, String email, String name) async {
//     final response = await http.post(
//       Uri.parse('$baseUrl/users'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({
//         'uid': uid,
//         'email': email,
//         'name': name,
//       }),
//     );

//     if (response.statusCode == 200) {
//       print('User created successfully');
//     } else {
//       throw Exception('Failed to create user');
//     }
//   }

//   // ดึงข้อมูลผู้ใช้จาก MySQL โดยใช้ UID
//   Future<Map<String, dynamic>> getUser(String uid) async {
//     final response = await http.get(
//       Uri.parse('$baseUrl/users/$uid'),
//     );

//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception('Failed to load user data');
//     }
//   }

//   // อัปเดตข้อมูลผู้ใช้
//   Future<void> updateUser(String uid, String email, String name) async {
//     final response = await http.put(
//       Uri.parse('$baseUrl/users/$uid'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({
//         'email': email,
//         'name': name,
//       }),
//     );

//     if (response.statusCode == 200) {
//       print('User updated successfully');
//     } else {
//       throw Exception('Failed to update user');
//     }
//   }

//   // ลบข้อมูลผู้ใช้
//   Future<void> deleteUser(String uid) async {
//     final response = await http.delete(
//       Uri.parse('$baseUrl/users/$uid'),
//     );

//     if (response.statusCode == 200) {
//       print('User deleted successfully');
//     } else {
//       throw Exception('Failed to delete user');
//     }
//   }

//   // ฟังก์ชันดึงข้อมูลสินค้าทั้งหมด
//   Future<List<dynamic>> getAllProducts() async {
//     final response = await http.get(Uri.parse('$baseUrl/products'));

//     if (response.statusCode == 200) {
//       return jsonDecode(
//           response.body); // Return รายการสินค้าทั้งหมดในรูปแบบ JSON
//     } else {
//       throw Exception('Failed to load products');
//     }
//   }

//   // ฟังก์ชันดึงข้อมูลสินค้าของผู้ใช้เฉพาะราย
//   Future<List<dynamic>> getProductsByUser(String uid) async {
//     final response = await http.get(Uri.parse('$baseUrl/products/user/$uid'));

//     if (response.statusCode == 200) {
//       return jsonDecode(
//           response.body); // Return รายการสินค้าที่ดึงมาได้ในรูปแบบ JSON
//     } else {
//       throw Exception('Failed to load products');
//     }
//   }

//   // อัปเดตข้อมูลสินค้า
//   Future<void> updateProduct(
//       String productId, Map<String, dynamic> updatedData) async {
//     final response = await http.put(
//       Uri.parse('$baseUrl/products/$productId'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode(updatedData),
//     );

//     if (response.statusCode != 200) {
//       throw Exception('Failed to update product');
//     }
//   }
// }
