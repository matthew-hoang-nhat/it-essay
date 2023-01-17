import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/src/configs/constants/app_assets.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/configs/constants/app_dimensions.dart';
import 'package:it_project/src/configs/routes/routes_name_app.dart';
import 'package:it_project/src/utils/remote/model/product/product.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:it_project/src/utils/remote/model/product/product_picture.dart';

class ProductHomeWidget extends StatelessWidget {
  const ProductHomeWidget(
      {super.key, required this.product, this.isBorder = true});
  final bool isBorder;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push('${Paths.productScreen}/${product.slug}');
      },
      child: Column(
        children: [
          Container(
            // height: 500,
            height: 320,
            // constraints: const BoxConstraints(minWidth: 180),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: AppColors.whiteColor,
              border:
                  isBorder ? Border.all(color: AppColors.whiteGreyColor) : null,
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  Center(
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        // Container(
                        //   width: 200,
                        //   height: 150,
                        //   decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(10),
                        //       color: AppColors.primaryColor,
                        //       boxShadow: [
                        //         BoxShadow(
                        //           color: AppColors.primaryColor.withOpacity(0.5),
                        //           spreadRadius: 5,
                        //           blurRadius: 5,
                        //           offset: const Offset(3, 5),
                        //         )
                        //       ]),
                        // ),
                        Container(
                          height: 180,
                          padding: const EdgeInsets.only(bottom: 20),
                          child: _imageProduct(),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        infoProduct(),
                        const SizedBox(height: 5),
                        priceWidget(),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  )
                ]),
          ),
        ],
      ),
    );
  }

  SizedBox infoProduct() {
    return SizedBox(
        height: 70,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            product.name,
            maxLines: 2,
            style: GoogleFonts.nunito(
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '4.95',
                style: GoogleFonts.nunito(
                  // fontWeight: FontWeight.bold,
                  // fontSize: AppDimensions.dp16,
                  color: AppColors.greyColor,
                ),
              ),
              Icon(MaterialCommunityIcons.star,
                  size: 15, color: AppColors.yellowColor),
              Text(' Đã bán 100+',
                  style: GoogleFonts.nunito(color: AppColors.greyColor))
            ],
          ),
          //     ))
        ]));
  }

  Widget priceWidget() {
    final formatCurrency = NumberFormat.simpleCurrency(locale: 'vi_VN');
    final bool isHighDiscountPrice = (product.discountPercent >= 15);
    double priceAfterSaleOff =
        (100 - product.discountPercent) * product.price! / 100;

    return Row(
      children: [
        Text(
          formatCurrency.format(priceAfterSaleOff),
          style: GoogleFonts.nunito(
            fontWeight: FontWeight.bold,
            fontSize: AppDimensions.dp16,
            color: isHighDiscountPrice ? AppColors.redColor : null,
          ),
        ),
        if (isHighDiscountPrice)
          Text(
            ' -${product.discountPercent}%',
            style: GoogleFonts.nunito(
              fontWeight: FontWeight.bold,
              // fontSize: AppDimensions.dp10,
              color: AppColors.redColor,
            ),
          ),
      ],
    );
  }

  Widget _imageProduct() {
    final firstImage = (product.productImages as List)
        .map((e) => ProductPicture.fromJson(e))
        .first
        .fileLink;
    return Container(
      height: 180,
      width: 100,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.9),
          spreadRadius: 5,
          blurRadius: 10,
          offset: const Offset(10, 10),
        )
      ]),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: product.productImages.isEmpty
              ? Image.asset(
                  AppAssets.fkImHarryPotter1,
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.fitHeight,
                )
              : CachedNetworkImage(
                  imageUrl: firstImage,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.fitHeight,
                  errorWidget: ((context, url, error) => Image.asset(
                        AppAssets.fkImHarryPotter3,
                      )),
                )),
    );
  }
}
