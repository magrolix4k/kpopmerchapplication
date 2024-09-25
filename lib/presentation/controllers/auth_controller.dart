import 'dart:io'; // สำหรับการจัดการไฟล์
import 'package:firebase_storage/firebase_storage.dart'; // สำหรับ Firebase Storage
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kpopmerchapplication/models/user_model.dart';
import 'package:kpopmerchapplication/routes/app_routes.dart';
import 'package:kpopmerchapplication/services/api_service.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  late Rx<User?> _user;
  final ApiService apiService = ApiService();

  // เก็บข้อมูลจากหลายหน้า
  var uids = ''.obs;
  var email = ''.obs;
  var username = ''.obs;
  var password = ''.obs;
  var name = ''.obs;
  var profileImage = ''.obs;
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
      Get.offAllNamed(Routes.dashboard);
    }
  }

  // ฟังก์ชันเลือกภาพจากแกลเลอรี
  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      profileImage.value = image.path; // เก็บ path ของรูป
    }
  }

  // ฟังก์ชันอัปโหลดรูปไปยัง Firebase Storage
  Future<String?> uploadProfileImage(String uid) async {
    if (profileImage.value.isNotEmpty) {
      try {
        File file = File(profileImage.value);
        String fileName = 'profile_images/$uid.jpg';

        // อัปโหลดไฟล์ไปยัง Firebase Storage
        UploadTask uploadTask = storage.ref(fileName).putFile(file);

        // รอการอัปโหลดสำเร็จแล้วดึง URL ของรูปที่อัปโหลด
        TaskSnapshot snapshot = await uploadTask;
        String downloadUrl = await snapshot.ref.getDownloadURL();
        return downloadUrl; // ส่งคืน URL ของรูป
      } catch (e) {
        print("Error uploading image: $e");
        return null;
      }
    }
    return null;
  }

  // ฟังก์ชันลงทะเบียนผู้ใช้ใหม่
  Future<void> register() async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email.value, password: password.value);
      User? user = userCredential.user;

      if (user != null) {
        String? profileImageUrl = await uploadProfileImage(user.uid);
        uids.value = user.uid;

        UserModel newUser = UserModel(
          uid: user.uid,
          email: user.email!,
          name: name.value,
          username: username.value,
          profileImage: profileImageUrl,
          bio: bio.value,
          role: role.value,
        );

        await apiService.createUser(newUser);
        await apiService.updateLastLogin(user.uid);
      }
    } catch (e) {
      Get.rawSnackbar(title: "Registration Error", message: e.toString());
      print("Registration Error ${e.toString()}");
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
      Get.rawSnackbar(title: "Login Error", message: e.toString());
      print("Login Error ${e.toString()}");
    }
  }

  // ฟังก์ชันเชื่อมต่อ Twitter ผ่าน Firebase
  Future<UserCredential?> signInWithTwitter() async {
    try {
      // สร้าง provider สำหรับ Twitter
      TwitterAuthProvider twitterProvider = TwitterAuthProvider();

      // ทำการล็อกอินผ่าน Twitter
      return await auth.signInWithProvider(twitterProvider);
    } catch (e) {
      Get.rawSnackbar(title: "Twitter Login Error", message: e.toString());
      print("Twitter Login Error ${e.toString()}");
      return null;
    }
  }

  // ฟังก์ชันสร้างข้อมูลร้านค้าใน MySQL
  Future<void> registerStore(UserCredential twitterCredential) async {
    final twitterProfile = twitterCredential.additionalUserInfo?.profile;
    final String? twitterName = twitterProfile?['name'];
    final String? twitterUsername = twitterProfile?['screen_name'];
    final String? twitterProfileImage =
        twitterProfile?['profile_image_url_https'];
    final String? twitterBio = twitterProfile?['description'];
    final String? twitterId = twitterProfile?['id_str'];

    // บันทึกข้อมูลร้านค้าลงในฐานข้อมูล MySQL ผ่าน API
    try {
      await apiService.createStore(
        ownerId: uids.value,
        sid: twitterId!,
        name: twitterName!,
        username: twitterUsername!,
        profileImage: twitterProfileImage!,
        bio: twitterBio ?? 'Bio',
      );
    } catch (e) {
      Get.rawSnackbar(title: "Store Registration Error", message: e.toString());
      print("registerStore Registration Error ${e.toString()}");
    }
  }

  // ฟังก์ชันสำหรับสร้างร้านค้า
  Future<void> createStore() async {
    try {
      // เชื่อมต่อบัญชี Twitter เพื่อสร้างร้านค้า
      UserCredential? twitterCredential = await signInWithTwitter();

      if (twitterCredential != null) {
        await registerStore(twitterCredential);

        Get.rawSnackbar(
            title: "Success", message: "Store created successfully!");
      }
    } catch (e) {
      Get.rawSnackbar(title: "CreateStore Error", message: e.toString());
      print("createStore Registration Error ${e.toString()}");
    }
  }

  // ฟังก์ชันออกจากระบบ
  void signOut() async {
    await auth.signOut();
  }
}
