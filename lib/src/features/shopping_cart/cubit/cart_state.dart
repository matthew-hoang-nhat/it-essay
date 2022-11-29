part of 'cart_cubit.dart';

abstract class CartState extends Equatable {
  const CartState({
    required this.itemCarts,
    required this.price,
    required this.priceAfterSaleOff,
    required this.isLoading,
  });

  final List<ItemCart> itemCarts;
  final dynamic price;
  final dynamic priceAfterSaleOff;
  final bool isLoading;

  @override
  List<Object> get props => [
        itemCarts,
        price,
        priceAfterSaleOff,
        isLoading,
      ];
}

class CartInitial extends CartState {
  const CartInitial({
    required super.itemCarts,
    required super.price,
    required super.priceAfterSaleOff,
    required super.isLoading,
  });
}

class NewCartState extends CartState {
  NewCartState.fromOldSettingState(
    CartState oldState, {
    List<ItemCart>? itemCarts,
    dynamic price,
    dynamic priceAfterSaleOff,
    bool? isLoading,
    // int? itemQuantity,
  }) : super(
          itemCarts: itemCarts ?? oldState.itemCarts,
          price: price ?? oldState.price,
          priceAfterSaleOff: priceAfterSaleOff ?? oldState.priceAfterSaleOff,
          isLoading: isLoading ?? oldState.isLoading,
        );
}
