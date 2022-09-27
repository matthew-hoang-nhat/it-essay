import 'package:get/get.dart';
import 'package:it_project/src/ui/home_screen/home_viewmodel.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeViewModel());
  }
}
