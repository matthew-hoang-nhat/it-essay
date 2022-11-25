// part 'environment_module.dart';

import 'dart:io';

import 'package:hive/hive.dart';
import 'package:it_project/main.dart';
import 'package:it_project/src/configs/constants/app_constants.dart';
import 'package:it_project/src/configs/routes/routers_app.dart';
import 'package:it_project/src/features/app/fcart_local.dart';
import 'package:it_project/src/features/app/fuser_local.dart';
import 'package:it_project/src/local/dao/fuser_local_dao.dart';

import 'package:it_project/src/local/dao/item_cart_dao.dart';
import 'package:it_project/src/utils/remote/services/auth_service/auth_service.dart';
import 'package:it_project/src/utils/remote/services/category/category_service.dart';
import 'package:it_project/src/utils/remote/services/dio_http_client.dart';
import 'package:it_project/src/utils/remote/services/product/product_service.dart';
import 'package:it_project/src/utils/remote/services/search/search_service.dart';
import 'package:it_project/src/utils/remote/services/seller/seller_service.dart';
import 'package:it_project/src/utils/remote/services/up_file/up_file_service.dart';
import 'package:it_project/src/utils/repository/auth_repository_impl.dart';
import 'package:it_project/src/utils/repository/category_repository_impl.dart';
import 'package:it_project/src/utils/repository/product_repository_impl.dart';
import 'package:it_project/src/utils/repository/profile_respository_impl.dart';
import 'package:it_project/src/utils/repository/search_repository_impl.dart';
import 'package:it_project/src/utils/repository/seller_repository_impl.dart';
import 'package:it_project/src/utils/repository/up_file_repository_impl.dart';

import 'package:path_provider/path_provider.dart';

part 'register_api_module.dart';
part 'register_core_module.dart';
part 'register_manager_module.dart';

part 'register_repositories_module.dart';

Future<void> setupDependenciesGraph() async {
  // Core Dependencies
  await _registerCoreModule();

  // API Services Dependencies
  _registerApiModule();

  // Repositories Dependencies
  await _registerRepositoriesModule();

  // // Managers Dependencies
  // _registerManagersModule();

  getIt.registerSingleton(const AppRouter());
}
