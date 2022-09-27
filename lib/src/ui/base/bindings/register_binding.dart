import 'package:get/get.dart';
import 'package:it_project/src/ui/login_and_register/register_viewmodel.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(RegisterViewModel());
  }
}
