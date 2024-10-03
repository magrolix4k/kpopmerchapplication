import 'package:get/get.dart';
import 'package:kpopmerchapplication/services/user_service/users_service.dart';

class ProfileController extends GetxController {
  final UserApiService userApiService = UserApiService();

  RxMap userProfile = {}.obs; // เก็บข้อมูลโปรไฟล์
  RxBool isLoading = false.obs; // สถานะการโหลดข้อมูล
  RxString errorMessage = ''.obs; // ข้อความข้อผิดพลาด

  // ฟังก์ชันดึงข้อมูลโปรไฟล์ผู้ใช้
  Future<void> fetchUserProfile(String uid) async {
    try {
      isLoading.value = true; // เริ่มการโหลดข้อมูล
      final profile = await userApiService.getUserById(uid);
      userProfile.value = profile; // อัปเดตข้อมูลใน `RxMap`
      errorMessage.value = ''; // ล้างข้อความข้อผิดพลาด
    } catch (e) {
      errorMessage.value = 'Failed to fetch user profile'; // จัดการข้อผิดพลาด
      Get.snackbar('Error', errorMessage.value); // แจ้งเตือนผู้ใช้
    } finally {
      isLoading.value = false; // เสร็จสิ้นการโหลดข้อมูล
    }
  }
}
