import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:it_project/src/configs/locates/me_locale_key.dart';
import 'package:it_project/src/core/login_register/screens/register_screen.dart';
import 'package:it_project/src/core/login_register/widgets/google_button_widget.dart';

import '../../../configs/constants/app_colors.dart';
import '../../../configs/constants/app_dimensions.dart';
import '../../../features/widgets/me_text_field.dart';
import 'login_viewmodel.dart';

class LoginScreen extends GetView<LoginViewModel> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: Text(
                          controller.meLocalKey?[MeLocaleKey.loginLabel] ??
                              'Đăng nhập',
                          style: GoogleFonts.ruda(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      Obx(
                        () => MeTextField(
                          text: controller.meLocalKey?[MeLocaleKey.emailLabel],
                          hintText:
                              controller.meLocalKey?[MeLocaleKey.emailHintText],
                          textEditingController: controller.emailController,
                          isCheckEmpty: controller.isClickedLogin,
                          functionValidation: (value) {
                            // if (value.isEmpty) return null;

                            // if (Validate().invalidEmail(value)) {
                            //   final notification =
                            //       controller.meLocalKey?[MeLocaleKey.invalidEmail];

                            //   return notification;
                            // }

                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      Obx(
                        () => MeTextField(
                          isPassword: true,
                          text:
                              controller.meLocalKey?[MeLocaleKey.passwordLabel],
                          hintText: controller
                              .meLocalKey?[MeLocaleKey.passwordHintText],
                          textEditingController: controller.passwordController,
                          isCheckEmpty: controller.isClickedLogin,
                          functionValidation: (value) {
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      Obx(() => Center(
                              child: Text(
                            controller.announcementLogin ?? '',
                            style: GoogleFonts.nunito(
                              color: AppColors.redColor,
                            ),
                          ))),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Text.rich(
                          TextSpan(
                              text: controller.meLocalKey?[
                                      MeLocaleKey.agreeOurTermLabel] ??
                                  'err: Điều khoản'),
                        ),
                      ),
                      const SizedBox(height: AppDimensions.dp20),
                      Center(
                        child: InkWell(
                          highlightColor: AppColors.whiteColor,
                          splashColor: AppColors.whiteColor,
                          onTap: () {},
                          child: Text(
                              controller.meLocalKey?[
                                      MeLocaleKey.forgotPasswordLabel] ??
                                  'Err: Quên mật khẩu',
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
                        onTap: controller.loginButtonClick,
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
                              controller
                                      .meLocalKey?[MeLocaleKey.continueLabel] ??
                                  'err: Tiếp tục',
                              style: GoogleFonts.nunito(
                                color: AppColors.whiteColor,
                                fontWeight: FontWeight.bold,
                                fontSize: AppDimensions.dp16,
                              ),
                            )),
                      ),
                      Column(
                        children: [
                          const SizedBox(height: AppDimensions.dp20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    height: 0.2,
                                    color: AppColors.brownColor),
                              ),
                              const Text('or'),
                              Flexible(
                                child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    height: 0.2,
                                    color: AppColors.brownColor),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Center(child: GoogleButtonWidget()),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    const SizedBox(height: 10),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Text.rich(
                          TextSpan(
                            style: GoogleFonts.nunito(),
                            children: [
                              TextSpan(
                                  text:
                                      '${controller.meLocalKey?[MeLocaleKey.haveNotAnAccountLabel]} '),
                              WidgetSpan(
                                  child: InkWell(
                                highlightColor: AppColors.whiteColor,
                                splashColor: AppColors.whiteColor,
                                onTap: () {
                                  // Get.toNamed(AppPages.registerScreen);
                                  showRegister(context);
                                },
                                child: Text(
                                    controller.meLocalKey?[
                                            MeLocaleKey.registerLabel] ??
                                        'err: registerLabel',
                                    style: GoogleFonts.nunito(
                                        fontWeight: FontWeight.bold,
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
                )
              ],
            ),
          ),
          Obx(() => controller.isLoading == true
              ? Container(
                  color: Colors.black54,
                  constraints: const BoxConstraints.expand(),
                  child: const Center(child: CircularProgressIndicator()))
              : Container())
        ],
      )),
    );
  }

  showRegister(context) {
    unFocusKeyBoard(context);

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      builder: (context) => FractionallySizedBox(
          heightFactor: 0.9,
          child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(100)),
              child: const RegisterScreen())),
    );
  }

  unFocusKeyBoard(context) {
    FocusScope.of(context).unfocus();
  }
}
