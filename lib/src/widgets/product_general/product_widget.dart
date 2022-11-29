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

import 'package:intl/intl.dart';

// ignore: must_be_immutable
class ProductWidget extends StatefulWidget {
  ProductWidget(
      {super.key,
      required this.product,
      required this.isHeart,
      this.isBorder = false});
  final Product product;
  bool isHeart;
  bool isBorder;

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push(
          Paths.productScreen,
          extra: widget.product,
        );
      },
      child: Container(
        height: 300,
        constraints: const BoxConstraints(minWidth: 180),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppColors.whiteColor,
          border: widget.isBorder
              ? Border.all(color: AppColors.whiteGreyColor)
              : null,
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _imageProduct(),
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
    );
  }

  SizedBox infoProduct() {
    return SizedBox(
        height: 70,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            widget.product.name,
            maxLines: 2,
            style: GoogleFonts.nunito(
              fontWeight: FontWeight.bold,
              // fontSize: AppDimensions.dp16
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

    final bool isHighDiscountPrice = (widget.product.discountPercent >= 15);

    double priceAfterSaleOff =
        (100 - widget.product.discountPercent) * widget.product.price / 100;

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
            ' -${widget.product.discountPercent}%',
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
    return SizedBox(
      height: 180,
      width: double.infinity,
      child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(5),
            topRight: Radius.circular(5),
          ),
          child: widget.product.productImages.isEmpty
              ? Image.asset(
                  AppAssets.fkImHarryPotter1,
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.fitHeight,
                )
              : CachedNetworkImage(
                  imageUrl: widget.product.productImages.first.fileLink,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.fitHeight,
                  errorWidget: ((context, url, error) => Image.asset(
                        AppAssets.fkImHarryPotter3,
                      )),
                )),
    );
    //     Image.asset(
    //   AppAssets.fkImHarryPotter1,
    //   width: double.infinity,
    //   height: 180,
    //   fit: BoxFit.cover,
    // )));
  }
}
