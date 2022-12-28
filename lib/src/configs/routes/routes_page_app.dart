import 'package:go_router/go_router.dart';
import 'package:it_project/src/configs/routes/routes_name_app.dart';
import 'package:it_project/src/features/address/screens/add_address_screen.dart';
import 'package:it_project/src/features/address/screens/address_screen.dart';
import 'package:it_project/src/features/address/screens/detail_address_screen.dart';
import 'package:it_project/src/features/category/screens/category_screen.dart';
import 'package:it_project/src/features/category/screens/detail_category_screen.dart';
import 'package:it_project/src/features/login_register/screens/forgot_password_screen.dart';
import 'package:it_project/src/features/login_register/screens/login_screen.dart';
import 'package:it_project/src/features/login_register/screens/otp_check_screen.dart';
import 'package:it_project/src/features/login_register/screens/otp_check_screen_v2.dart';
import 'package:it_project/src/features/login_register/screens/register_screen.dart';
import 'package:it_project/src/features/login_register/screens/reset_password_screen.dart';

import 'package:it_project/src/features/main/main_screen.dart';
import 'package:it_project/src/features/order/screens/cart_to_order_screen.dart';
import 'package:it_project/src/features/order/screens/detail_order_screen.dart';
import 'package:it_project/src/features/order/screens/history_order_screen.dart';
import 'package:it_project/src/features/order/screens/payment_method_screen.dart';
import 'package:it_project/src/features/order/screens/success_payment_screen.dart';
import 'package:it_project/src/features/product/screens/product_screen.dart';
import 'package:it_project/src/features/profile/screens/change_password_screen.dart';
import 'package:it_project/src/features/profile/screens/detail_profile_screen.dart';
import 'package:it_project/src/features/search/screens/detail_search_screen.dart';
import 'package:it_project/src/features/search/screens/search_screen.dart';
import 'package:it_project/src/features/seller/screens/seller_products_category_screen.dart';
import 'package:it_project/src/features/seller/screens/seller_screen.dart';
import 'package:it_project/src/features/shopping_cart/cart_screen.dart';
import 'package:it_project/src/utils/remote/model/category/category.dart';
import 'package:it_project/src/utils/remote/model/order/get/address.dart';
import 'package:it_project/src/utils/remote/model/product/product.dart';
import 'package:it_project/src/utils/remote/model/seller/profile_seller.dart';

class AppPages {
  static const List<String> needAuthenticatedPages = [
    '${Paths.cartScreen}/${Paths.cartToOrderScreen}'
  ];

  static final pages = <GoRoute>[
    GoRoute(
        path: Paths.cartScreen,
        builder: (context, state) => const CartScreen(),
        routes: [
          GoRoute(
              path: Paths.cartToOrderScreen,
              builder: (context, state) => const CartToOrderScreen(),
              routes: [
                GoRoute(
                  path: Paths.paymentMethodScreen,
                  builder: (context, state) => const PaymentMethodScreen(),
                ),
              ]),
        ]),
    GoRoute(
        path: Paths.loginScreen,
        builder: (context, state) => const LoginScreen(),
        routes: [
          GoRoute(
            path: Paths.sRegisterScreen,
            builder: (context, state) => const RegisterScreen(),
          ),
          GoRoute(
            path: Paths.sOtpCheckScreen,
            builder: (context, state) => const OtpCheckScreen(),
          ),
          GoRoute(
              path: Paths.sForgotPasswordScreen,
              builder: (context, state) => const ForgotPasswordScreen(),
              routes: [
                GoRoute(
                    path: Paths.sOtpCheckScreenV2,
                    builder: (context, state) => const OTPCheckScreenV2(
                        // emailUser: state.extra as String,
                        ),
                    routes: [
                      GoRoute(
                        path: Paths.sResetPasswordScreen,
                        builder: (context, state) =>
                            const ResetPasswordScreen(),
                      )
                    ])
              ])
        ]),
    GoRoute(
        path: Paths.preSearchScreen,
        builder: (context, state) => const SearchScreen(),
        routes: [
          GoRoute(
              path: Paths.sDetailSearchScreen,
              builder: (context, state) => DetailSearchScreen(
                    extra: state.extra as Map<DetailSearchExtraEnum, dynamic>?,
                  )),
        ]),
    GoRoute(
      path: Paths.addressScreen,
      builder: (context, state) =>
          AddressScreen(isAllowChoose: state.extra as bool?),
    ),
    GoRoute(
      path: Paths.detailAddressScreen,
      builder: (context, state) => DetailAddressScreen(
        address: state.extra as Address,
      ),
    ),
    GoRoute(
      path: Paths.addAddressScreen,
      builder: (context, state) => const AddAddressScreen(),
    ),
    GoRoute(
      path: Paths.historyOrderScreen,
      builder: (context, state) => const HistoryOrderScreen(),
    ),
    GoRoute(
      path: Paths.detailOrderScreen,
      builder: (context, state) => DetailOrderScreen(
        orderId: state.extra as String,
      ),
    ),
    GoRoute(
      path: Paths.productScreen,
      builder: (context, state) => ProductScreen(
        product: state.extra as Product,
      ),
    ),
    GoRoute(
        path: Paths.mainScreen,
        builder: (context, state) => const MainScreen(),
        routes: [
          GoRoute(
            path: Paths.successPaymentScreen,
            builder: (context, state) => const SuccessPaymentScreen(),
          ),
          GoRoute(
            path: Paths.subHistoryOrderScreen,
            builder: (context, state) => const HistoryOrderScreen(),
          ),
          GoRoute(
            path: Paths.sChangePasswordScreen,
            builder: (context, state) => const ChangePasswordScreen(),
          ),
          // GoRoute(
          //   path: Paths.sPrivacyScreen,
          //   builder: (context, state) => const PrivacyScreen(),
          // ),
          // GoRoute(
          //   path: Paths.sAboutMeScreen,
          //   builder: (context, state) => const AboutMeScreen(),
          // ),
        ]),
    GoRoute(
        path: Paths.detailProfileScreen,
        builder: (context, state) => const DetailProfileScreen()),
    GoRoute(
        path: Paths.detailCategoryScreen,
        builder: (context, state) => DetailCategoryScreen(
              category: state.extra as Category,
            ),
        routes: [
          GoRoute(
              path: Paths.sDetailSearchScreen,
              builder: (context, state) => DetailSearchScreen(
                    extra: state.extra as Map<DetailSearchExtraEnum, dynamic>?,
                  )),
        ]),
    GoRoute(
        path: Paths.sellerScreen,
        builder: (context, state) =>
            SellerScreen(profileSeller: state.extra as ProfileSeller),
        routes: [
          GoRoute(
              path: Paths.sDetailSearchScreen,
              builder: (context, state) => DetailSearchScreen(
                    extra: state.extra as Map<DetailSearchExtraEnum, dynamic>?,
                  )),
        ]),
    GoRoute(
        path: Paths.sellerProductsOfCategoryScreen,
        builder: (context, state) => SellerProductsInCategoryScreen(
              sellerId: (state.extra as Map)['sellerId'] as String,
              category: (state.extra as Map)['category'] as Category,
            )),
    GoRoute(
        path: Paths.categoryScreen,
        builder: (context, state) => const CategoryScreen()),
  ];
}
