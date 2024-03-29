import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:it_project/main.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/configs/routes/routes_name_app.dart';
import 'package:it_project/src/features/app/cubit/app_cubit.dart';
import 'package:it_project/src/local/dao/item_cart_dao.dart';
import 'package:it_project/src/utils/remote/model/order/add/add_order_request.dart';
import 'package:it_project/src/utils/remote/model/order/add/item_add_order_request.dart';
import 'package:it_project/src/utils/repository/delivery_repository.dart';
import 'package:it_project/src/utils/repository/delivery_repository_impl.dart';
import 'package:it_project/src/utils/repository/order_repository.dart';
import 'package:it_project/src/utils/repository/order_repository_impl.dart';

import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
part 'cart_to_order_state.dart';

enum CartToOrderEnum {
  paymentMethod,
  isLoading,
  itemCarts,
  totalPrice,
  shippingPrice,
  subTotalPrice,
  // paymentStatus,
  // orderStatus,
  // paymentId,
  // paymentUrl,
}

class CartToOrderCubit extends Cubit<CartToOrderState> {
  CartToOrderCubit()
      : super(const CartToOrderInitial(
          isLoading: false,
          addressId: null,
          paymentMethod: 'cod',
          shippingPrice: '',
          subTotalPrice: '',
          itemCarts: [],
          totalPrice: '',
        ));

  final formatCurrency = NumberFormat.simpleCurrency(locale: 'vi_VN');
  final DeliveryRepository deliveryRepository = getIt<DeliveryRepositoryImpl>();
  final OrderRepository orderRepository = getIt<OrderRepositoryImpl>();

  // initCubit({required List<ItemCart> itemCarts}) async {
  //   emit(CartToOrderInitial(
  //     isLoading: false,
  //     addressId: null,
  //     paymentMethod: 'cod',
  //     shippingPrice: '',
  //     subTotalPrice: '',
  //     itemCarts: itemCarts,
  //     totalPrice: '',
  //   ));
  //   getPrice();
  // }

  setPaymentMethod(String value) {
    emit(state.copyWith(paymentMethod: value));
  }

  getPrice() {
    num subTotalPrice = 0;
    for (var item in state.itemCarts) {
      subTotalPrice +=
          (item.price * (100 - item.discountPercent) / 100) * item.quantity;
    }
    num shippingPrice = 10000 * state.itemCarts.length;

    final subTotalPriceStr = formatCurrency.format(subTotalPrice);
    final shippingPriceStr = formatCurrency.format(shippingPrice);
    final totalPriceStr = formatCurrency.format(shippingPrice + subTotalPrice);

    emit(state.copyWith(
      subTotalPrice: subTotalPriceStr,
      shippingPrice: shippingPriceStr,
      totalPrice: totalPriceStr,
    ));
  }

  Future<void> paymentClick(context) async {
    final selectAddress = BlocProvider.of<AppCubit>(context).state.address;
    final bool isHadAddress = selectAddress != null;
    if (isHadAddress == false) {
      Fluttertoast.showToast(
          msg: 'Bạn chưa chọn địa chỉ',
          backgroundColor: AppColors.redColor,
          textColor: AppColors.whiteColor);
      return;
    }

    emit(state.copyWith(isLoading: true));

    final String addressId = selectAddress!.id!;
    final Map<String, dynamic> orderResult = await createOrder(addressId);

    final paymentMethod = state.paymentMethod;
    switch (paymentMethod) {
      case 'paypal':
        handlePaypal(context, orderResult['link'], orderResult['paymentId']);
        break;

      case 'cod':
        if (orderResult['orderStatus'] == true) {
          Fluttertoast.showToast(
              msg: 'Bạn đã đặt hàng thành công',
              backgroundColor: AppColors.primaryColor,
              textColor: AppColors.whiteColor);
          GoRouter.of(context)
              .go('${Paths.mainScreen}/${Paths.successPaymentScreen}');
        } else {
          Fluttertoast.showToast(
              msg: 'Lỗi hệ thống',
              backgroundColor: AppColors.redColor,
              textColor: AppColors.whiteColor);
        }
        break;
      default:
    }
    emit(state.copyWith(isLoading: false));
  }

  Future<Map<String, dynamic>> createOrder(String addressId) async {
    final result = await orderRepository.createOrder(
        addOrderRequest: AddOrderRequest(
            addressId: addressId,
            paymentType: state.paymentMethod,
            items: state.itemCarts
                .map((e) =>
                    ItemOrderRequest(productId: e.id, quantity: e.quantity))
                .toList()));

    if (result.isError == true) {
      return {'orderStatus': false};
    }
    final String paymentLink;
    final String paymentId;
    if (state.paymentMethod == 'paypal') {
      paymentLink = result.data!['link'];
      paymentId = result.data!['paymentId'];
      return {
        'orderStatus': true,
        'link': paymentLink,
        'paymentId': paymentId,
      };
    }

    return {'orderStatus': true};
  }

  Future<void> handlePaypal(context, link, paymentId) async {
    await launchUrl(Uri.parse(link));
    await Future.delayed(const Duration(milliseconds: 1000));
    while (
        WidgetsBinding.instance.lifecycleState != AppLifecycleState.resumed) {
      await Future.delayed(const Duration(milliseconds: 100));
    }
    final isCompletedPaymentByPaypal = await checkPayment(paymentId);

    if (isCompletedPaymentByPaypal) {
      Fluttertoast.showToast(
          msg: 'Đăng kí thành công', backgroundColor: AppColors.primaryColor);
      GoRouter.of(context)
          .go('${Paths.mainScreen}/${Paths.successPaymentScreen}');
    } else {
      Fluttertoast.showToast(
          msg: 'Thanh toán bằng Paypal chưa thành công',
          backgroundColor: AppColors.redColor);
    }
  }

  Future<bool> checkPayment(String paymentId) async {
    final result = await orderRepository.checkStatusOrder(paymentId: paymentId);
    final isCompleted = (result.data == 'completed');
    return isCompleted;
  }
}
