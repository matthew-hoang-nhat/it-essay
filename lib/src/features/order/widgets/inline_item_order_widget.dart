// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/features/order/cubit/detail_order_cubit.dart';
import 'package:it_project/src/features/order/cubit/history_order_cubit.dart';
import 'package:it_project/src/utils/remote/model/order/get/item_order.dart';
import 'package:it_project/src/utils/remote/model/order/get/order_status.dart';

class InlineItemOrderWidget extends StatelessWidget {
  const InlineItemOrderWidget({
    Key? key,
    required this.productOrder,
    required this.isInDetailOrder,
  }) : super(key: key);
  final ItemOrder productOrder;
  final bool isInDetailOrder;
  @override
  Widget build(BuildContext context) {
    final array = productOrder.product.productImages as List;
    final imageUrl = array.first['fileLink'];
    final bool isDiscount =
        productOrder.discount != null && productOrder.discount != 0;
    final NumberFormat formatCurrency;
    if (productOrder.paymentType == 'paypal') {
      formatCurrency = NumberFormat.simpleCurrency(locale: 'en_US');
    } else {
      formatCurrency = NumberFormat.simpleCurrency(locale: 'vi_VN');
    }
    final price = formatCurrency.format(productOrder.price);
    final priceAfterDiscount = formatCurrency
        .format(productOrder.price! * (100 - productOrder.discount!) / 100);
    final priceAfterTotal = formatCurrency.format(productOrder.totalPaid);
    final isCancel = productOrder.isCancel;

    final orderStatus =
        OrderStatus.fromJson((productOrder.orderStatus as List).last);

    final orderStatusEnum = OrderEnum.toEnum(orderStatus.type);

    final orderStatusStr =
        getNameStatusOrder(orderStatusEnum, orderStatus.isCompleted);

    final String itemOrderId = productOrder.id!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            const Icon(MaterialCommunityIcons.store_outline),
            Text(
              'BabyWorldShop',
              style: GoogleFonts.nunito(fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            isCancel == true
                ? Text('???? h???y',
                    style: GoogleFonts.nunito(color: AppColors.redColor))
                : Text(orderStatusStr),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration:
                  BoxDecoration(border: Border.all(color: AppColors.greyColor)),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                height: 70,
                width: 70,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    productOrder.product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.nunito(fontWeight: FontWeight.bold),
                  ),
                  Text('x${productOrder.quantity}'),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (isDiscount)
                        Row(children: [
                          Text(
                            price,
                            style: GoogleFonts.nunito(
                                color: AppColors.greyColor,
                                decoration: TextDecoration.lineThrough),
                          ),
                        ]),
                      const SizedBox(width: 10),
                      Text(
                        priceAfterDiscount,
                        style: GoogleFonts.nunito(color: AppColors.redColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(width: 200, child: Divider()),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(' ${productOrder.quantity} s???n ph???m'),
            Row(
              children: [
                const Text('Th??nh ti???n: '),
                Text(
                  priceAfterTotal,
                  style: GoogleFonts.nunito(color: AppColors.redColor),
                ),
              ],
            )
          ],
        ),
        const SizedBox(height: 20),
        if (isInDetailOrder)
          cancelButton(
            context,
            orderStatusEnum,
            productOrder.isCancel,
            itemOrderId,
          ),
      ],
    );
  }

  Widget cancelButton(
      context, OrderEnum orderStatus, bool? isCancel, String itemOrderId) {
    // if (isCancel != true) return Container();
    if (orderStatus != OrderEnum.ordered) return Container();
    if (isCancel == true) return Container();
    return BlocBuilder<DetailOrderCubit, DetailOrderState>(
      builder: (cubitState, state) {
        return Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('H???y s???n ph???m'),
                      content: Text(
                          'S???n ph???m ${productOrder.product.name} s??? b??? x??a kh???i ????n h??ng, v?? b???n kh??ng th??? ho??n t??c l???i?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Kh??ng'),
                          child: const Text('Kh??ng'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, 'C??');
                            cubitState
                                .read<DetailOrderCubit>()
                                .cancelAnItemOrder(itemOrderId)
                                .then((value) {
                              cubitState.read<HistoryOrderCubit>()
                                ..refreshTab(HistoryOrderTabEnum.ordered)
                                ..refreshTab(HistoryOrderTabEnum.cancel);
                            });
                          },
                          child: Text(
                            'X??a',
                            style:
                                GoogleFonts.nunito(color: AppColors.redColor),
                          ),
                        ),
                      ],
                    );
                  });
            },
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                        side: const BorderSide(color: Colors.red)))),
            child: Text(
              'H???y s???n ph???m',
              style: GoogleFonts.nunito(
                fontSize: 16,
                color: AppColors.redColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }

  String getNameStatusOrder(OrderEnum type, bool isCompleted) {
    final statusOrder = [
      'Ch??? x??t duy???t',
      '??ang ????ng g??i',
      '??ang giao h??ng',
      '???? nh???n h??ng'
    ];

    switch (type) {
      case OrderEnum.ordered:
        return statusOrder[0];
      case OrderEnum.packed:
        return statusOrder[1];
      case OrderEnum.shipped:
        return statusOrder[2];
      case OrderEnum.delivered:
        return isCompleted == true ? statusOrder[3] : statusOrder[2];
    }
  }
}
