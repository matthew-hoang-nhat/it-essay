import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/src/configs/locates/lang_vi.dart';
import 'package:it_project/src/configs/locates/me_locale_key.dart';
import 'package:it_project/src/configs/constants/app_assets.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/configs/constants/app_dimensions.dart';
import 'package:it_project/src/features/login_register/cubit/register_cubit.dart';
import 'package:it_project/src/widgets/load_widget.dart';

class OtpCheckScreen extends StatelessWidget {
  const OtpCheckScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final meLocalKey = viVN;
    context.read<RegisterCubit>().startTimer();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        foregroundColor: AppColors.brownColor,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                    meLocalKey[MeLocaleKey.otpSendLabel] ??
                        'error: OTP send label',
                    style: GoogleFonts.ruda(
                        fontSize: AppDimensions.dp30,
                        fontWeight: FontWeight.bold)),
                Image.asset(
                  AppAssets.imOtp,
                  height: 400,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(meLocalKey[MeLocaleKey.sendOtpToEmail] ??
                    'error: sendOtpToEmail'),
                BlocBuilder<RegisterCubit, RegisterState>(
                  builder: (context, state) {
                    return Text(
                      state.emailUser ?? '',
                      style: GoogleFonts.nunito(fontWeight: FontWeight.bold),
                    );
                  },
                ),
                SizedBox(
                  height: 40,
                  child: BlocBuilder<RegisterCubit, RegisterState>(
                      builder: (context, state) {
                    return state.time == '0'
                        ? Column(
                            children: [
                              Text(meLocalKey[MeLocaleKey
                                      .notReceiveOtpWantToReSendOtp] ??
                                  'err: notReceiveOtpWantToReSendOtp'),
                              InkWell(
                                onTap: () async {
                                  context.read<RegisterCubit>().startTimer();
                                },
                                child: Text(
                                  meLocalKey[MeLocaleKey.reSendOTPLabel] ??
                                      'err: reSendOTPLabel',
                                  style: GoogleFonts.nunito(
                                      color: AppColors.blueColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          )
                        : Text(
                            '${meLocalKey[MeLocaleKey.waitingLabel]} ${state.time}');
                  }),
                ),
                BlocBuilder<RegisterCubit, RegisterState>(
                    buildWhen: (previous, current) =>
                        previous.otpAnnouncement != current.otpAnnouncement,
                    builder: (context, state) => Center(
                            child: Text(
                          state.otpAnnouncement ?? '',
                          style: GoogleFonts.nunito(
                            color: AppColors.redColor,
                          ),
                        ))),
                const SizedBox(
                  height: 20,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: List.generate(
                        context.read<RegisterCubit>().otpLength,
                        (index) => otpWidget(
                              context,
                              index,
                              context.read<RegisterCubit>().otpLength,
                              context
                                  .read<RegisterCubit>()
                                  .textEditingControllers[index],
                            ))),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () async {
                    await context
                        .read<RegisterCubit>()
                        .sendOtpButtonClick()
                        .then((value) {
                      if (value) {
                        Navigator.pop(context);
                      }
                    });
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
                ),
              ],
            ),
          ),
          BlocBuilder<RegisterCubit, RegisterState>(builder: (context, state) {
            if (state.isLoading) {
              return const LoadingWidget();
            }
            return Container();
          })
        ],
      ),
    );
  }

  Container otpWidget(
      context, index, otpLength, TextEditingController textEditingController) {
    final size = MediaQuery.of(context).size.width * 0.1;
    const padding = 2.0;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: padding),
      height: size,
      width: size,
      alignment: Alignment.center,
      child: TextField(
        controller: textEditingController,
        style: Theme.of(context).textTheme.bodyMedium,
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
