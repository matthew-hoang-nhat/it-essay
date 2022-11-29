import 'package:it_project/main.dart';
import 'package:it_project/src/features/app/fcart_local.dart';
import 'package:it_project/src/local/dao/item_cart_dao.dart';
import 'package:it_project/src/utils/remote/model/product/product_picture.dart';
import 'package:it_project/src/utils/repository/cart_repository_impl.dart';

mixin ActionCart {
  final cartLocal = getIt<FCartLocal>();
  final cartRepo = getIt<CartRepositoryImpl>();
  void updateItemCartsLocal(List<ItemCart> itemCarts) {
    cartLocal.itemCarts = itemCarts;
  }

  Future<bool> updateItemCartServer(ItemCart itemCart) async {
    final result = await cartRepo.updateItem(itemCart);
    return result.isSuccess;
  }

  Future<bool> updateItemsCartServerMixin(List<ItemCart> itemCarts) async {
    final result = await cartRepo.updateMultipleItems(itemCarts);
    return result.isSuccess;
  }

  Future<bool> removeItemCartServer(ItemCart itemCart) async {
    final result = await cartRepo.removeItem(itemCart);
    return result.isSuccess;
  }

  fetchItemCartsServerMixin() async {
    final itemsCartRequestResponse = await cartRepo.getAllItems();

    if (itemsCartRequestResponse.isSuccess) {
      cartLocal.itemCarts = itemsCartRequestResponse.data!.map((e) {
        final product = e.product;
        final firstImage =
            ProductPicture.fromJson(product.productImages).fileLink;
        return ItemCart(
            price: product.price,
            id: product.id,
            name: product.name,
            quantity: e.quantity!,
            // sellerName: e.seller!.info.name,
            sellerName: 'hoangtrungnhat',
            discountPercent: product.discountPercent,
            mainCategory: product.category.name,
            productImage: firstImage);
      }).toList();
    }
  }

  addItemToCartLocal(ItemCart itemCart) {
    final oldItemCarts = cartLocal.itemCarts;
    int indexNewItemCart =
        oldItemCarts.indexWhere((element) => element.id == itemCart.id);
    bool isHadItem = indexNewItemCart != -1;

    if (isHadItem) {
      final itemCarts = List<ItemCart>.from(oldItemCarts);
      final oldItemCart = itemCarts.elementAt(indexNewItemCart);
      final newItemCart =
          oldItemCart.copyWith(quantity: oldItemCart.quantity + 1);
      itemCarts[indexNewItemCart] = newItemCart;
      cartLocal.itemCarts = itemCarts;
      return;
    }

    cartLocal.itemCarts = [...cartLocal.itemCarts, itemCart];
  }

  addItemToCartServer(ItemCart itemCart) async {
    await cartRepo.updateItem(itemCart);
  }
}
