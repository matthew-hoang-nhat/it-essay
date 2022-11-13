import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/src/configs/constants/app_assets.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/configs/constants/app_dimensions.dart';
import 'package:it_project/src/configs/locates/lang_vi.dart';
import 'package:it_project/src/widgets/product_general/product_general_model.dart';

// ignore: must_be_immutable
class ProductWidget extends StatefulWidget {
  ProductWidget(
      {super.key,
      required this.product,
      required this.isHeart,
      this.isBorder = false});
  final BriefProductModel product;
  bool isHeart;
  bool isBorder;
  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  final meLocalKey = viVN;
  bool isFollow = false;
  final formatCurrency = NumberFormat.simpleCurrency(locale: 'vi_VN');

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      // width: 180,
      constraints: const BoxConstraints(minWidth: 180),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColors.whiteColor,
        border: widget.isBorder
            ? Border.all(color: AppColors.whiteGreyColor)
            : null,
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        imageProduct(),
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
              Text(' Đã bán 1000+',
                  style: GoogleFonts.nunito(color: AppColors.greyColor))
            ],
          ),
          //     ))
        ]));
  }

  Widget priceWidget() {
    final bool isHighDiscountPrice =
        ((widget.product.discountPercent ?? 0) >= 15);
    return Row(
      children: [
        Text(
          formatCurrency.format(widget.product.price),
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

  Widget imageProduct() {
    return ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
        ),
        child:
            // widget.product.productImage == null
            //     ? Image.asset(
            //         AppAssets.fkImHarryPotter1,
            //         width: double.infinity,
            //         height: 180,
            //         fit: BoxFit.cover,
            //       )
            //     : Image.network(
            //         widget.product.productImage!,
            //         height: 180,
            //         width: double.infinity,
            //         fit: BoxFit.cover,
            //       ));
            Image.asset(
          AppAssets.fkImHarryPotter1,
          width: double.infinity,
          height: 180,
          fit: BoxFit.cover,
        ));
  }
}
