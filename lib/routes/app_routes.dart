//lib/presentation/routes/app_routes.dart

import 'package:get/get.dart';
import 'package:kpopmerchapplication/presentation/pages/auth/login/login_page.dart';
import 'package:kpopmerchapplication/presentation/pages/auth/registration/register_email_page.dart';
import 'package:kpopmerchapplication/presentation/pages/auth/registration/register_profile.dart';
import 'package:kpopmerchapplication/presentation/pages/auth/reset_pwd/forgot_pwd.dart';
import 'package:kpopmerchapplication/presentation/pages/dashboard/dashboard_page.dart';
import 'package:kpopmerchapplication/presentation/pages/dashboard/home/product_screen.dart';
import 'package:kpopmerchapplication/presentation/pages/dashboard/notification/store_screen.dart';

class Routes {
  static const login = '/login';
  static const register = '/register';
  static const dashboard = '/dashboard';
  static const store = '/store';
  static const products = '/products';
  static const addprofile = '/addprofile';
  static const password = '/password';
}

class AppPages {
  static final pages = [
    GetPage(name: Routes.login, page: () => LoginScreen()),
    GetPage(name: Routes.register, page: () => const RegisterScreen()),
    GetPage(name: Routes.store, page: () => StoreScreen()),
    GetPage(name: Routes.products, page: () => ProductListScreen()),
    GetPage(name: Routes.addprofile, page: () => const RegisterProfile()),
    GetPage(name: Routes.password, page: () => ForgotPasswordScreen()),
    GetPage(name: Routes.dashboard, page: () => const DashboardPage()),
  ];
}
