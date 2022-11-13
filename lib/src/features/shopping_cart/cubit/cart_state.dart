part of 'cart_cubit.dart';

abstract class CartState extends Equatable {
  const CartState({required this.itemCards});

  final List<ItemCart> itemCards;

  @override
  List<Object?> get props => [itemCards];
}

class CartInitial extends CartState {
  const CartInitial({
    required super.itemCards,
  });
}

class NewCartState extends CartState {
  NewCartState.fromOldSettingState(
    CartState oldState, {
    List<ItemCart>? itemCards,
  }) : super(
          itemCards: itemCards ?? oldState.itemCards,
        );
}
