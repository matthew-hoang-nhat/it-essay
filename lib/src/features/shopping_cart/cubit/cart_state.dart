part of 'cart_cubit.dart';

abstract class CartState extends Equatable {
  const CartState({
    required this.itemCarts,
    required this.price,
    required this.priceAfterSaleOff,
    // required this.itemQuantity,
  });

  final List<ItemCart> itemCarts;
  final dynamic price;
  final dynamic priceAfterSaleOff;
  // final int itemQuantity;

  @override
  List<Object> get props => [
        itemCarts,
        price,
        priceAfterSaleOff,
        // itemQuantity,
      ];
}

class CartInitial extends CartState {
  const CartInitial({
    required super.itemCarts,
    required super.price,
    required super.priceAfterSaleOff,
    // required super.itemQuantity,
  });
}

class NewCartState extends CartState {
  NewCartState.fromOldSettingState(
    CartState oldState, {
    List<ItemCart>? itemCarts,
    dynamic price,
    dynamic priceAfterSaleOff,
    // int? itemQuantity,
  }) : super(
          itemCarts: itemCarts ?? oldState.itemCarts,
          price: price ?? oldState.price,
          priceAfterSaleOff: priceAfterSaleOff ?? oldState.priceAfterSaleOff,
          // itemQuantity: itemQuantity ?? oldState.itemQuantity,
        );
}
