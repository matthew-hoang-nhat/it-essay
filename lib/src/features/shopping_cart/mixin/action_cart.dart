import 'package:it_project/main.dart';
import 'package:it_project/src/features/app/fcart_local.dart';
import 'package:it_project/src/local/dao/item_cart_dao.dart';

mixin ActionCart {
  final cart = getIt<FCartLocal>();
  void updateItemCartMixin(List<ItemCart> itemCarts) {
    cart.itemCarts = itemCarts;
  }

  void addItemCartMixin(ItemCart itemCart) {
    final oldItemCarts = cart.itemCarts;
    int indexNewItemCart =
        oldItemCarts.indexWhere((element) => element.slug == itemCart.slug);
    bool isHadItem = indexNewItemCart != -1;

    if (isHadItem) {
      final itemCarts = List<ItemCart>.from(oldItemCarts);
      final oldItemCart = itemCarts.elementAt(indexNewItemCart);
      final newItemCart =
          oldItemCart.copyWith(quantity: oldItemCart.quantity + 1);
      itemCarts[indexNewItemCart] = newItemCart;
      cart.itemCarts = itemCarts;
      return;
    }

    cart.itemCarts = [...cart.itemCarts, itemCart];
  }
}
