import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/src/utils/app_assets.dart';
import 'package:it_project/src/utils/app_colors.dart';
import 'package:it_project/src/utils/app_dimensions.dart';

class AdPost extends StatelessWidget {
  const AdPost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.dp10, vertical: AppDimensions.dp10),
      decoration: BoxDecoration(
        color: AppColors.whiteBlueColor,
        borderRadius: BorderRadius.circular(AppDimensions.dp20),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.5),
        //     spreadRadius: 5,
        //     blurRadius: 7,
        //     offset: const Offset(0, 3), // changes position of shadow
        //   ),
        // ],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppDimensions.dp20),
                child: Image.asset(
                  AppAssets.imgHarryJpg,
                  width: double.infinity,
                  height: 220,
                  fit: BoxFit.cover,
                ),
              ),
              Row(
                children: [
                  Flexible(
                    child: Text(
                      'Harry Potter and deathly hallows',
                      style: GoogleFonts.nunito(
                        fontSize: AppDimensions.dp16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Text('J.K. Rowling',
                  style: GoogleFonts.nunito(
                      color: AppColors.whiteBrownColor,
                      fontWeight: FontWeight.bold)),
              Row(
                children: [
                  ...List.generate(
                      4,
                      (index) => Icon(
                            Icons.star,
                            size: 15,
                            color: AppColors.redColor,
                          )),
                  ...List.generate(
                      1,
                      (index) => Icon(
                            size: 15,
                            Icons.star_border_outlined,
                            color: AppColors.redColor,
                          )),
                  Text(
                    '(4.1)',
                    style: GoogleFonts.nunito(
                      color: AppColors.redColor,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              )
            ],
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              margin: const EdgeInsets.only(
                top: 10,
                right: 10,
              ),
              padding: const EdgeInsets.all(AppDimensions.dp5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: AppColors.whiteColor),
              child: Icon(
                Icons.heart_broken,
                color: AppColors.redColor,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 120),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(100),
                  bottomRight: Radius.circular(100)),
              color: AppColors.blueColor,
            ),
            padding: const EdgeInsets.symmetric(
                vertical: AppDimensions.dp5, horizontal: AppDimensions.dp20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$5.0',
                  style: GoogleFonts.nunito(
                      // fontSize: AppDimensions.dp20,
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
