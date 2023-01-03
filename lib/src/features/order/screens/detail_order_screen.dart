import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/configs/routes/routes_name_app.dart';
import 'package:it_project/src/features/order/cubit/detail_order_cubit.dart';
import 'package:it_project/src/features/order/widgets/inline_item_order_widget.dart';
import 'package:it_project/src/utils/remote/model/order/get/item_order.dart';
import 'package:it_project/src/utils/remote/model/order/get/order_response.dart';
import 'package:it_project/src/widgets/load_widget.dart';

import '../widgets/inline_history_order_response_widget.dart';
import 'package:intl/intl.dart';

class DetailOrderScreen extends StatelessWidget {
  const DetailOrderScreen({super.key, required this.orderId});
  final String orderId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => DetailOrderCubit(orderId: orderId)..initCubit(),
        child: Scaffold(
          appBar: AppBar(title: const Text('Thông tin đơn hàng')),
          backgroundColor: AppColors.whiteGreyColor,
          body: Stack(
            children: [
              SafeArea(child: BlocBuilder<DetailOrderCubit, DetailOrderState>(
                builder: (context, state) {
                  if (state.orderResponse == null) return Container();
                  final OrderResponse orderResponse = state.orderResponse!;

                  final NumberFormat formatCurrency;
                  if (orderResponse.paymentType == 'cod') {
                    formatCurrency =
                        NumberFormat.simpleCurrency(locale: 'vi_VN');
                  } else {
                    formatCurrency =
                        NumberFormat.simpleCurrency(locale: 'en_US');
                  }

                  final subTotalPrice = formatCurrency.format(
                      (orderResponse.totalAmount ?? 0) -
                          (orderResponse.shippingCost ?? 0));
                  final shippingPrice =
                      formatCurrency.format(orderResponse.shippingCost ?? 0);
                  final discountPrice = formatCurrency.format(0);
                  final totalPrice =
                      formatCurrency.format(orderResponse.totalAmount);
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            padding: const EdgeInsets.only(top: 20, left: 20),
                            width: double.infinity,
                            color: AppColors.whiteColor,
                            child: Row(
                              children: [
                                const Text('Mã đơn hàng: '),
                                Text(state.orderId),
                              ],
                            )),
                        componentOverviewOrder(context, state, subTotalPrice,
                            shippingPrice, discountPrice, totalPrice),
                        // const SizedBox(height: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              color: AppColors.whiteColor,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Sản phẩm đã đặt'.toUpperCase(),
                                    style: GoogleFonts.nunito(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: AppColors.greyColor),
                                  ),
                                  Text(
                                      '${orderResponse.items.length} mặt hàng'),
                                ],
                              ),
                            ),
                            Column(
                                children:
                                    orderResponse.items.map((ItemOrder e) {
                              return Container(
                                color: AppColors.whiteColor,
                                padding: const EdgeInsets.only(
                                    bottom: 30, left: 20, right: 20, top: 20),
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        context.push(
                                            '${Paths.productScreen}/${e.product.slug}');
                                      },
                                      child: InlineItemOrderWidget(
                                        productOrder: e,
                                        isInDetailOrder: true,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList())
                          ],
                        )
                      ],
                    ),
                  );
                },
              )),
              BlocBuilder<DetailOrderCubit, DetailOrderState>(
                buildWhen: (previous, current) =>
                    previous.isLoading != current.isLoading,
                builder: (context, state) {
                  if (state.isLoading) {
                    return const LoadingWidget(
                      isBlurScreen: true,
                    );
                  }
                  return Container();
                },
              )
            ],
          ),
        ));
  }

  // Widget actionButton(context, OrderEnum orderStatus, bool isCancel) {
  //   if (orderStatus != OrderEnum.ordered) return Container();
  //   if (isCancel != false) return Container();

  //   return Align(
  //     alignment: Alignment.centerRight,
  //     child: ElevatedButton(
  //       onPressed: () {
  //         showDialog(
  //             context: context,
  //             builder: (context) {
  //               return AlertDialog(
  //                 title: const Text('Xóa sản phẩm'),
  //                 content: const Text(
  //                     'Việc xóa sản phẩm ra khỏi đơn hàng không thể hoàn tác lại.'),
  //                 actions: <Widget>[
  //                   TextButton(
  //                     onPressed: () => Navigator.pop(context, 'Không'),
  //                     child: const Text('Không'),
  //                   ),
  //                   TextButton(
  //                     onPressed: () => Navigator.pop(context, 'Có'),
  //                     child: Text(
  //                       'Xóa',
  //                       style: GoogleFonts.nunito(color: AppColors.redColor),
  //                     ),
  //                   ),
  //                 ],
  //               );
  //             });
  //       },
  //       style: ButtonStyle(
  //           foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
  //           backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
  //           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
  //               RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(100),
  //                   side: const BorderSide(color: Colors.red)))),
  //       child: Text(
  //         'Hủy đơn',
  //         style: GoogleFonts.nunito(
  //           fontSize: 16,
  //           color: AppColors.whiteColor,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget componentOverviewOrder(
      context,
      DetailOrderState state,
      String subTotalPrice,
      String shippingPrice,
      String discountPrice,
      String totalPrice) {
    final orderResponse = state.orderResponse!;
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      color: AppColors.whiteColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          InlineHistoryOrder(orderResponse: orderResponse),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Địa chỉ gửi đến'.toUpperCase(),
                  style: GoogleFonts.nunito(
                      color: AppColors.greyColor, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text(orderResponse.address?.name ?? '',
                  style: GoogleFonts.nunito(
                      fontWeight: FontWeight.bold, fontSize: 16)),
              Text(orderResponse.address?.address ?? '',
                  style: GoogleFonts.nunito(
                    color: AppColors.greyColor,
                    fontWeight: FontWeight.bold,
                  ))
            ],
          ),
          const SizedBox(height: 20),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Phương thức thanh toán',
                    style: GoogleFonts.nunito(color: AppColors.greyColor),
                  ),
                  Text(orderResponse.paymentType ?? 'cod'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tổng tiền hàng',
                    style: GoogleFonts.nunito(color: AppColors.greyColor),
                  ),
                  Text(subTotalPrice),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Chi phí vận chuyển',
                    style: GoogleFonts.nunito(color: AppColors.greyColor),
                  ),
                  Text(shippingPrice),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Giảm giá',
                    style: GoogleFonts.nunito(color: AppColors.greyColor),
                  ),
                  Text('-$discountPrice'),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: AppColors.whiteGreyColor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tổng giá',
                      style: GoogleFonts.nunito(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      totalPrice,
                      style: GoogleFonts.nunito(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
