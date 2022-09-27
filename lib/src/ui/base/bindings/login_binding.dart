import 'package:get/get.dart';
import 'package:it_project/src/ui/login_and_register/login_viewmodel.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginViewModel());
  }
}
