import 'package:dio/dio.dart';

class StoreApiService {
  final Dio dio = Dio(BaseOptions(
    baseUrl: 'http://infinitehouse.tech:8088/api', // เปลี่ยน URL ตามที่ต้องการ
    headers: {'Content-Type': 'application/json'},
  ));

  // ดึงข้อมูลร้านค้าทั้งหมดจาก MySQL
  Future<List<dynamic>> getAllStores() async {
    try {
      final response = await dio.get('/stores');
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to fetch stores');
      }
    } catch (e) {
      print('Error fetching all stores: $e');
      throw e;
    }
  }

  // ดึงข้อมูลร้านค้าตาม SID จาก MySQL
  Future<Map<String, dynamic>> getStoreById(String sid) async {
    try {
      final response = await dio.get('/stores/sid/$sid');
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to fetch store by ID');
      }
    } catch (e) {
      print('Error fetching store by ID: $e');
      throw e;
    }
  }

// ใน StoreApiService
  Future<Map<String, dynamic>> getStoresByUserId(String userId) async {
    try {
      final response = await dio.get('/stores/ownerId/$userId');
      return response.data;
    } catch (e) {
      print('Error fetching stores by user: $e');
      throw e;
    }
  }

  // สร้างร้านค้าใหม่ใน MySQL
  Future<void> createStore(Map<String, dynamic> storeData) async {
    try {
      final response = await dio.post('/stores', data: storeData);
      if (response.statusCode != 201) {
        throw Exception('Failed to create store in MySQL');
      }
    } catch (e) {
      print('Error creating store: $e');
      throw e;
    }
  }

  // อัปเดตข้อมูลร้านค้าใน MySQL
  Future<void> updateStore(String sid, Map<String, dynamic> storeData) async {
    try {
      final response = await dio.put('/stores/$sid', data: storeData);
      if (response.statusCode != 200) {
        throw Exception('Failed to update store in MySQL');
      }
    } catch (e) {
      print('Error updating store: $e');
      throw e;
    }
  }

  // ลบร้านค้าใน MySQL
  Future<void> deleteStore(String sid) async {
    try {
      final response = await dio.delete('/stores/$sid');
      if (response.statusCode != 200) {
        throw Exception('Failed to delete store');
      }
    } catch (e) {
      print('Error deleting store: $e');
      throw e;
    }
  }
}
