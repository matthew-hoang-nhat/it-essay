import 'package:get/get.dart';

import '../../core/login_register/screens/register_viewmodel.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(RegisterViewModel());
  }
}
