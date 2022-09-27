import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/src/utils/app_colors.dart';
import 'package:it_project/src/utils/app_dimensions.dart';

class MeButton extends StatelessWidget {
  const MeButton({Key? key, required this.text, required this.func})
      : super(key: key);
  final String text;
  final Function() func;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: func,
      style: ElevatedButton.styleFrom(
        primary: AppColors.blueColor,
        onPrimary: AppColors.darkBlueColor,
        padding: const EdgeInsets.symmetric(horizontal: AppDimensions.dp20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      ),
      child: Text(
        text,
        style: GoogleFonts.nunito(
          color: AppColors.whiteColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
