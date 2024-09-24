import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kpopmerchapplication/models/user_model.dart';
import 'package:kpopmerchapplication/routes/app_routes.dart';
import 'package:kpopmerchapplication/services/api_service.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  FirebaseAuth auth = FirebaseAuth.instance;
  late Rx<User?> _user;
  final ApiService apiService = ApiService();

  // เก็บข้อมูลจากหลายหน้า
  var email = ''.obs;
  var username = ''.obs;
  var password = ''.obs;
  var name = ''.obs;
  var profileImage = 'dwase.jpg'.obs;
  var bio = ''.obs;
  var role = 'user'.obs;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());
    ever(_user, _initialScreen);
  }

  // ตรวจสอบว่าไปหน้าไหนเมื่อล็อกอินสำเร็จหรือออกจากระบบ
  _initialScreen(User? user) {
    if (user == null) {
      Get.offAllNamed(Routes.login);
    } else {
      Get.offAllNamed(Routes.home);
    }
  }

  // ฟังก์ชันลงทะเบียนผู้ใช้ใหม่
  void register() async {
    try {
      // ลงทะเบียนกับ Firebase Authentication
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email.value, password: password.value); // ใช้ข้อมูลจาก Obx
      User? user = userCredential.user;

      if (user != null) {
        // สร้างผู้ใช้ใน MySQL ผ่าน API พร้อมข้อมูลเพิ่มเติมจากหลายหน้า
        UserModel newUser = UserModel(
          uid: user.uid,
          email: user.email!,
          name: name.value,
          username: username.value, // ใช้ข้อมูลที่กรอกจากหน้าอื่น
          profileImage: profileImage.value,
          bio: bio.value,
          role: role.value, // ค่า role ที่เลือกจากหน้า role
        );
        await apiService
            .createUser(newUser); // เรียกใช้ createUser ที่เชื่อมกับ MySQL
        await apiService
            .updateLastLogin(user.uid); // เรียก API ที่อัปเดต last_login_at
      }
    } catch (e) {
      Get.snackbar("Registration Error", e.toString(),
          backgroundColor: Colors.red);
    }
  }

  // ฟังก์ชันล็อกอินและอัปเดต last_login_at ใน MySQL
  void login(String email, String password) async {
    try {
      // ล็อกอินกับ Firebase Authentication
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = userCredential.user;

      if (user != null) {
        // อัปเดต last_login_at ใน MySQL ผ่าน API
        await apiService.updateLastLogin(user.uid);
      }
    } catch (e) {
      Get.snackbar("Login Error", e.toString(), backgroundColor: Colors.red);
    }
  }

  // ฟังก์ชันออกจากระบบ
  void signOut() async {
    await auth.signOut();
  }
}
