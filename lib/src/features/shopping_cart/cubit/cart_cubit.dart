import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:it_project/main.dart';
import 'package:it_project/src/features/login_register/cubit/parent_cubit.dart';
import 'package:it_project/src/local/dao/item_cart.dart';
import 'package:it_project/src/utils/app_shared.dart';
import 'package:it_project/src/utils/repository/product_repository.dart';
import 'package:it_project/src/utils/repository/product_repository_impl.dart';

part 'cart_state.dart';

enum CartEnum { itemCarts }

mixin ActionCart {
  AppShared appShared = getIt<AppShared>();

  void updateItemCartMixin(List<ItemCart> itemCarts) {
    appShared.setItemCardsValue(itemCarts);
  }

  void addItemCartMixin(ItemCart itemCart) {
    final oldItemCarts = appShared.getItemCardsValue();
    int indexNewItemCart =
        oldItemCarts.indexWhere((element) => element.slug == itemCart.slug);
    bool isHadItem = indexNewItemCart != -1;

    if (isHadItem) {
      final itemCarts = List<ItemCart>.from(oldItemCarts);
      final oldItemCart = itemCarts.elementAt(indexNewItemCart);
      final newItemCart =
          oldItemCart.copyWith(quantity: oldItemCart.quantity + 1);
      itemCarts[indexNewItemCart] = newItemCart;
      appShared.setItemCardsValue(itemCarts);
      return;
    }

    appShared.setItemCardsValue([...appShared.getItemCardsValue(), itemCart]);
  }
}

class CartCubit extends Cubit<CartState>
    with ActionCart
    implements ParentCubit<CartEnum> {
  CartCubit()
      : super(const CartInitial(
          itemCarts: [],
        ));

  ProductRepository productRepository = getIt<ProductRepositoryImpl>();

  loadLocal() {
    final tempList = appShared.getItemCardsValue();
    final itemCarts = tempList.map((e) => e as ItemCart).toList();
    addNewEvent(CartEnum.itemCarts, itemCarts);
  }

  plusQuantityItemCart(String slug) {
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

  minusQuantityItemCart(String slug) {
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

  addItemCart(ItemCart itemCart) {
    addItemCartMixin(itemCart);
    addNewEvent(CartEnum.itemCarts, appShared.getItemCardsValue());
  }

  removeItemCart(String slug) {
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
    }
  }
}
