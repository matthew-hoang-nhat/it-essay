import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/src/configs/constants/app_assets.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/configs/constants/app_dimensions.dart';
import 'package:it_project/src/widgets/product_general/product_general_model.dart';

import '../../configs/locates/translation_manager.dart';
import '../icon_heart.dart';

class ProductGeneralWidget extends StatefulWidget {
  ProductGeneralWidget(
      {super.key, required this.product, required this.isHeart});
  final ProductGeneralModel product;
  bool isHeart;
  @override
  State<ProductGeneralWidget> createState() => _ProductGeneralWidgetState();
}

class _ProductGeneralWidgetState extends State<ProductGeneralWidget> {
  final meLocalKey = Get.find<TranslationManager>().keys['vi_VN'];

  bool isFollow = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Card(
          child: Container(
            height: 320,
            width: 200,
            decoration: BoxDecoration(
              // border: Border.all(
              //   color: AppColors.whiteBrownColor,
              //   width: 2,
              // ),

              color: AppColors.whiteColor,
              // borderRadius: BorderRadius.circular(
              //   AppDimensions.dp10,
              // ),
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
                child: Image.asset(
                  AppAssets.fkImHarryPotter1,
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),
                      Text(
                        widget.product.name,
                        style: GoogleFonts.nunito(
                            fontWeight: FontWeight.bold,
                            fontSize: AppDimensions.dp20),
                      ),
                      Text(
                        widget.product.mainCategory,
                        style: GoogleFonts.nunito(
                          color: AppColors.greyColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            '₫${widget.product.price}',
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
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              )
            ]),
          ),
        ),
        IconHeartWidget(
          isHeart: widget.isHeart,
        )
      ],
    );
  }
}
