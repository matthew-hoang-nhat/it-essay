import 'package:get/get.dart';

import '../../core/login_register/screens/otp_check_viewmodel.dart';

class OtpCheckBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(OtpCheckViewModel());
  }
}
