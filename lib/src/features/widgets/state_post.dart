import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../configs/constants/app_assets.dart';
import '../../configs/constants/app_colors.dart';
import '../../configs/constants/app_dimensions.dart';

class StatePost extends StatelessWidget {
  const StatePost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(
              AppDimensions.dp20,
            ),
            child: Image.asset(
              AppAssets.imgHarryJpg,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            'The king of drugs',
            style: GoogleFonts.nunito(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Nora Barret',
            style: GoogleFonts.nunito(color: AppColors.whiteBrownColor),
          ),
          Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: 0.5,
                  color: AppColors.blueColor,
                ),
              ),
              const SizedBox(
                width: AppDimensions.dp10,
              ),
              Text(
                '65%',
                style: GoogleFonts.nunito(
                  color: AppColors.whiteBrownColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
