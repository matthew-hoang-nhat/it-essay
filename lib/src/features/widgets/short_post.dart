import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../configs/constants/app_assets.dart';
import '../../configs/constants/app_colors.dart';
import '../../configs/constants/app_dimensions.dart';

class ShortPost extends StatelessWidget {
  const ShortPost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.dp10, vertical: AppDimensions.dp5),
      decoration: BoxDecoration(
        color: AppColors.whiteBlueColor,
        borderRadius: BorderRadius.circular(AppDimensions.dp20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppDimensions.dp20),
            child: Image.asset(
              AppAssets.imgHarryJpg,
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: AppDimensions.dp10,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: AppDimensions.dp10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Harry Potter and deathly hallows',
                      style: GoogleFonts.nunito(
                        fontWeight: FontWeight.bold,
                      )),
                  Text('J.K. Rowling',
                      style: GoogleFonts.nunito(
                          color: AppColors.whiteBrownColor,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            '\$5.0',
            style: GoogleFonts.nunito(
                fontSize: AppDimensions.dp20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
