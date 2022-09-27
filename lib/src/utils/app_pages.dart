import 'package:get/get.dart';
import 'package:it_project/src/ui/base/bindings/home_binding.dart';
import 'package:it_project/src/ui/base/bindings/login_binding.dart';
import 'package:it_project/src/ui/home_screen/home_screen.dart';
import 'package:it_project/src/ui/login_and_register/login_screen.dart';
import 'package:it_project/src/ui/login_and_register/register_screen.dart';
import 'package:it_project/src/ui/main_screen.dart';
import 'package:it_project/src/ui/my_book/my_book_screen.dart';

import '../ui/base/bindings/main_binding.dart';
import '../ui/base/bindings/my_book_binding.dart';
import '../ui/base/bindings/register_binding.dart';

class AppPages {
  static const String loginScreen = _Paths.loginScreen;
  static const String registerScreen = _Paths.registerScreen;

  static const String homeScreen = _Paths.homeScreen;
  static const String mainScreen = _Paths.mainScreen;
  static const String myBookScreen = _Paths.myBookScreen;
  static final pages = [
    GetPage(
      name: _Paths.mainScreen,
      page: () => const MainScreen(),
      binding: MainBinding(),
    ),
    GetPage(
      name: _Paths.loginScreen,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.registerScreen,
      page: () => const RegisterScreen(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.homeScreen,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.myBookScreen,
      page: () => const MyBookScreen(),
      binding: MyBookBinding(),
    ),
  ];
}

abstract class _Paths {
  static const String loginScreen = "/login-screen";
  static const String registerScreen = "/register-screen";
  static const String homeScreen = "/home-screen";
  static const String mainScreen = "/main-screen";
  static const String myBookScreen = "/my-book-screen";
}
