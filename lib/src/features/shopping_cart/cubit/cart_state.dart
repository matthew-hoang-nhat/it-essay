part of 'cart_cubit.dart';

abstract class CartState extends Equatable {
  const CartState({
    required this.itemCarts,
  });

  final List<ItemCart> itemCarts;

  @override
  List<Object> get props => [itemCarts];
}

class CartInitial extends CartState {
  const CartInitial({
    required super.itemCarts,
  });
}

class NewCartState extends CartState {
  NewCartState.fromOldSettingState(
    CartState oldState, {
    List<ItemCart>? itemCarts,
  }) : super(
          itemCarts: itemCarts ?? oldState.itemCarts,
        );
}
