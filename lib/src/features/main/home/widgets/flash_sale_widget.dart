import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:it_project/src/configs/constants/app_assets.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/configs/constants/app_dimensions.dart';
import 'package:it_project/src/configs/routes/routes_name_app.dart';
import 'package:it_project/src/utils/remote/model/product/product.dart';

class FlashSaleWidget extends StatelessWidget {
  const FlashSaleWidget({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.simpleCurrency(locale: 'vi_VN');

    return InkWell(
      onTap: () {
        context.push(Paths.productScreen, extra: product);
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppDimensions.dp5),
                  color: AppColors.whiteBrownColor,
                ),
                alignment: Alignment.topCenter,
                child: Image.asset(
                  AppAssets.fkImHarryPotter3,
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              formatCurrency.format(
                  product.price * (100 - product.discountPercent) / 100),
              maxLines: 2,
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(
                  color: AppColors.redColor, fontWeight: FontWeight.bold),
            ),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: AppColors.redColor,
                    borderRadius: BorderRadius.circular(100)),
                child: Text(
                  'Sắp bán hết',
                  style: GoogleFonts.nunito(
                      color: AppColors.whiteColor, fontSize: 10),
                ))
          ],
        ),
      ),
    );
  }
}