import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:it_project/main.dart';
import 'package:it_project/src/features/login_register/cubit/parent_cubit.dart';
import 'package:it_project/src/features/shopping_cart/mixin/action_cart.dart';
import 'package:it_project/src/local/dao/item_cart.dart';
import 'package:it_project/src/utils/repository/product_repository.dart';
import 'package:it_project/src/utils/repository/product_repository_impl.dart';

part 'cart_state.dart';

// enum CartEnum { itemCarts, price, priceAfterSaleOff, itemQuantity }
enum CartEnum {
  itemCarts,
  price,
  priceAfterSaleOff,
}

enum CartActionEnum { inc, dec, removeItem }

class CartCubit extends Cubit<CartState>
    with ActionCart
    implements ParentCubit<CartEnum> {
  CartCubit()
      : super(const CartInitial(
          itemCarts: [],
          price: 0,
          priceAfterSaleOff: 0,
          // itemQuantity: 0,
        ));

  ProductRepository productRepository = getIt<ProductRepositoryImpl>();

  int _sumArray(List<dynamic> array) {
    dynamic sum = 0;
    for (var item in array) {
      sum += item;
    }

    return sum.toInt();
  }

  void _reloadPrice() {
    final itemCarts = cart.itemCarts;
    var price = _sumArray(itemCarts.map((e) => e.quantity * e.price).toList());
    var priceAfterSaleOff = _sumArray((itemCarts
            .map((e) => e.quantity * e.price * (100 - e.discountPercent) / 100))
        .toList());

    addNewEvent(CartEnum.price, price);
    addNewEvent(CartEnum.priceAfterSaleOff, priceAfterSaleOff);
  }

  loadLocal() {
    final itemCarts = cart.itemCarts;
    addNewEvent(CartEnum.itemCarts, itemCarts);
    _reloadPrice();
  }

  actionCart(CartActionEnum cartAction, {required String productSlug}) {
    switch (cartAction) {
      case CartActionEnum.inc:
        _plusQuantityItemCart(productSlug);

        break;
      case CartActionEnum.dec:
        _minusQuantityItemCart(productSlug);

        break;
      case CartActionEnum.removeItem:
        _removeItemCart(productSlug);
        break;
      default:
    }

    _reloadPrice();
  }

  _plusQuantityItemCart(String slug) {
    final itemCarts = [
      for (var item in state.itemCarts)
        if (item.slug == slug)
          item.copyWith(quantity: item.quantity + 1)
        else
          item
    ];

    addNewEvent(CartEnum.itemCarts, itemCarts);
    updateItemCartMixin(itemCarts);
  }

  _minusQuantityItemCart(String slug) {
    final itemCarts = [
      for (var item in state.itemCarts)
        if (item.slug == slug && item.quantity > 1)
          item.copyWith(quantity: item.quantity - 1)
        else
          item
    ];

    addNewEvent(CartEnum.itemCarts, itemCarts);
    updateItemCartMixin(itemCarts);
  }

  _removeItemCart(String slug) {
    final itemCarts = [
      for (var item in state.itemCarts)
        if (item.slug != slug) item
    ];
    addNewEvent(CartEnum.itemCarts, itemCarts);
    updateItemCartMixin(itemCarts);
  }

  @override
  void addNewEvent(CartEnum key, value) {
    if (isClosed) return;
    switch (key) {
      case CartEnum.itemCarts:
        emit(NewCartState.fromOldSettingState(state, itemCarts: value));
        break;
      case CartEnum.price:
        emit(NewCartState.fromOldSettingState(state, price: value));
        break;
      case CartEnum.priceAfterSaleOff:
        emit(NewCartState.fromOldSettingState(state, priceAfterSaleOff: value));
        break;
      // case CartEnum.itemQuantity:
      //   emit(NewCartState.fromOldSettingState(state, itemQuantity: value));
      //   break;
    }
  }
}
