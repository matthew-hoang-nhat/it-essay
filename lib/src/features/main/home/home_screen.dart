import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/src/configs/constants/app_assets.dart';
import 'package:it_project/src/configs/constants/app_dimensions.dart';

import 'package:it_project/src/utils/app_pages.dart';
import 'package:it_project/src/widgets/product_general/product_general_model.dart';

import '../../../configs/constants/app_colors.dart';
import '../../../widgets/category_widget.dart';
import '../../../widgets/product_general/product_general_widget.dart';
import 'home_viewmodel.dart';

class HomeScreen extends GetView<HomeViewModel> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          appBarHome(),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Row(children: [
                        const SizedBox(width: AppDimensions.dp20),
                        bigImage(AppAssets.fkImHarryPotter1),
                        const SizedBox(
                          width: AppDimensions.dp20,
                        ),
                        bigImage(AppAssets.fkImHarryPotter2),
                        const SizedBox(
                          width: AppDimensions.dp20,
                        ),
                        bigImage(AppAssets.fkImHarryPotter3),
                      ]),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Shop by Category',
                            style:
                                GoogleFonts.nunito(color: AppColors.greyColor),
                          ),
                          Text(
                            'CATEGORIES',
                            style: GoogleFonts.nunito(
                                fontSize: AppDimensions.dp30,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                        //   spacing: 20,
                        //   runSpacing: 20,
                        children: [
                          const SizedBox(width: 20),
                          categoryWidget('Thiếu nhi'),
                          const SizedBox(width: 20),
                          categoryWidget('Phát triển bản thân'),
                          const SizedBox(width: 20),
                          categoryWidget('Tiểu thuyết'),
                          const SizedBox(width: 20),
                          categoryWidget('Văn học'),
                          const SizedBox(width: 20),
                          categoryWidget('Phát triển bản thân'),
                          const SizedBox(width: 20),
                          categoryWidget('Tiểu thuyết'),
                          const SizedBox(width: 20),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    productWidgets(),
                    const SizedBox(height: 20),
                  ]),
            ),
          ),
        ],
      ),
    ));
  }

  Padding appBarHome() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Image.asset(
            AppAssets.icLogo,
            height: AppDimensions.dp30,
          ),
          const SizedBox(width: 20),
          Text(
            'Hi Matthew',
            style: GoogleFonts.nunito(
              fontSize: AppDimensions.dp20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: () {
              Get.toNamed(AppPages.cartScreen,
                  arguments: mockProductGeneralModel);
            },
            // child: Image.asset(
            //   AppAssets.icCartFilled,
            //   height: 30,
            // ),
            child: const Icon(MaterialCommunityIcons.cart),
          ),
        ],
      ),
    );
  }

  SingleChildScrollView productWidgets() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 20),
          ProductGeneralWidget(
            product: mockProductGeneralModel,
            isHeart: false,
          ),
          const SizedBox(width: 20),
          ProductGeneralWidget(
            product: mockProductGeneralModel,
            isHeart: false,
          ),
          const SizedBox(width: 20),
          ProductGeneralWidget(
            product: mockProductGeneralModel,
            isHeart: false,
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }

  Widget bigImage(String urlAssets) {
    return SizedBox(
      width: 200,
      height: 300,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppDimensions.dp20),
        child: Image.asset(
          urlAssets,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
