import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/configs/constants/app_dimensions.dart';
import 'package:it_project/src/configs/locates/lang_vi.dart';
import 'package:it_project/src/configs/locates/me_locale_key.dart';

import 'package:it_project/src/features/login_register/cubit/register_cubit.dart';
import 'package:it_project/src/features/login_register/screens/otp_check_screen.dart';
import 'package:it_project/src/utils/helpers/validate.dart';
import 'package:it_project/src/widgets/load_widget.dart';
import 'package:it_project/src/widgets/me_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isRegisterScreen = true;
  String userId = '';
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final bloc = RegisterCubit();
    return BlocProvider<RegisterCubit>(
        create: (context) => bloc,
        child: isRegisterScreen
            ? registerScreen(bloc)
            : OtpCheckScreen(
                userId: userId,
                emailUser: emailController.text,
              ));
  }

  registerScreen(bloc) {
    TextEditingController firstNameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();
    final meLocalKey = viVN;
    final List<String> genders = ['male', 'female'];
    String valueGender = 'male';
    return BlocBuilder<RegisterCubit, RegisterState>(
      bloc: bloc,
      builder: (context, state) {
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
                        meLocalKey[MeLocaleKey.registerLabel] ??
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
                            Navigator.of(context).pop();
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
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MeTextField(
                              text: meLocalKey[MeLocaleKey.emailLabel],
                              textEditingController: emailController,
                              hintText: meLocalKey[MeLocaleKey.emailHintText],
                              isCheckEmpty: bloc.state.isClickedLogin,
                              // callFuncOnChange: controller.checkValidate,
                              functionValidation: (value) {
                                if (value.isEmpty) return null;
                                if (Validate().isInvalidEmail(value)) {
                                  final notification =
                                      meLocalKey[MeLocaleKey.invalidEmail];
                                  return notification;
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            MeTextField(
                              text: meLocalKey[MeLocaleKey.firstNameLabel],
                              textEditingController: firstNameController,
                              hintText: meLocalKey[MeLocaleKey.firstNameHint],
                              isCheckEmpty: bloc.state.isClickedLogin,
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
                              text: meLocalKey[MeLocaleKey.lastNameLabel],
                              textEditingController: lastNameController,
                              hintText: meLocalKey[MeLocaleKey.lastNameHint],
                              isCheckEmpty: bloc.state.isClickedLogin,
                              // callFuncOnChange: controller.checkValidate,
                              functionValidation: (value) {
                                if (value.isEmpty) return null;
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            MeTextField(
                              isPassword: true,
                              text: meLocalKey[MeLocaleKey.passwordLabel],
                              textEditingController: passwordController,
                              isCheckEmpty: bloc.state.isClickedLogin,
                              hintText:
                                  meLocalKey[MeLocaleKey.passwordHintText],
                              // callFuncOnChange: controller.checkValidate,
                              functionValidation: (value) {
                                if (value.isEmpty) return null;

                                if (Validate().isInvalidPassword(value)) {
                                  final notification =
                                      meLocalKey[MeLocaleKey.invalidPassword];
                                  return notification;
                                }

                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            MeTextField(
                              isPassword: true,
                              text:
                                  meLocalKey[MeLocaleKey.confirmPasswordLabel],
                              textEditingController: confirmPasswordController,
                              hintText: meLocalKey[
                                  MeLocaleKey.confirmPasswordHintText],
                              // callFuncOnChange: controller.checkValidate,
                              isCheckEmpty: bloc.state.isClickedLogin,
                              functionValidation: (value) {
                                if (value.isEmpty) return null;

                                final isValidPassword = !Validate()
                                    .isInvalidPassword(passwordController.text);

                                if (value != passwordController.text &&
                                    isValidPassword) {
                                  final notification = meLocalKey[
                                      MeLocaleKey.notificationNotMatchPassword];
                                  return notification;
                                }

                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: Checkbox(
                                      value: bloc.state.isCheckBox,
                                      onChanged: (value) {
                                        bloc.addNewEvent(
                                            RegisterEnum.isCheckBox, value);
                                      }),
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
                            Center(
                                child: Text(
                              bloc.state.announcement ?? '',
                              style: GoogleFonts.nunito(
                                color: AppColors.redColor,
                              ),
                            )),
                            const SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              splashColor: AppColors.whiteColor,
                              highlightColor: AppColors.whiteColor,
                              onTap: () async {
                                final responseRegister =
                                    await bloc.registerButtonClick(
                                  confirmPassword:
                                      confirmPasswordController.text,
                                  emailText: emailController.text,
                                  firstName: firstNameController.text,
                                  gender: valueGender,
                                  lastName: lastNameController.text,
                                  password: passwordController.text,
                                );
                                final result = responseRegister.keys.first;
                                if (result) {
                                  isRegisterScreen = false;
                                  userId = responseRegister.values.first ?? '';
                                  setState(() {});
                                }
                              },
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
                                    meLocalKey[MeLocaleKey.continueLabel] ??
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
              ],
            ),
            bloc.state.isLoading == true ? const LoadWidget() : Container()
          ],
        );
      },
    );
  }
}
