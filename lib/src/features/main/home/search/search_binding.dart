import 'package:get/get.dart';
import 'package:it_project/src/features/main/home/search/search_viewmodel.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SearchViewModel());
  }
}
