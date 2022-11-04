import 'package:get/get.dart';

import 'next_test_viewmodel.dart';

class NextTestedBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NextTestedViewModel());
  }
}
