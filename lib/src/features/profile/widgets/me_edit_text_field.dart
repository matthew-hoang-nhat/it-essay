import 'package:flutter/material.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';

Widget meEditTextField(TextEditingController textEditingController) {
  return Container(
    color: AppColors.whiteColor,
    child: TextField(
      controller: textEditingController,
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20),
        border: OutlineInputBorder(borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
    ),
  );
}
