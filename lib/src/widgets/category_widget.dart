import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../configs/constants/app_colors.dart';
import '../configs/constants/app_dimensions.dart';

Widget categoryWidget(String title) {
  return Container(
    width: Get.width * 1 / 5,
    height: Get.width * 1 / 5 * 5 / 4,
    constraints: const BoxConstraints(maxWidth: 200),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(AppDimensions.dp10),
      color: AppColors.whiteBrownColor,
      // boxShadow: const [BoxShadow()],
    ),
    alignment: Alignment.topCenter,
    child: Column(
      children: [
        SizedBox(
            height: 40,
            width: 100,
            child: Text(
              title,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(fontWeight: FontWeight.bold),
            )),
        const SizedBox(
          height: 10,
        ),
        const Icon(
          MaterialCommunityIcons.school,
          size: 40,
        )
      ],
    ),
  );
}
