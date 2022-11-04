// part 'environment_module.dart';
import 'dart:io';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:it_project/src/utils/app_shared.dart';
import 'package:path_provider/path_provider.dart';

import '../configs/locates/translation_manager.dart';
import '../core/login_register/repositories/auth_repository.dart';
import '../utils/services/auth_service/auth_service.dart';
import '../utils/services/remote/dio_http_client.dart';
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
  _registerManagersModule();
}
