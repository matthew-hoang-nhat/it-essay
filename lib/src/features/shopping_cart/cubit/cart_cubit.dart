import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:it_project/main.dart';
import 'package:it_project/src/features/login_register/cubit/parent_cubit.dart';
import 'package:it_project/src/local/dao/item_cart.dart';
import 'package:it_project/src/utils/app_shared.dart';
import 'package:it_project/src/utils/repository/product_repository.dart';
import 'package:it_project/src/utils/repository/product_repository_impl.dart';

part 'cart_state.dart';

enum CartEnum { products }

class CartCubit extends Cubit<CartState> implements ParentCubit<CartEnum> {
  CartCubit()
      : super(const CartInitial(
          itemCards: [],
        ));

  ProductRepository productRepository = getIt<ProductRepositoryImpl>();

  final appShared = getIt<AppShared>();

  loadLocal() {
    appShared.setItemCardsValue([
      ItemCart(
          slug: '001',
          name: 'Nhat',
          quantity: 12,
          sellerName: 'Baby World hehe',
          discountPercent: 19,
          mainCategory: 'Sách thiếu nhi',
          productImage: '',
          price: 98000),
      ItemCart(
          slug: '002',
          name: 'Hoang',
          quantity: 1,
          sellerName: 'ABC shop',
          discountPercent: 5,
          mainCategory: 'Sách phát triển bản thân',
          productImage: '',
          price: 120000),
    ]);

    final itemCards = appShared.getItemCardsValue() ?? [];
    addNewEvent(CartEnum.products, itemCards);
  }

  @override
  void addNewEvent(CartEnum key, value) {
    if (isClosed) return;
    switch (key) {
      case CartEnum.products:
        emit(NewCartState.fromOldSettingState(state, itemCards: value));
        break;
    }
  }
}
