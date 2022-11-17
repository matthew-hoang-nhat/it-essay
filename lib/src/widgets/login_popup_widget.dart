import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/src/configs/routes/routes_name_app.dart';

import '../configs/constants/app_assets.dart';
import '../configs/constants/app_colors.dart';
import '../configs/constants/app_dimensions.dart';

class LoginPopup extends StatelessWidget {
  const LoginPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * .2,
        ),
        Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              padding: const EdgeInsets.only(
                  top: 40, bottom: 20, left: 20, right: 20),
              // const EdgeInsets.only(left: 50, right: 20, top: 40, bottom: 20),
              height: 200,
              width: double.infinity,
              margin: const EdgeInsets.only(
                  left: 50, right: 50, top: 40, bottom: 0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppDimensions.dp10),
                color: AppColors.darkBackgroundColor,
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Thông báo',
                      style: GoogleFonts.nunito(
                        fontSize: AppDimensions.dp20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                        'Để sử dụng các tính năng cho người dùng, bạn cần '),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            context.push(Paths.loginScreen);
                          },
                          child: buttonTitle(
                            backgroundColor: AppColors.backgroundColor,
                            textColor: AppColors.brownColor,
                            title: 'Đăng nhập',
                          ),
                        ),
                        const SizedBox(width: 20),
                        InkWell(
                          onTap: () {
                            context.push(Paths.loginScreen, extra: true);
                          },
                          child: buttonTitle(
                              backgroundColor: AppColors.brownColor,
                              textColor: AppColors.backgroundColor,
                              title: 'Đăng ký'),
                        ),
                      ],
                    ),
                  ]),
            ),
            Image.asset(
              AppAssets.icBook,
              height: 90,
              width: 90,
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                  margin: const EdgeInsets.only(right: 60, top: 55),
                  child: const Icon(Icons.close)),
            )
          ],
        ),
      ],
    );
  }

  Widget buttonTitle(
      {required String title,
      required Color backgroundColor,
      required Color textColor}) {
    return Container(
      height: 40,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: backgroundColor,
      ),
      alignment: Alignment.center,
      child: Text(
        title,
        style: GoogleFonts.nunito(color: textColor),
      ),
    );
  }
}
