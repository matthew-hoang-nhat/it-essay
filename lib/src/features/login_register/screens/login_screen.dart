import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/src/configs/locates/lang_vi.dart';

import 'package:it_project/src/configs/locates/me_locale_key.dart';
import 'package:it_project/src/configs/routes/routes_name_app.dart';
import 'package:it_project/src/features/login_register/cubit/login_cubit.dart';
import 'package:it_project/src/features/login_register/screens/register_screen.dart';
import 'package:it_project/src/features/login_register/widgets/google_button_widget.dart';
import 'package:it_project/src/widgets/load_widget.dart';
import 'package:it_project/src/widgets/me_text_field.dart';

import '../../../configs/constants/app_colors.dart';
import '../../../configs/constants/app_dimensions.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = LoginCubit();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    final meLocalKey = viVN;
    return BlocBuilder(
        bloc: bloc,
        builder: (context, state) => Stack(
              children: [
                Scaffold(
                  appBar: AppBar(),
                  resizeToAvoidBottomInset: false,
                  body: SingleChildScrollView(
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
                                  meLocalKey[MeLocaleKey.loginLabel] ??
                                      'Đăng nhập',
                                  style: GoogleFonts.ruda(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 50),
                              MeTextField(
                                text: meLocalKey[MeLocaleKey.emailLabel],
                                hintText: meLocalKey[MeLocaleKey.emailHintText],
                                textEditingController: emailController,
                                isCheckEmpty: bloc.state.isClickedLogin,
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
                              const SizedBox(height: 10),
                              MeTextField(
                                isPassword: true,
                                text: meLocalKey[MeLocaleKey.passwordLabel],
                                hintText:
                                    meLocalKey[MeLocaleKey.passwordHintText],
                                textEditingController: passwordController,
                                isCheckEmpty: bloc.state.isClickedLogin,
                                functionValidation: (value) {
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),
                              Center(
                                  child: Text(
                                bloc.state.announcementLogin,
                                style: GoogleFonts.nunito(
                                  color: AppColors.redColor,
                                ),
                              )),
                              const SizedBox(height: 20),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: Text.rich(
                                  TextSpan(
                                      text: meLocalKey[
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
                                      meLocalKey[MeLocaleKey
                                              .forgotPasswordLabel] ??
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
                                onTap: () {
                                  bloc
                                      .loginCallApi(emailController.text,
                                          passwordController.text)
                                      .then((value) {
                                    if (value == true) {
                                      context.go(Paths.mainScreen);
                                    }
                                  });
                                },
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
                                      meLocalKey[MeLocaleKey.continueLabel] ??
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: Text.rich(
                                  TextSpan(
                                    style: GoogleFonts.nunito(),
                                    children: [
                                      TextSpan(
                                          text:
                                              '${meLocalKey[MeLocaleKey.haveNotAnAccountLabel]} '),
                                      WidgetSpan(
                                          child: InkWell(
                                        highlightColor: AppColors.whiteColor,
                                        splashColor: AppColors.whiteColor,
                                        onTap: () {
                                          showRegister(context);
                                        },
                                        child: Text(
                                            meLocalKey[MeLocaleKey
                                                    .registerLabel] ??
                                                'err: registerLabel',
                                            style: GoogleFonts.nunito(
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.blueColor,
                                                decoration:
                                                    TextDecoration.underline)),
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
                ),
                bloc.state.isLoading == true ? const LoadWidget() : Container()
              ],
            ));
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

  loginLoad() {}
}
