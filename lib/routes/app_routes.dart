import 'package:get/get.dart';
import 'package:kpopmerchapplication/views/home_page.dart';
import 'package:kpopmerchapplication/views/login_page.dart';
import 'package:kpopmerchapplication/views/registration/register_email_page.dart';

class Routes {
  static const login = '/login';
  static const register = '/register';
  static const home = '/home';
}

class AppPages {
  static final pages = [
    GetPage(name: Routes.login, page: () => LoginPage()),
    GetPage(name: Routes.register, page: () => RegisterEmailPage()),
    GetPage(name: Routes.home, page: () => const HomePage()),
  ];
}
