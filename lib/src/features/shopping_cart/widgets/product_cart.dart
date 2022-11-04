import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/src/widgets/product_general/product_general_model.dart';

import '../../../configs/constants/app_assets.dart';
import '../../../configs/constants/app_colors.dart';
import '../../../configs/constants/app_dimensions.dart';
import '../../../widgets/icon_heart.dart';

// ignore: must_be_immutable
class ProductCart extends StatefulWidget {
  ProductCart({super.key, required this.isHeart, required this.product});
  bool isHeart;
  final ProductGeneralModel product;

  @override
  State<ProductCart> createState() => _ProductCartState();
}

class _ProductCartState extends State<ProductCart> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
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
                    widget.product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.nunito(
                        fontWeight: FontWeight.bold,
                        fontSize: AppDimensions.dp20),
                  ),
                  Text(
                    'Baby World Shop',
                    style: GoogleFonts.nunito(
                      color: AppColors.brownColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  greyTextAndBlackText('Mã sản phẩm:', '19110253'),
                  const SizedBox(height: 20),
                  greyTextAndBlackText('Số lượng:', '1'),
                  Row(
                    children: [
                      Text(
                        widget.product.price,
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.bold,
                          fontSize: AppDimensions.dp20,
                          // color: AppColors.redColor,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '₫${widget.product.priceAfterDecrement}',
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
          IconHeartWidget(
            isHeart: widget.isHeart,
          )
        ]),
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
