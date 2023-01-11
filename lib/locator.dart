import 'dart:async';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive/hive.dart';
import 'package:it_project/main.dart';
import 'package:it_project/src/configs/constants/app_constants.dart';
import 'package:it_project/src/configs/routes/routers_app.dart';
import 'package:it_project/src/features/app/fcart_local.dart';
import 'package:it_project/src/features/app/fuser_local.dart';
import 'package:it_project/src/local/dao/fuser_local_dao.dart';
import 'package:it_project/src/local/dao/item_cart_dao.dart';
import 'package:it_project/src/services/notification_manager.dart';
import 'package:it_project/src/services/socket_manager.dart';
import 'package:it_project/src/utils/remote/services/auth_service/auth_service.dart';
import 'package:it_project/src/utils/remote/services/cart/cart_service.dart';
import 'package:it_project/src/utils/remote/services/category/category_service.dart';
import 'package:it_project/src/utils/remote/services/delivery/delivery_service.dart';
import 'package:it_project/src/utils/remote/services/delivery/location_service.dart';
import 'package:it_project/src/utils/remote/services/dio_http_client.dart';
import 'package:it_project/src/utils/remote/services/notification/notification_service.dart';
import 'package:it_project/src/utils/remote/services/order/order_service.dart';
import 'package:it_project/src/utils/remote/services/product/product_service.dart';
import 'package:it_project/src/utils/remote/services/review/review_service.dart';
import 'package:it_project/src/utils/remote/services/search/search_service.dart';
import 'package:it_project/src/utils/remote/services/seller/seller_service.dart';

import 'package:it_project/src/utils/remote/services/up_file/up_file_service.dart';
import 'package:it_project/src/utils/repository/auth_repository_impl.dart';
import 'package:it_project/src/utils/repository/cart_repository_impl.dart';
import 'package:it_project/src/utils/repository/category_repository_impl.dart';
import 'package:it_project/src/utils/repository/delivery_repository_impl.dart';
import 'package:it_project/src/utils/repository/location_repository_impl.dart';
import 'package:it_project/src/utils/repository/notification_repository_impl.dart';
import 'package:it_project/src/utils/repository/order_repository_impl.dart';
import 'package:it_project/src/utils/repository/product_repository_impl.dart';
import 'package:it_project/src/utils/repository/profile_respository_impl.dart';
import 'package:it_project/src/utils/repository/review_repository_impl.dart';
import 'package:it_project/src/utils/repository/search_repository_impl.dart';
import 'package:it_project/src/utils/repository/seller_repository_impl.dart';

import 'package:it_project/src/utils/repository/up_file_repository_impl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

Future<void> initializeApp() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await setupDependenciesGraph();
}

Future<void> setupDependenciesGraph() async {
  await _registerCoreModule();
  _registerApiModule();
  await _registerRepositoriesModule();
  // _registerManagersModule();
  getIt.registerSingleton(const AppRouter());
}

Future<void> _registerCoreModule() async {
  await registerAppSharedAsync();

  // Network
  getIt.registerSingleton(
      DioHttpClient('https://main-server-v1.onrender.com/v1'));
  getIt.registerSingleton(
      DioHttpClient('https://external-server-v1.onrender.com'),
      instanceName: 'upFileServer');

  getIt.registerSingleton(DioHttpClient('https://provinces.open-api.vn/api'),
      instanceName: 'locationServer');
}

registerAppSharedAsync() async {
  final Directory directory = await getApplicationDocumentsDirectory();
  Hive
    ..init(directory.path)
    ..registerAdapter(ItemCartAdapter())
    ..registerAdapter(FUserLocalDaoAdapter());
  final Box box = await Hive.openBox(AppConstants.keyBox);

  getIt.registerSingleton<Box>(box);
  getIt.registerSingleton<FCartLocal>(FCartLocal());
  getIt.registerSingleton<FUserLocal>(FUserLocal());
  getIt.registerSingleton<NotificationManager>(NotificationManager());

  getIt.registerSingleton<SocketManager>(SocketManager());

  // getIt.registerSingleton<DeepLink>(DeepLink());
}

void _registerApiModule() {
  // API Server
  getIt.registerSingleton(AuthService(getIt<DioHttpClient>()));
  getIt.registerSingleton(CategoryService(getIt<DioHttpClient>()));
  getIt.registerSingleton(ProductService(getIt<DioHttpClient>()));
  getIt.registerSingleton(SearchService(getIt<DioHttpClient>()));
  getIt.registerSingleton(SellerService(getIt<DioHttpClient>()));
  getIt.registerSingleton(CartService(getIt<DioHttpClient>()));
  getIt.registerSingleton(DeliveryService(getIt<DioHttpClient>()));

  getIt.registerSingleton(OrderService(getIt<DioHttpClient>()));
  getIt.registerSingleton(
    LocationService(getIt<DioHttpClient>(instanceName: 'locationServer')),
  );
  getIt.registerSingleton(
      UpFileService(getIt<DioHttpClient>(instanceName: 'upFileServer')));
  getIt.registerSingleton(ReviewService(getIt<DioHttpClient>()));
  getIt.registerSingleton(NotificationService(getIt<DioHttpClient>()));
}

Future<void> _registerRepositoriesModule() async {
  getIt.registerSingleton(AuthRepositoryImpl(
    authService: getIt<AuthService>(),
  ));
  getIt.registerSingleton(ProductRepositoryImpl(
    productService: getIt<ProductService>(),
  ));
  getIt.registerSingleton(SearchRepositoryImpl(
    searchService: getIt<SearchService>(),
  ));
  getIt.registerSingleton(CategoryRepositoryImpl(
    categoryService: getIt<CategoryService>(),
  ));
  getIt.registerSingleton(CartRepositoryImpl(
    cartService: getIt<CartService>(),
  ));
  getIt.registerSingleton(DeliveryRepositoryImpl(
    deliveryService: getIt<DeliveryService>(),
  ));
  getIt.registerSingleton(LocationRepositoryImpl(
    locationService: getIt<LocationService>(),
  ));
  getIt.registerSingleton(OrderRepositoryImpl(
    orderService: getIt<OrderService>(),
  ));

  getIt.registerSingleton(
      ProfileRepositoryImpl(profileService: getIt<AuthService>()));
  getIt.registerSingleton(
      SellerRepositoryImpl(sellerService: getIt<SellerService>()));

  getIt.registerSingleton(
      UpFileRepositoryImpl(upFileService: getIt<UpFileService>()));
  getIt.registerSingleton(
      ReviewRepositoryImpl(reviewService: getIt<ReviewService>()));
  getIt.registerSingleton(
      NotificationRepositoryImpl(getIt<NotificationService>()));

  // getIt.registerSingleton<AppCubit>(AppCubit());
}
