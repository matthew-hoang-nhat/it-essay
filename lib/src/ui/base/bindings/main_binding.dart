import 'package:get/get.dart';
import 'package:it_project/src/ui/book_store_screen/store_viewmodel.dart';
import 'package:it_project/src/ui/home_screen/home_viewmodel.dart';
import 'package:it_project/src/ui/main_viewmodel.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MainViewModel());
    Get.put(StoreViewModel());
    Get.put(HomeViewModel());
  }
}
