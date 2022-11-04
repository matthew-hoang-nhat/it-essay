import 'package:get/get.dart';

import '../../features/my_book/my_book_viewmodel.dart';

class MyBookBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MyBookViewModel());
  }
}
