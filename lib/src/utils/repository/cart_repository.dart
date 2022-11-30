import 'package:it_project/src/local/dao/item_cart_dao.dart';
import 'package:it_project/src/utils/remote/model/cart/item_cart_request.dart';
import 'package:it_project/src/utils/remote/services/cart/cart_service.dart';
import 'package:it_project/src/utils/remote/services/fresult.dart';

abstract class CartRepository {
  CartRepository({required this.cartService});
  final CartService cartService;

  Future<FResult<String>> removeItem(ItemCart itemCart);
  Future<FResult<String>> updateItem(ItemCart itemCart);
  Future<FResult<List<ItemCartRequest>>> getAllItems();
  Future<FResult<String>> updateMultipleItems(List<ItemCart> itemCarts);
}
