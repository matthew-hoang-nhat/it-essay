import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/src/utils/app_assets.dart';
import 'package:it_project/src/utils/app_colors.dart';
import 'package:it_project/src/utils/app_dimensions.dart';

class BigPost extends StatelessWidget {
  const BigPost({Key? key, this.backgroundColor}) : super(key: key);
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.dp10, vertical: AppDimensions.dp10),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.whiteBlueColor,
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
              width: 120,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: AppDimensions.dp10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$5.0',
                    style: GoogleFonts.nunito(
                        fontSize: AppDimensions.dp20,
                        fontWeight: FontWeight.bold),
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
            ),
          )
        ],
      ),
    );
  }
}
