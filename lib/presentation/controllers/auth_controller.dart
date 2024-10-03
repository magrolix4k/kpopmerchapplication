import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:kpopmerchapplication/services/store_service/store_service.dart';

import 'package:kpopmerchapplication/services/user_service/users_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  final UserApiService apiService = UserApiService();
  final StoreApiService storeApiService = StoreApiService();
  final ImagePicker picker = ImagePicker();

  Rx<User?> firebaseUser = Rx<User?>(null);

  var email = ''.obs;
  var password = ''.obs;
  var name = ''.obs;
  var username = ''.obs;
  var profileImage = ''.obs;
  var bio = ''.obs;

  @override
  void onInit() {
    super.onInit();

    // ตรวจสอบสถานะผู้ใช้เมื่อเริ่มแอป
    _loadUserFromPreferences();
    _loadRoleFromPreferences();
    getUserRole();
    // ติดตามสถานะการเปลี่ยนแปลงของผู้ใช้
    auth.authStateChanges().listen((User? user) {
      if (user != null) {
        firebaseUser.value = user;
        _saveUserToPreferences(user); // บันทึกสถานะผู้ใช้
        Get.offAllNamed('/dashboard');
      } else {
        Get.offAllNamed('/login');
      }
    });
  }

  // โหลดข้อมูลผู้ใช้จาก SharedPreferences
  Future<void> _loadUserFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');

    if (userId != null) {
      User? user = auth.currentUser;
      if (user != null) {
        firebaseUser.value = user;
        Get.offAllNamed('/dashboard');
      }
    }
  }

  // บันทึกข้อมูลผู้ใช้ใน SharedPreferences
  Future<void> _saveUserToPreferences(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', user.uid);
  }

  // บันทึกข้อมูล role ใน SharedPreferences
  Future<void> _saveRoleToPreferences(String role) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userRole', role);
  }

  // ลบสถานะผู้ใช้จาก SharedPreferences เมื่อออกจากระบบ
  Future<void> _clearUserFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
    await prefs.remove('userRole');
  }

  // โหลดข้อมูล role จาก SharedPreferences
  Future<String?> _loadRoleFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userRole');
  }

  Future<String?> getUserRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userRole');
  }

  // ฟังก์ชันออกจากระบบ
  void signOut() async {
    await auth.signOut();
    firebaseUser.value = null;
    _clearUserFromPreferences();
  }

  // ฟังก์ชันเลือกโปรไฟล์รูปภาพและครอบตัดรูป
  Future<void> pickProfileImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      // ครอบตัดรูปภาพที่เลือกโดยใช้ ImageCropper
      CroppedFile? croppedImage =
          await ImageCropper().cropImage(sourcePath: image.path, uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.blue,
          toolbarWidgetColor: Colors.white,
          lockAspectRatio: true,
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
          ],
        ),
      ]);

      // ถ้าผู้ใช้ครอบตัดรูปแล้ว ให้บันทึก path ของรูปครอบตัดนั้น
      if (croppedImage != null) {
        profileImage.value = croppedImage.path;
      }
    }
  }

  // ฟังก์ชันอัปโหลดรูปโปรไฟล์ไปยัง Firebase Storage
  Future<String?> uploadProfileImage(String uid) async {
    if (profileImage.isNotEmpty) {
      try {
        final file = File(profileImage.value);
        final ref = storage.ref().child('profile_images').child('$uid.jpg');
        await ref.putFile(file);
        return await ref.getDownloadURL();
      } catch (e) {
        print("Error uploading profile image: $e");
        return null;
      }
    }
    return null;
  }

  // ฟังก์ชันลงทะเบียน
  Future<void> register() async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email.value, password: password.value);

      User? user = userCredential.user;
      if (user != null) {
        String? profileImageUrl = await uploadProfileImage(user.uid);

        // ส่งข้อมูลผู้ใช้ไปยัง MySQL
        await apiService.createUser({
          'uid': user.uid,
          'email': user.email!,
          'username': username.value,
          'name': name.value,
          'profile_image': profileImageUrl,
          'bio': bio.value,
        });

        firebaseUser.value = user;
      }
    } catch (e) {
      Get.snackbar("Registration Error", e.toString());
    }
  }

  Future<void> login() async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email.value, password: password.value);

      User? user = userCredential.user;
      if (user != null) {
        // ดึงข้อมูล role จาก MySQL โดยใช้ uid ของผู้ใช้ที่เข้าสู่ระบบ
        var userData = await apiService.getUserById(user.uid);
        String role = userData['role']; // สมมติว่าข้อมูล role อยู่ใน response
        print("stay on role $role");

        // บันทึก role ของผู้ใช้เพื่อใช้งานในแอป
        await _saveRoleToPreferences(role);

        firebaseUser.value = user;
      }
    } catch (e) {
      Get.snackbar("Login Error", e.toString());
    }
  }

  // ฟังก์ชันรีเซ็ตรหัสผ่าน
  Future<void> resetPassword() async {
    try {
      await auth.sendPasswordResetEmail(email: email.value);
      Get.snackbar("Success", "Password reset link sent to ${email.value}");
    } catch (e) {
      Get.snackbar("Error", "Failed to send reset link. Please try again.");
    }
  }

  // ฟังก์ชันเชื่อมบัญชี Twitter กับผู้ใช้ปัจจุบัน
  Future<void> linkWithTwitter() async {
    try {
      // สร้าง TwitterAuthProvider
      final TwitterAuthProvider twitterProvider = TwitterAuthProvider();

      // ตรวจสอบว่ามีผู้ใช้ล็อกอินอยู่หรือไม่
      final user = auth.currentUser;

      if (user != null) {
        // เชื่อมบัญชี Twitter กับผู้ใช้ปัจจุบันใน Android
        final UserCredential userCredential =
            await user.linkWithProvider(twitterProvider);
        // ดึงข้อมูลจาก Twitter
        final twitterProfile = userCredential.additionalUserInfo?.profile;
        final String twitterName = twitterProfile?['name'];
        final String twitterUsername = twitterProfile?['screen_name'];
        final String twitterProfileImage =
            twitterProfile?['profile_image_url_https'];
        final String twitterBio = twitterProfile?['description'];
        final String twitterId = twitterProfile?['id_str'];

        // เรียกใช้ createStore เพื่อสร้างร้านค้าใหม่จากข้อมูล Twitter
        await storeApiService.createStore({
          'owner_id': user.uid,
          'sid': twitterId,
          'username': twitterUsername,
          'name': twitterName,
          'profile_image': twitterProfileImage,
          'bio': twitterBio,
        });

        Get.snackbar(
            "Success", "Successfully linked Twitter and created store");
      }
    } catch (e) {
      print("Error linking with Twitter: $e");
      Get.snackbar("Error", "Failed to link Twitter");
    }
  }

  // ฟังก์ชันยกเลิกการเชื่อมบัญชีกับ provider (เช่น Twitter หรือ Google)
  Future<void> unlinkProvider(String providerId) async {
    try {
      final user = auth.currentUser;
      if (user != null) {
        await user.unlink(providerId); // ยกเลิกการเชื่อมกับ provider ที่ระบุ
        Get.snackbar("Success", "Unlinked $providerId successfully");
      }
    } catch (e) {
      print("Error unlinking provider: $e");
      Get.snackbar("Error", "Failed to unlink $providerId");
    }
  }
}
