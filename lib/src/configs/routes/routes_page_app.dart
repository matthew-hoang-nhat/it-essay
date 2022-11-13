import 'package:go_router/go_router.dart';
import 'package:it_project/src/configs/routes/routes_name_app.dart';
import 'package:it_project/src/features/category/screens/category_screen.dart';
import 'package:it_project/src/features/category/screens/detail_category_screen.dart';
import 'package:it_project/src/features/login_register/screens/login_screen.dart';
import 'package:it_project/src/features/main/home/home_screen.dart';

import 'package:it_project/src/features/main_screen.dart';
import 'package:it_project/src/features/product/screens/product_screen.dart';
import 'package:it_project/src/features/profile/screens/profile_screen.dart';
import 'package:it_project/src/features/search/screens/detail_search_screen.dart';
import 'package:it_project/src/features/search/screens/search_screen.dart';
import 'package:it_project/src/features/shopping_cart/cart_screen.dart';
import 'package:it_project/src/utils/remote/model/category/category.dart';
import 'package:it_project/src/utils/remote/model/product/product.dart';

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
      path: Paths.detailSearchScreen,
      builder: (context, state) => DetailSearchScreen(
        textSearch: state.extra as String,
      ),
      // builder: (context, state) => const DetailSearchScreen(),
    ),
    GoRoute(
      path: Paths.searchScreen,
      builder: (context, state) => const SearchScreen(),
    ),
    GoRoute(
      path: Paths.productScreen,
      builder: (context, state) =>
          ProductScreen(product: state.extra as Product),
    ),
    GoRoute(
        path: Paths.mainScreen,
        builder: (context, state) => const MainScreen()),
    GoRoute(
        path: Paths.profileScreen,
        builder: (context, state) => const ProfileScreen()),
    GoRoute(
        path: Paths.detailCategoryScreen,
        builder: (context, state) => DetailCategoryScreen(
              category: state.extra as Category,
            )),
    GoRoute(
        path: Paths.categoryScreen,
        builder: (context, state) => const CategoryScreen()),
    GoRoute(
        path: Paths.homeScreen,
        builder: (context, state) => const HomeScreen()),
  ];
}
