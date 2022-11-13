import 'package:flutter/cupertino.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/features/main/home/widgets/top_seller_widget.dart';

class ComponentSellerWidget extends StatelessWidget {
  const ComponentSellerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(
                      MaterialCommunityIcons.hexagon,
                      size: 30,
                      color: AppColors.primaryColor,
                    ),
                    Icon(
                      MaterialCommunityIcons.check,
                      color: AppColors.whiteColor,
                      size: 15,
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                Text('Thương hiệu chính hãng',
                    style: GoogleFonts.nunito(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                const Spacer(),
                Text('XEM THÊM',
                    style: GoogleFonts.nunito(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor))
              ],
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 150,
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Container(
                        padding: const EdgeInsets.only(right: 10, left: 10),
                        child: const TopSellerWidget());
                  }
                  return Container(
                      padding: const EdgeInsets.only(right: 10),
                      child: const TopSellerWidget());
                }),
          ),
        ],
      ),
    );
  }
}
