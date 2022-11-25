import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/src/configs/constants/app_assets.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';

class TopSellerWidget extends StatelessWidget {
  const TopSellerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // context.push(Paths.sellerScreen);
      },
      child: Container(
        height: 150,
        width: 170,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.whiteGreyColor)),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
              child: CustomPaint(
                painter: BNBCustomPainter(
                    backgroundColor: AppColors.primaryColor.withOpacity(0.3)),
                size: const Size(200, 200),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                      height: 80,
                      width: 120,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.whiteGreyColor)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          height: 80,
                          width: 120,
                          AppAssets.imgLogoTuoiTre,
                          fit: BoxFit.cover,
                        ),
                      )),
                  const SizedBox(height: 10),
                  Text(
                    'Giảm đến 50%',
                    style: GoogleFonts.nunito(color: AppColors.primaryColor),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BNBCustomPainter extends CustomPainter {
  BNBCustomPainter({required this.backgroundColor});
  final Color backgroundColor;
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;
    Path path = Path();
    final height = size.height;
    final mediumHeight = height * 0.7;
    final sizeWithModify = size.width * 0.3;
    final width = size.width + sizeWithModify;

    path.moveTo(0, height);
    path.lineTo(0, mediumHeight);
    path.arcToPoint(Offset(width - sizeWithModify, mediumHeight),
        radius: Radius.circular(width), clockwise: true);

    // path.moveTo(size.width - 50, height - 50);
    path.lineTo(width - sizeWithModify, height);

// path.lineTo(size.width - 50, height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
