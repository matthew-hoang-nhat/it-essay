// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:it_project/src/configs/constants/app_colors.dart';

class MeButton extends StatelessWidget {
  const MeButton({
    Key? key,
    required this.text,
    this.textColor = AppColors.primaryColor,
    this.backgroundColor = AppColors.primaryColor,
    this.borderColor = AppColors.primaryColor,
    required this.onTap,
  }) : super(key: key);
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final Color borderColor;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: backgroundColor,
            border: Border.all(color: borderColor)),
        child: Text(
          text,
          style: GoogleFonts.nunito(color: textColor),
        ),
      ),
    );
  }
}
