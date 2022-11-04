import 'package:get/get.dart';
import 'package:it_project/src/configs/bindings/cart_binding.dart';
import 'package:it_project/src/features/main/home/search/search_screen.dart';
import 'package:it_project/src/widgets/product_general/product_general_model.dart';

import '../configs/bindings/home_binding.dart';
import '../configs/bindings/login_binding.dart';
import '../configs/bindings/main_binding.dart';
import '../configs/bindings/my_book_binding.dart';
import '../configs/bindings/otp_check_binding.dart';
import '../configs/bindings/register_binding.dart';
import '../core/login_register/screens/login_screen.dart';
import '../core/login_register/screens/otp_check_screen.dart';
import '../core/login_register/screens/register_screen.dart';
import '../features/main/home/home_screen.dart';
import '../features/main/home/search/search_binding.dart';
import '../features/main_screen.dart';
import '../features/my_book/my_book_screen.dart';
import '../features/shopping_cart/cart_screen.dart';
import '../features/test_screen/next_test_screen.dart';
import '../features/test_screen/next_tested_binding.dart';

class AppPages {
  static const String loginScreen = _Paths.loginScreen;
  static const String registerScreen = _Paths.registerScreen;
  static const String otpCheckScreen = _Paths.otpCheckScreen;

  static const String homeScreen = _Paths.homeScreen;
  static const String mainScreen = _Paths.mainScreen;
  static const String myBookScreen = _Paths.myBookScreen;
  static const String nextTestedScreen = _Paths.nextTestedScreen;
  static const String cartScreen = _Paths.cartScreen;
  static const String searchScreen = _Paths.searchScreen;
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
      name: _Paths.otpCheckScreen,
      page: () => const OtpCheckScreen(),
      binding: OtpCheckBinding(),
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
    GetPage(
      name: _Paths.nextTestedScreen,
      page: () => const NextTestScreen(),
      binding: NextTestedBinding(),
    ),
    GetPage(
      name: _Paths.cartScreen,
      page: () => CartScreen(
        product: Get.arguments as ProductGeneralModel,
      ),
      binding: CartBinding(),
    ),
    GetPage(
      name: _Paths.searchScreen,
      page: () => const SearchScreen(),
      binding: SearchBinding(),
    ),
  ];
}

abstract class _Paths {
  static const String loginScreen = "/login-screen";
  static const String registerScreen = "/register-screen";
  static const String otpCheckScreen = "/otp-check-screen";
  static const String homeScreen = "/home-screen";
  static const String mainScreen = "/main-screen";
  static const String myBookScreen = "/my-book-screen";
  static const String nextTestedScreen = "/next-tested-screen";
  static const String cartScreen = "/cart-screen";
  static const String searchScreen = "/search-screen";
}
