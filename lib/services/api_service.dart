import 'package:dio/dio.dart';
import 'package:kpopmerchapplication/models/user_model.dart';

class ApiService {
  final Dio dio = Dio(BaseOptions(
    baseUrl: 'http://infinitehouse.tech:8080/api', // URL ของ API ของคุณ
    connectTimeout: const Duration(seconds: 5), // Timeout 5 วินาที
    receiveTimeout:
        const Duration(seconds: 3), // Timeout 3 วินาทีสำหรับการตอบสนอง
    sendTimeout: const Duration(seconds: 30),

    headers: {
      'Content-Type': 'application/json',
    },
  ));

  // อัปเดต last_login_at ใน MySQL
  Future<void> updateLastLogin(String uid) async {
    try {
      Response response = await dio.put('/users/update-login/$uid');

      if (response.statusCode != 200) {
        throw Exception('Failed to update last login');
      }
    } catch (e) {
      throw Exception('Error updating last login: $e');
    }
  }

  // ฟังก์ชันเพิ่มผู้ใช้ใหม่หรืออัปเดตข้อมูลผู้ใช้ใน MySQL
  Future<void> createUser(UserModel user) async {
    try {
      Response response = await dio.post(
        '/users',
        data: user.toJson(),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to create/update user');
      }
    } catch (e) {
      throw Exception('Error creating user: $e');
    }
  }

  // ฟังก์ชันดึงข้อมูลผู้ใช้จาก MySQL
  Future<UserModel> getUser(String uid) async {
    try {
      Response response = await dio.get('/users/$uid');

      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load user data');
      }
    } on DioException catch (e) {
      throw Exception('Error loading user: ${e.response?.statusCode}');
    }
  }
}
