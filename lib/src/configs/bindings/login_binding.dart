import 'package:get/get.dart';
import 'package:it_project/src/core/login_register/screens/register_viewmodel.dart';

import '../../core/login_register/screens/login_viewmodel.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginViewModel());
    Get.put(RegisterViewModel());
  }
}
