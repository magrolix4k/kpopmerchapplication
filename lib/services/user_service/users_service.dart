import 'package:dio/dio.dart';

class UserApiService {
  final Dio dio = Dio(BaseOptions(
    baseUrl: 'http://infinitehouse.tech:8088/api', // เปลี่ยน URL ตามที่ต้องการ
    headers: {'Content-Type': 'application/json'},
  ));

  // ดึงข้อมูลผู้ใช้ทั้งหมดจาก MySQL
  Future<List<dynamic>> getAllUsers() async {
    try {
      final response = await dio.get('/users');
      if (response.statusCode == 200) {
        return response.data; // ข้อมูลผู้ใช้ทั้งหมด
      } else {
        throw Exception('Failed to fetch users');
      }
    } catch (e) {
      print('Error fetching all users: $e');
      throw e;
    }
  }

// ดึงข้อมูลผู้ใช้ตาม UID จาก MySQL
  Future<Map<String, dynamic>> getUserById(String uid) async {
    try {
      final response = await dio.get('/users/$uid');
      if (response.statusCode == 200 && response.data is Map) {
        return response.data; // ข้อมูลผู้ใช้ตาม UID เป็น Map
      } else {
        throw Exception('Failed to fetch user by ID');
      }
    } catch (e) {
      print('Error fetching user by ID: $e');
      throw e;
    }
  }

  // สร้างผู้ใช้ใหม่ใน MySQL
  Future<void> createUser(Map<String, dynamic> userData) async {
    try {
      final response = await dio.post('/users', data: userData);
      if (response.statusCode != 201) {
        throw Exception('Failed to create user in MySQL');
      }
    } catch (e) {
      print('Error creating user: $e');
      throw e;
    }
  }

  // อัปเดตข้อมูลผู้ใช้ใน MySQL
  Future<void> updateUser(String uid, Map<String, dynamic> userData) async {
    try {
      final response = await dio.put('/users/$uid', data: userData);
      if (response.statusCode != 200) {
        throw Exception('Failed to update user in MySQL');
      }
    } catch (e) {
      print('Error updating user: $e');
      throw e;
    }
  }

  // ลบผู้ใช้ใน MySQL
  Future<void> deleteUser(String uid) async {
    try {
      final response = await dio.delete('/users/$uid');
      if (response.statusCode != 200) {
        throw Exception('Failed to delete user');
      }
    } catch (e) {
      print('Error deleting user: $e');
      throw e;
    }
  }
}
