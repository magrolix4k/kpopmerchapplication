import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kpopmerchapplication/presentation/controllers/product_controller.dart';
import 'package:kpopmerchapplication/presentation/controllers/store_controller.dart';
import 'package:kpopmerchapplication/routes/app_routes.dart';
import 'presentation/controllers/auth_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.testMode = true;
  Get.put(AuthController());
  Get.put(StoreController());
  Get.put(ProductController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'IBM Plex Sans Thai',
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
          bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
          titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      initialRoute: Routes.login, // ตรวจสอบว่าผู้ใช้ล็อกอินแล้วหรือยัง
      getPages: AppPages.pages,
    );
  }
}
