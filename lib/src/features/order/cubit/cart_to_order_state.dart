part of 'cart_to_order_cubit.dart';

abstract class CartToOrderState extends Equatable {
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

class NewCartToOrderState extends CartToOrderState {
  NewCartToOrderState.fromOldSettingState(
    CartToOrderState oldState, {
    List<ItemCart>? itemCarts,
    bool? isLoading,
    String? addressId,
    String? shippingPrice,
    String? subTotalPrice,
    String? totalPrice,
    String? paymentMethod,
  }) : super(
          itemCarts: itemCarts ?? oldState.itemCarts,
          isLoading: isLoading ?? oldState.isLoading,
          shippingPrice: shippingPrice ?? oldState.shippingPrice,
          subTotalPrice: subTotalPrice ?? oldState.subTotalPrice,
          addressId: addressId ?? oldState.addressId,
          totalPrice: totalPrice ?? oldState.totalPrice,
          paymentMethod: paymentMethod ?? oldState.paymentMethod,
        );
}
