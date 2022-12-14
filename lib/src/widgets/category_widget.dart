import 'package:flutter/material.dart';
import 'package:it_project/src/configs/constants/app_assets.dart';

import 'package:it_project/src/utils/remote/model/category/category.dart';

import '../configs/constants/app_colors.dart';
import '../configs/constants/app_dimensions.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    Key? key,
    required this.category,
    this.width,
    this.height,
  }) : super(key: key);

  final Category category;
  final double? width;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              // constraints: BoxConstraints(minHeight: height, minWidth: width),
              width: width,
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppDimensions.dp10),
                color: AppColors.whiteBrownColor,
              ),
              alignment: Alignment.topCenter,
              child: Image.asset(
                AppAssets.fkImHarryPotter1,
                width: width,
                height: height,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(
              height: 40,
              width: 80,
              child: Text(
                category.name,
                maxLines: 2,
                textAlign: TextAlign.center,
              )),
        ],
      ),
    );
  }
}
