// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'cart_cubit.dart';

class CartState extends Equatable {
  const CartState({
    required this.itemCarts,
    required this.price,
    required this.priceAfterSaleOff,
    required this.isLoading,
    required this.itemCartsChecked,
  });

  final List<ItemCart> itemCarts;
  final List<String> itemCartsChecked;
  final dynamic price;
  final dynamic priceAfterSaleOff;
  final bool isLoading;

  @override
  List<Object> get props => [
        itemCarts,
        price,
        priceAfterSaleOff,
        isLoading,
        itemCartsChecked,
      ];

  CartState copyWith({
    List<ItemCart>? itemCarts,
    List<String>? itemCartsChecked,
    dynamic price,
    dynamic priceAfterSaleOff,
    bool? isLoading,
  }) {
    return CartState(
      itemCarts: itemCarts ?? this.itemCarts,
      itemCartsChecked: itemCartsChecked ?? this.itemCartsChecked,
      price: price ?? this.price,
      priceAfterSaleOff: priceAfterSaleOff ?? this.priceAfterSaleOff,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class CartInitial extends CartState {
  const CartInitial({
    required super.itemCarts,
    required super.itemCartsChecked,
    required super.price,
    required super.priceAfterSaleOff,
    required super.isLoading,
  });
}
