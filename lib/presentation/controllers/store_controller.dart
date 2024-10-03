import 'package:get/get.dart';
import 'package:kpopmerchapplication/services/store_service/store_service.dart';

class StoreController extends GetxController {
  final StoreApiService _apiService = StoreApiService();
  RxList<dynamic> stores = <dynamic>[].obs; // รายการร้านค้าเป็น RxList
  RxMap storesProfile = {}.obs; // เก็บข้อมูลโปรไฟล์

  @override
  void onInit() {
    super.onInit();
    fetchStores(); // ดึงข้อมูลร้านค้าทันทีเมื่อ Controller ถูกสร้าง
  }

  // ฟังก์ชันดึงข้อมูลร้านค้าจาก API ทั้งหมด
  Future<void> fetchStores() async {
    try {
      // เรียก API เพื่อดึงข้อมูลร้านค้าทั้งหมด
      var response = await _apiService.getAllStores();

      // ตรวจสอบการตอบสนองของ API
      if (response.isNotEmpty) {
        stores.assignAll(response);
      } else {
        print('No stores found');
      }
    } catch (e) {
      // จัดการข้อผิดพลาดในการดึงข้อมูล
      print('Error fetching stores: $e');
      Get.snackbar('Error', 'Failed to load stores');
    }
  }

// ฟังก์ชันดึงข้อมูลร้านค้าสำหรับผู้ใช้ที่ล็อกอินอยู่
  Future<void> fetchStoresForUser(String userId) async {
    try {
      // เรียก API เพื่อดึงข้อมูลร้านค้าตาม owner_id
      var response = await _apiService.getStoresByUserId(userId);
      storesProfile.value = response; // อัปเดตข้อมูลใน `RxMap`

      // ตรวจสอบการตอบสนองของ API
      if (response.isNotEmpty) {
      } else {
        print('No stores found for user $userId');
        Get.snackbar('Info', 'No stores found for this user');
      }
    } catch (e) {
      // จัดการข้อผิดพลาดในการดึงข้อมูล
      print('Error fetching stores for user: $e');
      Get.snackbar(
          'Error', 'Failed to load stores for user. Please try again.');
    }
  }

  // ฟังก์ชันสำหรับรีเฟรชข้อมูลร้านค้า
  Future<void> refreshStores() async {
    stores.clear(); // ล้างข้อมูลปัจจุบัน
    await fetchStores(); // ดึงข้อมูลใหม่
  }
}
