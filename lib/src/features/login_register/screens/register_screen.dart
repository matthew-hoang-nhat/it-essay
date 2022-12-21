import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/configs/constants/app_dimensions.dart';
import 'package:it_project/src/configs/locates/me_locale_key.dart';

import 'package:it_project/src/features/login_register/cubit/register_cubit.dart';
import 'package:it_project/src/utils/helpers/validate.dart';
import 'package:it_project/src/widgets/load_widget.dart';
import 'package:it_project/src/widgets/me_text_field.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<RegisterCubit>().refreshCubit();
    final meLocalKey = context.read<RegisterCubit>().meLocalKey;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        foregroundColor: AppColors.brownColor,
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            alignment: Alignment.center,
            child: InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text('Skip',
                    style: GoogleFonts.nunito(
                        color: AppColors.blueColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16)),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(meLocalKey[MeLocaleKey.registerLabel] ?? 'Register Screen',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.ruda(
                      fontSize: AppDimensions.dp30,
                      fontWeight: FontWeight.bold)),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: BlocBuilder<RegisterCubit, RegisterState>(
                      buildWhen: (previous, current) =>
                          previous.isClickedLogin != current.isClickedLogin,
                      builder: (context, state) {
                        return Column(
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  MeTextField(
                                    text: meLocalKey[MeLocaleKey.emailLabel],
                                    textEditingController: context
                                        .read<RegisterCubit>()
                                        .emailController,
                                    hintText:
                                        meLocalKey[MeLocaleKey.emailHintText],
                                    isCheckEmpty: state.isClickedLogin,
                                    functionValidation: (value) {
                                      if (value.isEmpty) return null;
                                      if (Validate().isInvalidEmail(value)) {
                                        final notification = meLocalKey[
                                            MeLocaleKey.invalidEmail];
                                        return notification;
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 10),
                                  MeTextField(
                                    text:
                                        meLocalKey[MeLocaleKey.firstNameLabel],
                                    textEditingController: context
                                        .read<RegisterCubit>()
                                        .firstNameController,
                                    hintText:
                                        meLocalKey[MeLocaleKey.firstNameHint],
                                    isCheckEmpty: state.isClickedLogin,
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
                                    textEditingController: context
                                        .read<RegisterCubit>()
                                        .lastNameController,
                                    hintText:
                                        meLocalKey[MeLocaleKey.lastNameHint],
                                    isCheckEmpty: state.isClickedLogin,
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
                                    textEditingController: context
                                        .read<RegisterCubit>()
                                        .passwordController,
                                    isCheckEmpty: state.isClickedLogin,
                                    hintText: meLocalKey[
                                        MeLocaleKey.passwordHintText],
                                    // callFuncOnChange: controller.checkValidate,
                                    functionValidation: (value) {
                                      if (value.isEmpty) return null;

                                      if (Validate().isInvalidPassword(value)) {
                                        final notification = meLocalKey[
                                            MeLocaleKey.invalidPassword];
                                        return notification;
                                      }

                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 10),
                                  MeTextField(
                                    isPassword: true,
                                    text: meLocalKey[
                                        MeLocaleKey.confirmPasswordLabel],
                                    textEditingController: context
                                        .read<RegisterCubit>()
                                        .confirmPasswordController,
                                    hintText: meLocalKey[
                                        MeLocaleKey.confirmPasswordHintText],
                                    // callFuncOnChange: controller.checkValidate,
                                    isCheckEmpty: state.isClickedLogin,
                                    functionValidation: (value) {
                                      if (value.isEmpty) return null;
                                      final password = context
                                          .read<RegisterCubit>()
                                          .passwordController
                                          .text;
                                      final isValidPassword = !Validate()
                                          .isInvalidPassword(password);
                                      if (value != password &&
                                          isValidPassword) {
                                        final notification = meLocalKey[
                                            MeLocaleKey
                                                .notificationNotMatchPassword];
                                        return notification;
                                      }

                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ]),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                BlocBuilder<RegisterCubit, RegisterState>(
                                  buildWhen: (previous, current) =>
                                      previous.isCheckBox != current.isCheckBox,
                                  builder: (context, state) {
                                    return SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: Checkbox(
                                          value: state.isCheckBox,
                                          onChanged: (value) {
                                            context
                                                .read<RegisterCubit>()
                                                .setField(
                                                    RegisterEnum.isCheckBox,
                                                    value: value);
                                          }),
                                    );
                                  },
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
                            BlocBuilder<RegisterCubit, RegisterState>(
                              buildWhen: (previous, current) =>
                                  previous.registerAnnouncement !=
                                  current.registerAnnouncement,
                              builder: (context, state) {
                                return Center(
                                    child: Text(
                                  state.registerAnnouncement ?? '',
                                  style: GoogleFonts.nunito(
                                    color: AppColors.redColor,
                                  ),
                                ));
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              splashColor: AppColors.whiteColor,
                              highlightColor: AppColors.whiteColor,
                              onTap: () async {
                                await context
                                    .read<RegisterCubit>()
                                    .registerButtonClick(context);
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
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          BlocBuilder<RegisterCubit, RegisterState>(
            buildWhen: (previous, current) =>
                previous.isLoading != current.isLoading,
            builder: (context, state) {
              if (state.isLoading == true) {
                return const LoadingWidget();
              }
              return Container();
            },
          )
        ],
      ),
    );
  }
}
