import 'package:it_project/main.dart';
import 'package:it_project/src/features/app/fuser_local.dart';
import 'package:it_project/src/utils/remote/model/cart/add_item_cart_request.dart';
import 'package:it_project/src/utils/remote/model/cart/item_cart_request.dart';
import 'package:it_project/src/utils/remote/services/fresult.dart';
import 'package:it_project/src/local/dao/item_cart_dao.dart';
import 'package:it_project/src/utils/repository/cart_repository.dart';

class CartRepositoryImpl extends CartRepository {
  CartRepositoryImpl({required super.cartService});

  @override
  Future<FResult<String>> updateMultipleItems(List<ItemCart> itemCarts) async {
    try {
      await cartService.addMultiItemsInCart(AddItemCartRequest(
          userId: getIt<FUserLocal>().userId!,
          cartItems: itemCarts
              .map((e) => ItemCartRequest(
                    product: e.id,
                    quantity: e.quantity,
                  ))
              .toList()));

      return FResult.success('Thêm sản phẩm vào giỏ hàng thành công');
    } catch (ex) {
      return FResult.error('Xóa thất bại');
    }
  }

  @override
  Future<FResult<List<ItemCartRequest>>> getAllItems() async {
    try {
      final response = await cartService.getItemsInCart();
      final items = response.data['cartItems'] as List;

      return FResult.success(
          items.map((e) => ItemCartRequest.fromJson(e)).toList());
    } catch (ex) {
      return FResult.error('Xóa thất bại');
    }
  }

  @override
  Future<FResult<String>> removeItem(ItemCart itemCart) async {
    try {
      await cartService.removeItemInCart(AddItemCartRequest(
        userId: '',
        cartItem: ItemCartRequest(product: itemCart.id),
      ));
      return FResult.success('Xóa thành công');
    } catch (ex) {
      return FResult.error(ex.toString());
    }
  }

  @override
  Future<FResult<String>> updateItem(ItemCart itemCart) async {
    try {
      await cartService.addItemInCart(AddItemCartRequest(
          userId: getIt<FUserLocal>().userId!,
          cartItem: ItemCartRequest(
            product: itemCart.id,
            quantity: itemCart.quantity,
          )));

      return FResult.success('Thêm sản phẩm vào giỏ hàng thành công');
    } catch (ex) {
      return FResult.error('Xóa thất bại');
    }
  }
}
