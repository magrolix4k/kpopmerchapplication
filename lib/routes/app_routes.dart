import 'package:get/get.dart';
import 'package:kpopmerchapplication/presentation/pages/dashbaord/home_page.dart';
import 'package:kpopmerchapplication/presentation/pages/auth/login/login_page.dart';
import 'package:kpopmerchapplication/presentation/pages/dashbaord/sitepage/profile_page.dart';
import 'package:kpopmerchapplication/presentation/pages/auth/registration/craete_store_page.dart';
import 'package:kpopmerchapplication/presentation/pages/auth/registration/register_email_page.dart';
import 'package:kpopmerchapplication/presentation/pages/dashbaord/sitepage/setting_page.dart';
import 'package:kpopmerchapplication/presentation/pages/dashboard_page.dart';

class Routes {
  static const login = '/login';
  static const register = '/register';
  static const craeteStore = '/createStore';
  static const home = '/home';
  static const dashboard = '/dashboard';
  static const profile = '/profile';
  static const settings = '/settings';
}

class AppPages {
  static final pages = [
    GetPage(name: Routes.login, page: () => LoginPage()),
    GetPage(name: Routes.register, page: () => RegisterEmailPage()),
    GetPage(name: Routes.craeteStore, page: () => CreateStorePage()),
    GetPage(name: Routes.home, page: () => const HomePage()),
    GetPage(name: Routes.profile, page: () => const ProfilePage()),
    GetPage(name: Routes.dashboard, page: () => const DashboardPage()),
    GetPage(name: Routes.settings, page: () => const SettingPage()),
  ];
}
