import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';

List<Widget> starWidget(int numberStar, int numberReview, {double? sizeStar}) {
  const maxStar = 5;
  return [
    ...List.generate(
        numberStar,
        (index) => Icon(
              MaterialCommunityIcons.star,
              color: AppColors.yellowColor,
              size: sizeStar ?? 15,
            )),
    ...List.generate(
        maxStar - numberStar,
        (index) => Icon(
              MaterialCommunityIcons.star_outline,
              color: AppColors.yellowColor,
              size: sizeStar ?? 15,
            )),
  ];
}
