import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/src/configs/locates/lang_vi.dart';
import 'package:it_project/src/configs/locates/me_locale_key.dart';
import 'package:it_project/src/configs/constants/app_assets.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/configs/constants/app_dimensions.dart';
import 'package:it_project/src/features/login_register/cubit/otp_cubit.dart';
import 'package:it_project/src/widgets/load_widget.dart';

class OtpCheckScreen extends StatelessWidget {
  const OtpCheckScreen(
      {super.key, required this.userId, required this.emailUser});
  final String userId;
  final String emailUser;
  @override
  Widget build(BuildContext context) {
    const otpLength = 6;
    final textEditingControllers =
        List.generate(otpLength, (index) => TextEditingController());
    List<Widget> otpTextField = List.generate(
        otpLength,
        (index) => otpWidget(
              context,
              index,
              otpLength,
              textEditingControllers[index],
            ));
    final meLocalKey = viVN;
    final bloc = OtpCubit();

    bloc.startTimer();
    return Stack(
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
              Text(
                emailUser,
                style: GoogleFonts.nunito(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 40,
                child: BlocBuilder<OtpCubit, OtpState>(
                    bloc: bloc,
                    builder: (context, state) {
                      return bloc.state.time == '0'
                          ? Column(
                              children: [
                                Text(meLocalKey[MeLocaleKey
                                        .notReceiveOtpWantToReSendOtp] ??
                                    'err: notReceiveOtpWantToReSendOtp'),
                                InkWell(
                                  onTap: () async {
                                    bloc.startTimer();
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
                              '${meLocalKey[MeLocaleKey.waitingLabel]} ${bloc.state.time}');
                    }),
              ),
              BlocBuilder<OtpCubit, OtpState>(
                  bloc: bloc,
                  builder: (context, state) => Center(
                          child: Text(
                        bloc.state.announcement,
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
                children: [...otpTextField],
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () async {
                  await bloc
                      .sendButtonClick(otpCode(textEditingControllers), userId)
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
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        BlocBuilder(
            bloc: bloc,
            builder: (context, state) {
              return bloc.state.isLoading == true
                  ? const LoadWidget()
                  : Container();
            })
      ],
    );
  }

  Container otpWidget(
      context, index, otpLength, TextEditingController textEditingController) {
    final size = MediaQuery.of(context).size.width * 0.1;
    final padding = MediaQuery.of(context).size.width * 0.005;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: padding),
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

  String otpCode(textEditingControllers) {
    String otpCode = '';
    for (var item in textEditingControllers) {
      otpCode += item.text;
    }
    return otpCode;
  }
}
