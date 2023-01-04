import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';

Widget concreteSearchBar({String? text}) {
  return Container(
    height: 50,
    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    padding: const EdgeInsets.symmetric(horizontal: 10),
    decoration: BoxDecoration(
        color: AppColors.whiteColor,
        // border: Border.all(color: AppColors.brownColor),
        border: Border.all(color: AppColors.whiteColor),
        borderRadius: BorderRadius.circular(5)),
    child: Row(children: [
      Icon(
        MaterialCommunityIcons.crosshairs,
        color: AppColors.greyColor,
      ),
      const SizedBox(width: 10),
      Expanded(
        child: Text(
          text ??
              'Warren Buffett: 22 thương vụ đầu tiên và bài học đắt giá từ những sai lầm',
          style: GoogleFonts.nunito(
            fontSize: 16,
            color: AppColors.greyColor,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      const Spacer(),
      Icon(
        MaterialCommunityIcons.arrow_right_circle,
        color: AppColors.brownColor,
      ),
    ]),
  );
}
