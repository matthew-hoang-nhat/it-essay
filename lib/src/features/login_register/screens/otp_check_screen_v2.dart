// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:it_project/src/configs/constants/app_assets.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/configs/constants/app_dimensions.dart';
import 'package:it_project/src/features/login_register/cubit/forgot_password_cubit.dart';
import 'package:it_project/src/widgets/load_widget.dart';

class OTPCheckScreenV2 extends StatelessWidget {
  const OTPCheckScreenV2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
              child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Text('Gửi mã OTP',
                    style: GoogleFonts.ruda(
                        fontSize: AppDimensions.dp30,
                        fontWeight: FontWeight.bold)),
                Image.asset(AppAssets.imOtp, height: 400),
                const SizedBox(
                  height: 20,
                ),
                const Text('Chúng tôi đã gửi mã OTP đến'),
                BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                  buildWhen: (previous, current) =>
                      previous.emailUser != current.emailUser,
                  builder: (context, state) {
                    return Text(
                      state.emailUser,
                      style: GoogleFonts.nunito(fontWeight: FontWeight.bold),
                    );
                  },
                ),
                const SizedBox(height: 20),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        6,
                        (index) => otpWidget(
                              context,
                              index,
                              6,
                              context
                                  .read<ForgotPasswordCubit>()
                                  .otpControllers[index],
                            ))),
                const SizedBox(height: 20),
                BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                  buildWhen: (previous, current) => previous.otp != current.otp,
                  builder: (context, state) {
                    return InkWell(
                      onTap: () async {
                        context
                            .read<ForgotPasswordCubit>()
                            .sendOtpOnClick(context);
                      },
                      child: Container(
                        width: 300,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: AppColors.blueColor,
                        ),
                        child: Text(
                          'Gửi',
                          style: GoogleFonts.nunito(
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          )),
          BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
            buildWhen: (previous, current) =>
                previous.isLoading != current.isLoading,
            builder: (context, state) {
              if (state.isLoading) return const LoadingWidget();
              return Container();
            },
          )
        ],
      ),
    );
  }

  Container otpWidget(
    context,
    index,
    otpLength,
    TextEditingController textEditingController,
  ) {
    const size = 40.0;
    const padding = 2.0;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: padding),
      height: size,
      width: size,
      alignment: Alignment.center,
      child: TextField(
        controller: textEditingController,
        // style: Theme.of(context).textTheme.bodyMedium,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        onChanged: (value) {
          if (value.isEmpty && index != 0) {
            FocusScope.of(context).previousFocus();
          }
          if (value.length == 1 && index != otpLength - 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
        cursorColor: AppColors.brownColor,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          fillColor: Colors.red,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide(width: 3, color: AppColors.brownColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide(width: 3, color: AppColors.brownColor),
          ),
        ),
      ),
    );
  }
}
