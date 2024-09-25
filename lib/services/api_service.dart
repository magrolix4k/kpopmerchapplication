import 'package:dio/dio.dart';
import 'package:kpopmerchapplication/config/config.dart';
import 'package:kpopmerchapplication/models/user_model.dart';

class ApiService {
  final Dio dio = Dio(BaseOptions(
    baseUrl: Config.userUrl,
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
    sendTimeout: const Duration(seconds: 30),
    headers: {
      'Content-Type': 'application/json',
    },
  ));

  // ฟังก์ชันสร้างผู้ใช้ใหม่
  Future<void> createUser(UserModel user) async {
    try {
      Response response = await dio.post(
        '/createUser',
        data: {
          'uid': user.uid,
          'email': user.email,
          'username': user.username,
          'name': user.name,
          'profileImage': user.profileImage,
          'bio': user.bio,
          'role': user.role,
        },
      );

      if (response.statusCode == 201) {
        print('User created successfully');
      } else {
        throw Exception('Failed to create user');
      }
    } catch (e) {
      print('Error creating user: $e');
      throw Exception('Error creating user: $e');
    }
  }

  // ฟังก์ชันอัปเดต last_login_at เมื่อผู้ใช้ล็อกอินสำเร็จ
  Future<void> updateLastLogin(String uid) async {
    try {
      Response response = await dio.put(
        '/updateLastLogin',
        data: {
          'uid': uid,
        },
      );

      if (response.statusCode == 200) {
        print('Last login updated successfully');
      } else {
        throw Exception('Failed to update last login');
      }
    } catch (e) {
      print('Error updating last login: $e');
      throw Exception('Error updating last login: $e');
    }
  }

  // ฟังก์ชันสร้างร้านค้าใหม่
  Future<void> createStore({
    required String ownerId,
    required String sid,
    required String username,
    required String name,
    required String profileImage,
    required String bio,
  }) async {
    try {
      Response response = await dio.post(
        '/createStore',
        data: {
          'owner_id': ownerId,
          'sid': sid,
          'username': username,
          'name': name,
          'profile_image': profileImage,
          'bio': bio,
        },
      );

      if (response.statusCode == 201) {
        print('Store created successfully');
      } else {
        throw Exception('Failed to create store');
      }
    } catch (e) {
      print('Error creating store: $e');
      throw Exception('Error creating store: $e');
    }
  }

  // ฟังก์ชันดึงข้อมูลผู้ใช้ตาม UID
  Future<UserModel?> getUser(String uid) async {
    try {
      Response response = await dio.get('/getUser/$uid');

      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      } else {
        throw Exception('Failed to fetch user');
      }
    } catch (e) {
      print('Error fetching user: $e');
      return null;
    }
  }

  // ฟังก์ชันอัปเดตข้อมูลผู้ใช้ เช่นโปรไฟล์
  Future<void> updateUserProfile({
    required String uid,
    required String profileImage,
    required String name,
    required String bio,
  }) async {
    try {
      Response response = await dio.put(
        '/updateUserProfile',
        data: {
          'uid': uid,
          'profileImage': profileImage,
          'name': name,
          'bio': bio,
        },
      );

      if (response.statusCode == 200) {
        print('User profile updated successfully');
      } else {
        throw Exception('Failed to update user profile');
      }
    } catch (e) {
      print('Error updating user profile: $e');
      throw Exception('Error updating user profile: $e');
    }
  }
}
