import 'package:get/get.dart';
import 'package:it_project/src/features/shopping_cart/cart_viewmodel.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CartViewModel());
  }
}
