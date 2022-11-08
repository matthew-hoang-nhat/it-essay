// part 'environment_module.dart';

import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:it_project/main.dart';
import 'package:it_project/src/configs/routes/routers_app.dart';
import 'package:it_project/src/features/login_register/repositories/auth_repository_impl.dart';
import 'package:it_project/src/features/login_register/services/auth_service.dart';
import 'package:it_project/src/features/main/home_product/repositories/product_repository_impl.dart';
import 'package:it_project/src/features/main/home_product/services/product_service.dart';
import 'package:it_project/src/features/search/remote/search_service.dart';
import 'package:it_project/src/features/search/repositories/search_repository_impl.dart';

import 'package:it_project/src/utils/app_shared.dart';
import 'package:it_project/src/utils/services/dio_http_client.dart';
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
