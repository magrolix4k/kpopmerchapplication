import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kpopmerchapplication/routes/app_routes.dart';
import 'presentation/controllers/auth_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(AuthController()); // ลงทะเบียน AuthController
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.login, // เส้นทางเริ่มต้นคือหน้า Login
      getPages: AppPages.pages, // กำหนดเส้นทางการนำทางระหว่างหน้า
    );
  }
}
