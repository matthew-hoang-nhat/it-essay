import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/features/order/cubit/history_order_cubit.dart';
import 'package:it_project/src/utils/remote/model/order/get/order_response.dart';
import 'package:intl/intl.dart';
import 'package:it_project/src/utils/remote/model/product/product_picture.dart';

class InlineHistoryOrder extends StatelessWidget {
  final OrderResponse orderResponse;
  const InlineHistoryOrder({super.key, required this.orderResponse});

  @override
  Widget build(BuildContext context) {
    List<String> itemProductProductImages = orderResponse.items
        .map((e) =>
            ProductPicture.fromJson((e.product.productImages as List).first)
                .fileLink)
        .toList();

    itemProductProductImages = [
      for (var index = 0;
          (index < itemProductProductImages.length) && index < 3;
          index++)
        itemProductProductImages[index]
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 70,
          child: ListView(
              scrollDirection: Axis.horizontal,
              children: itemProductProductImages
                  .map((e) => imageComponent(e))
                  .toList()),
        ),
        const SizedBox(height: 20),
        infoOrder(),
      ],
    );
  }

  Widget infoOrder() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        componentStatusOrder(
            type: OrderEnum.toEnum(orderResponse.orderStatus.type)),
        describeOrder(),
      ],
    );
  }

  Widget describeOrder() {
    final NumberFormat formatCurrency;
    if (orderResponse.paymentType == 'cod') {
      formatCurrency = NumberFormat.simpleCurrency(locale: 'vi_VN');
    } else {
      formatCurrency = NumberFormat.simpleCurrency(locale: 'en_US');
    }
    final dateTime = DateTime.parse(orderResponse.orderStatus.date);
    String date = DateFormat('dd-MM-yyyy').format(dateTime);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('Số tiền: ',
                style: GoogleFonts.nunito(
                    color: AppColors.greyColor, fontWeight: FontWeight.bold)),
            Text('Ngày tạo đơn: ',
                style: GoogleFonts.nunito(
                    color: AppColors.greyColor, fontWeight: FontWeight.bold)),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(formatCurrency.format(orderResponse.totalAmount),
                style: GoogleFonts.nunito(fontWeight: FontWeight.bold)),
            Text(date, style: GoogleFonts.nunito(fontWeight: FontWeight.bold)),
            // Text(orderResponse.id,
            //     style: GoogleFonts.nunito(fontWeight: FontWeight.bold)),
          ],
        )
      ],
    );
  }

  Widget componentStatusOrder({required OrderEnum type}) {
    Widget passedStepWidget = Container(
      height: 20,
      width: 20,
      color: AppColors.whiteColor,
      child: Icon(
        MaterialCommunityIcons.check_circle,
        color: AppColors.greenColor,
        size: 16,
      ),
    );
    Widget nextStepWidget = Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: AppColors.whiteGreenColor),
      alignment: Alignment.center,
      child: Center(
        child: Icon(
          MaterialCommunityIcons.circle_medium,
          color: AppColors.greenColor,
          size: 16,
        ),
      ),
    );
    Widget nonSignStepWidget = SizedBox(
      height: 20,
      width: 20,
      child: Icon(
        // MaterialCommunityIcons.check_circle,
        MaterialCommunityIcons.circle_medium,
        color: AppColors.greyColor,
        size: 16,
      ),
    );

    final statusOrder = [
      'Chờ xét duyệt',
      'Đang đóng gói',
      'Đang giao hàng',
      'Đã nhận hàng'
    ];

    int numberProgressOrder = -1;
    switch (type) {
      case OrderEnum.ordered:
        numberProgressOrder = 1;
        break;
      case OrderEnum.packed:
        numberProgressOrder = 2;
        break;
      case OrderEnum.shipped:
        numberProgressOrder = 3;
        break;
      case OrderEnum.delivered:
        numberProgressOrder = 5;
        break;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 125,
              color: AppColors.greyColor,
              width: 2,
            ),
            Column(
              children: [
                ...List.generate(
                    numberProgressOrder - 1,
                    (index) => Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: passedStepWidget,
                        )),
                if (4 - numberProgressOrder > 0)
                  Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: nextStepWidget),
                if (4 - numberProgressOrder > 0)
                  ...List.generate(
                      4 - numberProgressOrder,
                      (index) => Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: nonSignStepWidget,
                          ))
              ],
            ),
          ],
        ),
        const SizedBox(width: 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...List.generate(statusOrder.length, (index) {
              final isLoadedProgress = index < numberProgressOrder;
              return Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(statusOrder.elementAt(index),
                    style: isLoadedProgress
                        ? GoogleFonts.nunito(
                            fontWeight: FontWeight.bold,
                            color: AppColors.greenColor)
                        : null),
              );
            }).toList(),
          ],
        ),
      ],
    );
  }

  Widget imageComponent(String url) {
    return Container(
      margin: const EdgeInsets.only(right: 20),
      constraints: const BoxConstraints(maxWidth: 150),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: CachedNetworkImage(
          imageUrl: url,
          height: 70,
          width: 70,
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}
