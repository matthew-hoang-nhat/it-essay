import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/src/core/login_register/screens/register_viewmodel.dart';

import 'package:it_project/src/utils/helpers/validate.dart';
import 'package:it_project/src/configs/locates/me_locale_key.dart';

import '../../../configs/constants/app_colors.dart';
import '../../../configs/constants/app_dimensions.dart';
import '../../../features/widgets/me_text_field.dart';

class RegisterScreen extends GetView<RegisterViewModel> {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(children: [
              const Expanded(child: Text('')),
              Expanded(
                flex: 1,
                child: Text(
                    controller.meLocalKey?[MeLocaleKey.registerLabel] ??
                        'Register Screen',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.ruda(
                        fontSize: AppDimensions.dp30,
                        fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(100),
                      onTap: () {
                        Get.back();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Text('Skip',
                            style: GoogleFonts.nunito(
                                color: AppColors.blueColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16)),
                      ),
                    ),
                  ),
                ),
              )
            ]),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Obx(
                    () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MeTextField(
                            text:
                                controller.meLocalKey?[MeLocaleKey.emailLabel],
                            textEditingController: controller.emailController,
                            hintText: controller
                                .meLocalKey?[MeLocaleKey.emailHintText],
                            isCheckEmpty: controller.isClickedLogin,
                            // callFuncOnChange: controller.checkValidate,
                            functionValidation: (value) {
                              if (value.isEmpty) return null;
                              if (Validate().isInvalidEmail(value)) {
                                final notification = controller
                                    .meLocalKey?[MeLocaleKey.invalidEmail];
                                return notification;
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          MeTextField(
                            text: controller
                                .meLocalKey?[MeLocaleKey.firstNameLabel],
                            textEditingController:
                                controller.firstNameController,
                            hintText: controller
                                .meLocalKey?[MeLocaleKey.firstNameHint],
                            isCheckEmpty: controller.isClickedLogin,
                            // callFuncOnChange: controller.checkValidate,
                            functionValidation: (value) {
                              if (value.isEmpty) return null;
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          MeTextField(
                            text: controller
                                .meLocalKey?[MeLocaleKey.lastNameLabel],
                            textEditingController:
                                controller.lastNameController,
                            hintText: controller
                                .meLocalKey?[MeLocaleKey.lastNameHint],
                            isCheckEmpty: controller.isClickedLogin,
                            // callFuncOnChange: controller.checkValidate,
                            functionValidation: (value) {
                              if (value.isEmpty) return null;
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          MeTextField(
                            isPassword: true,
                            text: controller
                                .meLocalKey?[MeLocaleKey.passwordLabel],
                            textEditingController:
                                controller.passwordController,
                            isCheckEmpty: controller.isClickedLogin,
                            hintText: controller
                                .meLocalKey?[MeLocaleKey.passwordHintText],
                            // callFuncOnChange: controller.checkValidate,
                            functionValidation: (value) {
                              if (value.isEmpty) return null;

                              if (Validate().isInvalidPassword(value)) {
                                final notification = controller
                                    .meLocalKey?[MeLocaleKey.invalidPassword];
                                return notification;
                              }

                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          MeTextField(
                            isPassword: true,
                            text: controller
                                .meLocalKey?[MeLocaleKey.confirmPasswordLabel],
                            textEditingController:
                                controller.confirmPasswordController,
                            hintText: controller.meLocalKey?[
                                MeLocaleKey.confirmPasswordHintText],
                            // callFuncOnChange: controller.checkValidate,
                            isCheckEmpty: controller.isClickedLogin,
                            functionValidation: (value) {
                              if (value.isEmpty) return null;

                              final isValidPassword = !Validate()
                                  .isInvalidPassword(
                                      controller.passwordController.text);

                              if (value != controller.passwordController.text &&
                                  isValidPassword) {
                                final notification = controller.meLocalKey?[
                                    MeLocaleKey.notificationNotMatchPassword];
                                return notification;
                              }

                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          // Obx(
                          //   () => SizedBox(
                          //     width: 400,
                          //     child: Row(
                          //       children: [
                          //         Flexible(
                          //           child: ListTile(
                          //             title: const Text('Male'),
                          //             leading: Radio<String>(
                          //               value: controller.genders[0],
                          //               groupValue: controller.valueGender,
                          //               onChanged: (String? value) {
                          //                 controller.valueGender = value ?? '';
                          //               },
                          //             ),
                          //           ),
                          //         ),
                          //         Flexible(
                          //             child: ListTile(
                          //           title: const Text('Female'),
                          //           leading: Radio<String>(
                          //             groupValue: controller.valueGender,
                          //             value: controller.genders[1],
                          //             onChanged: (String? value) {
                          //               controller.valueGender = value ?? '';
                          //             },
                          //           ),
                          //         )),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Obx(
                                () => SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: Checkbox(
                                      value: controller.isCheckBox,
                                      onChanged: (value) {
                                        controller.isCheckBox = value ?? false;
                                      }),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: RichText(
                                    text: TextSpan(
                                        style: GoogleFonts.nunito(
                                            fontSize: 16,
                                            color: AppColors.brownColor),
                                        children: [
                                      const TextSpan(text: 'I accept the '),
                                      TextSpan(
                                          text: 'terms of membership',
                                          style: GoogleFonts.nunito(
                                              color: AppColors.blueColor)),
                                      const TextSpan(text: ' and '),
                                      TextSpan(
                                          text: 'privacy & policy.',
                                          style: GoogleFonts.nunito(
                                              color: AppColors.blueColor)),
                                    ])),
                              ),
                            ],
                          ),
                          Obx(() => Center(
                                  child: Text(
                                controller.announcement ?? '',
                                style: GoogleFonts.nunito(
                                  color: AppColors.redColor,
                                ),
                              ))),
                          const SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            splashColor: AppColors.whiteColor,
                            highlightColor: AppColors.whiteColor,
                            onTap: controller.registerButtonClick,
                            child: Container(
                                alignment: Alignment.center,
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: AppDimensions.dp20,
                                    vertical: AppDimensions.dp10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: AppColors.blueColor),
                                child: Text(
                                  controller.meLocalKey?[
                                          MeLocaleKey.continueLabel] ??
                                      'Tiếp tục',
                                  style: GoogleFonts.nunito(
                                    color: AppColors.whiteColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: AppDimensions.dp16,
                                  ),
                                )),
                          ),
                        ]),
                  ),
                ),
              ),
            ),
          ],
        ),
        Obx(() => controller.isLoading == true
            ? Container(
                color: Colors.black54,
                constraints: const BoxConstraints.expand(),
                child: const Center(child: CircularProgressIndicator()))
            : Container())
      ],
    );
  }
}
