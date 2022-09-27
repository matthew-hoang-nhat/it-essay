import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/src/ui/login_and_register/register_viewmodel.dart';
import 'package:it_project/src/ui/widgets/me_text_field.dart';
import 'package:it_project/src/utils/app_dimensions.dart';

import '../../utils/app_colors.dart';

class RegisterScreen extends GetView<RegisterViewModel> {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                'Sign up',
                style: GoogleFonts.ruda(fontSize: AppDimensions.dp30),
              ),
            ),
            Text(
              'Email',
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.bold,
              ),
            ),
            MeTextField(
              textEditingController: controller.emailController,
              hintText: 'Your email address',
            ),
            Text(
              'Password',
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.bold,
              ),
            ),
            MeTextField(
              textEditingController: controller.passwordController,
              hintText: 'Min 6 characters',
            ),
            Text(
              'Confirm Password',
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.bold,
              ),
            ),
            MeTextField(
              textEditingController: controller.confirmPasswordController,
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
                            const TextSpan(text: 'Have an account? '),
                            WidgetSpan(
                                child: InkWell(
                              highlightColor: AppColors.whiteColor,
                              splashColor: AppColors.whiteColor,
                              onTap: () {
                                Get.back();
                              },
                              child: Text('Log in',
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
              ),
            )
          ]),
        ),
      ),
    );
  }
}
