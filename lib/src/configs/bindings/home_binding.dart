import 'package:get/get.dart';

import '../../features/main/home/home_viewmodel.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeViewModel());
  }
}
