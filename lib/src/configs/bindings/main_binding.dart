import 'package:get/get.dart';
import 'package:it_project/src/features/main/home/search/search_viewmodel.dart';

import '../../features/book_store_screen/store_viewmodel.dart';
import '../../features/main/home/home_viewmodel.dart';
import '../../features/main_viewmodel.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MainViewModel());
    Get.put(SearchViewModel());
    Get.put(StoreViewModel());
    Get.put(HomeViewModel());
  }
}
