import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:it_project/src/local/dao/item_cart.dart';
import 'package:it_project/src/widgets/icon_heart.dart';

import '../../../configs/constants/app_assets.dart';
import '../../../configs/constants/app_colors.dart';
import '../../../configs/constants/app_dimensions.dart';

// ignore: must_be_immutable

class ItemCartWidget extends StatelessWidget {
  const ItemCartWidget({super.key, required this.product});
  final ItemCart product;

  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.simpleCurrency(locale: 'vi_VN');
    return Column(
      children: [
        const SizedBox(height: 20),
        Stack(
          alignment: Alignment.topRight,
          children: [
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppDimensions.dp5),
                child: Image.asset(
                  AppAssets.fkImHarryPotter1,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.nunito(
                            fontWeight: FontWeight.bold,
                            fontSize: AppDimensions.dp20),
                      ),
                      Text(
                        product.sellerName,
                        style: GoogleFonts.nunito(
                          color: AppColors.brownColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      greyTextAndBlackText('Mã sản phẩm:', product.slug),
                      const SizedBox(height: 20),
                      greyTextAndBlackText(
                          'Số lượng:', product.quantity.toString()),
                      Row(
                        children: [
                          Text(
                            formatCurrency.format(product.price *
                                (100 - product.discountPercent) /
                                100),
                            style: GoogleFonts.nunito(
                              fontWeight: FontWeight.bold,
                              fontSize: AppDimensions.dp20,
                              // color: AppColors.redColor,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            formatCurrency.format(product.price),
                            style: GoogleFonts.nunito(
                              decoration: TextDecoration.lineThrough,
                              decorationThickness: 3,
                              color: AppColors.redColor,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ]),
            IconHeartWidget(
              isHeart: false,
            )
          ],
        ),
        const Divider()
      ],
    );
  }

  Widget greyTextAndBlackText(String text, String amount) {
    return Wrap(
      children: [
        Text(
          text,
          style: GoogleFonts.nunito(
            color: AppColors.greyColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          amount,
          style: GoogleFonts.nunito(
            color: AppColors.brownColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
