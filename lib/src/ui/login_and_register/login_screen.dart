import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/src/utils/app_colors.dart';
import 'package:it_project/src/utils/app_dimensions.dart';
import 'package:it_project/src/utils/app_pages.dart';
import '../widgets/me_text_field.dart';
import 'login_viewmodel.dart';

class LoginScreen extends GetView<LoginViewModel> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        constraints: const BoxConstraints(
          maxHeight: 700,
          maxWidth: 500,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                'Login',
                style: GoogleFonts.ruda(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              'Email',
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.bold,
              ),
            ),
            MeTextField(
              hintText: 'Your email address',
              textEditingController: controller.emailController,
            ),
            Text(
              'Password',
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.bold,
              ),
            ),
            MeTextField(
              hintText: 'Min 6 characters',
              isPassword: true,
              textEditingController: controller.passwordController,
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text.rich(
                TextSpan(
                  style: GoogleFonts.nunito(),
                  children: [
                    const TextSpan(
                        text: 'By Clicking Continue below, you agree to our '),
                    WidgetSpan(
                        child: InkWell(
                      highlightColor: AppColors.whiteColor,
                      splashColor: AppColors.whiteColor,
                      onTap: () {
                        log('Click');
                      },
                      child: Text('Terms & Conditions',
                          style: GoogleFonts.nunito(
                              color: AppColors.blueColor,
                              decoration: TextDecoration.underline)),
                    )),
                    const TextSpan(text: ' & '),
                    WidgetSpan(
                        child: InkWell(
                      splashColor: AppColors.whiteColor,
                      highlightColor: AppColors.whiteColor,
                      onTap: () {
                        log('Click');
                      },
                      child: Text('Privacy Policy',
                          style: GoogleFonts.nunito(
                              color: AppColors.blueColor,
                              decoration: TextDecoration.underline)),
                    )),
                  ],
                ),
              ),
            ),
            Expanded(child: Container()),
            Center(
              child: InkWell(
                highlightColor: AppColors.whiteColor,
                splashColor: AppColors.whiteColor,
                onTap: () {},
                child: Text('Forgot password?',
                    style: GoogleFonts.nunito(
                      decoration: TextDecoration.underline,
                    )),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              splashColor: AppColors.whiteColor,
              highlightColor: AppColors.whiteColor,
              onTap: () {},
              child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.dp20,
                      vertical: AppDimensions.dp10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: AppColors.blueColor,
                  ),
                  child: Text(
                    'Continue',
                    style: GoogleFonts.nunito(
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.bold,
                      fontSize: AppDimensions.dp16,
                    ),
                  )),
            ),
            Visibility(
                visible: MediaQuery.of(context).viewInsets.bottom == 0,
                child: Column(
                  children: [
                    const SizedBox(height: AppDimensions.dp20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          color: AppColors.brownColor,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: 50,
                          height: 50,
                          color: AppColors.brownColor,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Text.rich(
                          TextSpan(
                            style: GoogleFonts.nunito(),
                            children: [
                              const TextSpan(text: 'Haven\'t an account? '),
                              WidgetSpan(
                                  child: InkWell(
                                highlightColor: AppColors.whiteColor,
                                splashColor: AppColors.whiteColor,
                                onTap: () {
                                  Get.toNamed(AppPages.registerScreen);
                                },
                                child: Text('Sign in',
                                    style: GoogleFonts.nunito(
                                        color: AppColors.blueColor,
                                        decoration: TextDecoration.underline)),
                              )),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ))
          ],
        ),
      )),
    );
  }
}
