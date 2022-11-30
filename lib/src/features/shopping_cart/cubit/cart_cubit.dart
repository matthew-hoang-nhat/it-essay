import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:it_project/main.dart';
import 'package:it_project/src/features/login_register/cubit/parent_cubit.dart';
import 'package:it_project/src/features/shopping_cart/mixin/action_cart.dart';
import 'package:it_project/src/local/dao/item_cart_dao.dart';
import 'package:it_project/src/utils/repository/product_repository.dart';
import 'package:it_project/src/utils/repository/product_repository_impl.dart';

part 'cart_state.dart';

// enum CartEnum { itemCarts, price, priceAfterSaleOff, itemQuantity }
enum CartEnum {
  itemCarts,
  price,
  priceAfterSaleOff,
  isLoading,
  itemCartsChecked
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
            isLoading: false,
            itemCartsChecked: []));

  ProductRepository productRepository = getIt<ProductRepositoryImpl>();

  int _sumArray(List<dynamic> array) {
    dynamic sum = 0;
    for (var item in array) {
      sum += item;
    }

    return sum.toInt();
  }

  void _reloadPrice() {
    final itemCarts = cartLocal.itemCarts;
    var price = _sumArray(itemCarts
        .map((e) =>
            state.itemCartsChecked.contains(e.id) ? e.quantity * e.price : 0)
        .toList());
    var priceAfterSaleOff = _sumArray((itemCarts.map((e) =>
        state.itemCartsChecked.contains(e.id)
            ? e.quantity * e.price * (100 - e.discountPercent) / 100
            : 0)).toList());

    addNewEvent(CartEnum.price, price);
    addNewEvent(CartEnum.priceAfterSaleOff, priceAfterSaleOff);
  }

  _getItemCartLocal() {
    final itemCarts = cartLocal.itemCarts;
    addNewEvent(CartEnum.itemCarts, itemCarts);
    _reloadPrice();
  }

  _getItemCartServer() async {
    await fetchItemCartsServerMixin();
    final itemCarts = cartLocal.itemCarts;
    addNewEvent(CartEnum.itemCarts, itemCarts);
    _reloadPrice();
  }

  initCubit() async {
    addNewEvent(CartEnum.isLoading, true);
    _getItemCartLocal();
    await _getItemCartServer();
    addNewEvent(CartEnum.isLoading, false);
  }

  actionCart(CartActionEnum cartAction, {required String id}) {
    switch (cartAction) {
      case CartActionEnum.inc:
        _plusQuantityItemCart(id);
        updateAnItemCartServer(
            cartLocal.itemCarts.firstWhere((element) => element.id == id));

        break;
      case CartActionEnum.dec:
        _minusQuantityItemCart(id);
        updateAnItemCartServer(
            cartLocal.itemCarts.firstWhere((element) => element.id == id));

        break;
      case CartActionEnum.removeItem:
        removeItemCartServer(
            cartLocal.itemCarts.firstWhere((element) => element.id == id));
        _removeItemCart(id);
        break;
      default:
    }

    _reloadPrice();
  }

  _plusQuantityItemCart(String id) {
    final itemCarts = [
      for (var item in state.itemCarts)
        if (item.id == id) item.copyWith(quantity: item.quantity + 1) else item
    ];

    addNewEvent(CartEnum.itemCarts, itemCarts);
    updateItemCartsMixin(itemCarts: itemCarts, type: ActionCartTypeEnum.local);
  }

  _minusQuantityItemCart(String id) {
    final itemCarts = [
      for (var item in state.itemCarts)
        if (item.id == id && item.quantity > 1)
          item.copyWith(quantity: item.quantity - 1)
        else
          item
    ];

    addNewEvent(CartEnum.itemCarts, itemCarts);
    updateItemCartsMixin(itemCarts: itemCarts, type: ActionCartTypeEnum.local);
  }

  _removeItemCart(String id) {
    final itemCarts = [
      for (var item in state.itemCarts)
        if (item.id != id) item
    ];
    addNewEvent(CartEnum.itemCarts, itemCarts);
    updateItemCartsMixin(itemCarts: itemCarts, type: ActionCartTypeEnum.local);
  }

  checkItemCart(String id) {
    final itemCartsChecked = state.itemCartsChecked;
    List<String> newItemCartsChecked = List.from(itemCartsChecked);

    final isContainedItemCartChecked = itemCartsChecked.contains(id);
    switch (isContainedItemCartChecked) {
      case true:
        newItemCartsChecked.remove(id);
        break;

      case false:
        newItemCartsChecked.add(id);
        break;
    }

    addNewEvent(CartEnum.itemCartsChecked, newItemCartsChecked);
    _reloadPrice();

    // if (itemCartsChecked.contains(id)) {
    //   newItemCartsChecked.remove(id);
    //   addNewEvent(CartEnum.itemCartsChecked, newItemCartsChecked);
    //   print('xóa nha');
    //   _reloadPrice();
    //   return;
    // }

    // print('thêm vào');
    // newItemCartsChecked.add(id);
    // addNewEvent(CartEnum.itemCartsChecked, newItemCartsChecked);

    // _reloadPrice();
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
      case CartEnum.isLoading:
        emit(NewCartState.fromOldSettingState(state, isLoading: value));
        break;
      case CartEnum.itemCartsChecked:
        emit(NewCartState.fromOldSettingState(state, itemCartsChecked: value));
        break;
      // case CartEnum.itemQuantity:
      //   emit(NewCartState.fromOldSettingState(state, itemQuantity: value));
      //   break;
    }
  }
}
