import 'package:it_project/main.dart';
import 'package:it_project/src/features/app/f_cart_local.dart';
import 'package:it_project/src/local/dao/item_cart_dao.dart';
import 'package:it_project/src/utils/remote/model/product/product.dart';
import 'package:it_project/src/utils/remote/model/product/product_picture.dart';
import 'package:it_project/src/utils/repository/cart_repository_impl.dart';

enum ActionCartTypeEnum { server, local }

mixin ActionCart {
  final cartLocal = getIt<FCartLocal>();
  final cartRepo = getIt<CartRepositoryImpl>();

  updateAnItemCartServer(ItemCart itemCart) async {
    await cartRepo.updateItem(itemCart);
  }

  removeItemCartServer(ItemCart itemCart) async {
    await cartRepo.removeItem(itemCart);
  }

  fetchItemCartsServerMixin() async {
    final itemsCartRequestResponse = await cartRepo.getAllItems();

    if (itemsCartRequestResponse.isSuccess) {
      cartLocal.itemCarts = itemsCartRequestResponse.data!.map((e) {
        final product = Product.fromJson(e.product);

        final firstImage =
            ProductPicture.fromJson(product.productImages).fileLink;

        return ItemCart(
            price: product.price!,
            id: product.id,
            name: product.name,
            quantity: e.quantity!,
            sellerName: product.seller!.info.name,
            discountPercent: product.discountPercent,
            mainCategory: product.category!.name,
            productImage: firstImage);
      }).toList();
    }
  }

  Future<void> updateItemCartsMixin(
      {required List<ItemCart> itemCarts,
      required ActionCartTypeEnum type}) async {
    switch (type) {
      case ActionCartTypeEnum.local:
        _updateItemCartsLocal(itemCarts);
        break;
      case ActionCartTypeEnum.server:
        await _updateItemsCartServer(itemCarts);
        break;
      default:
    }
  }

  _updateItemCartsLocal(List<ItemCart> itemCarts) {
    cartLocal.itemCarts = itemCarts;
  }

  _updateItemsCartServer(List<ItemCart> itemCarts) async {
    await cartRepo.updateMultipleItems(itemCarts);
  }

  Future<void> addItemToCartMixin(
      {required ItemCart itemCart, required ActionCartTypeEnum type}) async {
    switch (type) {
      case ActionCartTypeEnum.server:
        await _addItemToCartServer(itemCart);
        break;
      case ActionCartTypeEnum.local:
        _addItemToCartLocal(itemCart);
        break;
      default:
    }
  }

  _addItemToCartLocal(ItemCart itemCart) {
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

  _addItemToCartServer(ItemCart itemCart) async {
    await cartRepo.updateItem(itemCart);
  }
}
