// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:it_project/src/configs/constants/app_assets.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/configs/constants/app_dimensions.dart';
import 'package:it_project/src/configs/locates/lang_vi.dart';
import 'package:it_project/src/configs/locates/me_locale_key.dart';
import 'package:it_project/src/features/login_register/cubit/forgot_password_cubit.dart';
import 'package:it_project/src/widgets/load_widget.dart';
import 'package:logger/logger.dart';

class OTPCheckScreenV2 extends StatefulWidget {
  const OTPCheckScreenV2({
    Key? key,
  }) : super(key: key);

  @override
  State<OTPCheckScreenV2> createState() => _OTPCheckScreenV2State();
}

class _OTPCheckScreenV2State extends State<OTPCheckScreenV2> {
  final meLocalKey = viVN;

  final textEditingControllers =
      List.generate(6, (_) => TextEditingController());
  late List<Widget> otpTextField;

  @override
  void initState() {
    otpTextField = List.generate(
        6,
        (index) => otpWidget(
              index,
              6,
              textEditingControllers[index],
            ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Logger().i('Rebuild screen');
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
                Text(meLocalKey[MeLocaleKey.sendOtpToEmail] ??
                    'error: sendOtpToEmail'),
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
                    children: otpTextField),
                const SizedBox(height: 20),
                BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                  buildWhen: (previous, current) => previous.otp != current.otp,
                  builder: (context, state) {
                    return InkWell(
                      onTap: () async {
                        final otpCodeStr = otpCode(textEditingControllers);
                        context.read<ForgotPasswordCubit>()
                          ..addNewEvent(ForgotPasswordStateEnum.otp, otpCodeStr)
                          ..sendOtpOnClick(context);
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
                          meLocalKey[MeLocaleKey.sendLabel] ?? 'err: sendLabel',
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
      index, otpLength, TextEditingController textEditingController) {
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

  String otpCode(List<TextEditingController> textEditingControllers) {
    String otpCode = '';
    for (var item in textEditingControllers) {
      otpCode += item.text;
    }
    return otpCode;
  }
}
