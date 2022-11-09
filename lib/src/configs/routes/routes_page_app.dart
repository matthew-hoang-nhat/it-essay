import 'package:go_router/go_router.dart';
import 'package:it_project/src/configs/routes/routes_name_app.dart';
import 'package:it_project/src/features/login_register/screens/login_screen.dart';
import 'package:it_project/src/features/main/home/home_screen.dart';

import 'package:it_project/src/features/main_screen.dart';
import 'package:it_project/src/features/product/screens/product_screen.dart';
import 'package:it_project/src/features/shopping_cart/cart_screen.dart';

class AppPages {
  static const List<String> needAuthenticatedPages = [
    Paths.cartScreen,
  ];

  static final pages = <GoRoute>[
    GoRoute(
      path: Paths.cartScreen,
      builder: (context, state) => const CartScreen(),
    ),
    GoRoute(
      path: Paths.loginScreen,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: Paths.homeScreen,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: Paths.productScreen,
      builder: (context, state) => const ProductScreen(),
    ),
    // GoRoute(
    //   path: Paths.otpScreen,
    //   builder: (context, state) =>
    //       OtpCheckScreen(userId: state.extra as String, emailUser: '',),
    // ),
    GoRoute(
        path: Paths.mainScreen,
        builder: (context, state) => const MainScreen()),
  ];
}
