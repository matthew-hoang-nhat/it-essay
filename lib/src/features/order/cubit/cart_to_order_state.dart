// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'cart_to_order_cubit.dart';

class CartToOrderState extends Equatable {
  const CartToOrderState({
    required this.itemCarts,
    required this.isLoading,
    required this.addressId,
    required this.paymentMethod,
    required this.totalPrice,
    required this.shippingPrice,
    required this.subTotalPrice,
  });

  final List<ItemCart> itemCarts;
  final bool isLoading;
  final String paymentMethod;
  final String totalPrice;
  final String shippingPrice;
  final String subTotalPrice;

  final String? addressId;

  @override
  List<Object?> get props => [
        itemCarts,
        isLoading,
        addressId,
        totalPrice,
        paymentMethod,
        shippingPrice,
        subTotalPrice,
      ];

  CartToOrderState copyWith({
    List<ItemCart>? itemCarts,
    bool? isLoading,
    String? paymentMethod,
    String? totalPrice,
    String? shippingPrice,
    String? subTotalPrice,
    String? addressId,
  }) {
    return CartToOrderState(
      itemCarts: itemCarts ?? this.itemCarts,
      isLoading: isLoading ?? this.isLoading,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      totalPrice: totalPrice ?? this.totalPrice,
      shippingPrice: shippingPrice ?? this.shippingPrice,
      subTotalPrice: subTotalPrice ?? this.subTotalPrice,
      addressId: addressId ?? this.addressId,
    );
  }
}

class CartToOrderInitial extends CartToOrderState {
  const CartToOrderInitial({
    required super.itemCarts,
    required super.isLoading,
    required super.shippingPrice,
    required super.subTotalPrice,
    required super.addressId,
    required super.totalPrice,
    required super.paymentMethod,
  });
}
