import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:it_project/src/configs/constants/app_assets.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/configs/constants/app_dimensions.dart';
import 'package:it_project/src/configs/routes/routes_name_app.dart';
import 'package:it_project/src/utils/remote/model/product/product.dart';
import 'package:it_project/src/utils/remote/model/product/product_picture.dart';

class FlashSaleWidget extends StatelessWidget {
  const FlashSaleWidget({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.simpleCurrency(locale: 'vi_VN');
    final size = MediaQuery.of(context).size.width * 2 / 8;

    final firstImage = (product.productImages as List)
        .map((e) => ProductPicture.fromJson(e))
        .first
        .fileLink;
    return InkWell(
      onTap: () {
        context.push('${Paths.productScreen}/${product.slug}');
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
                  width: size,
                  height: size,
                  // constraints:
                  //     const BoxConstraints(minHeight: 200, minWidth: 200),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppDimensions.dp5),
                    color: AppColors.whiteBrownColor,
                  ),
                  alignment: Alignment.topCenter,
                  child: CachedNetworkImage(
                    imageUrl: firstImage,
                    width: size,
                    height: size,
                    fit: BoxFit.cover,
                    errorWidget: ((context, url, error) => Image.asset(
                          AppAssets.fkImHarryPotter3,
                        )),
                  )),
            ),
            const SizedBox(height: 5),
            Text(
              formatCurrency.format(
                  product.price! * (100 - product.discountPercent) / 100),
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
