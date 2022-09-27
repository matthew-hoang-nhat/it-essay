import 'package:get/get.dart';
import 'package:it_project/src/ui/my_book/my_book_viewmodel.dart';

class MyBookBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MyBookViewModel());
  }
}
