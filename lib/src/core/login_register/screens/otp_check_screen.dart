import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/src/configs/locates/me_locale_key.dart';
import 'package:it_project/src/configs/constants/app_assets.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/configs/constants/app_dimensions.dart';

import 'otp_check_viewmodel.dart';

class OtpCheckScreen extends GetView<OtpCheckViewModel> {
  const OtpCheckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> otpTextField = List.generate(
        controller.otpLength,
        (index) => otpWidget(
              context,
              index,
              controller.otpLength,
              controller.textEditingControllers[index],
            ));

    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
            controller.meLocalKey?[MeLocaleKey.otpSendLabel] ??
                'error: OTP send label',
            style: GoogleFonts.ruda(
                fontSize: AppDimensions.dp30, fontWeight: FontWeight.bold)),
        Image.asset(
          AppAssets.imOtp,
          height: 400,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(controller.meLocalKey?[MeLocaleKey.sendOtpToEmail] ??
            'error: sendOtpToEmail'),
        Text(
          controller.emailUser,
          style: GoogleFonts.nunito(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 40,
          child: Obx(
            () => controller.start == 0
                ? Column(
                    children: [
                      Text(controller.meLocalKey?[
                              MeLocaleKey.notReceiveOtpWantToReSendOtp] ??
                          'err: notReceiveOtpWantToReSendOtp'),
                      InkWell(
                        onTap: () {
                          controller.startTimer();
                        },
                        child: Text(
                          controller.meLocalKey?[MeLocaleKey.reSendOTPLabel] ??
                              'err: reSendOTPLabel',
                          style: GoogleFonts.nunito(
                              color: AppColors.blueColor,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )
                : Text(
                    '${controller.meLocalKey?[MeLocaleKey.waitingLabel]} ${controller.start}'),
          ),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [...otpTextField],
        ),
        const SizedBox(height: 20),
        InkWell(
          onTap: controller.sendButtonClick,
          child: Container(
            width: 300,
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: AppColors.blueColor,
            ),
            child: Text(
              controller.meLocalKey?[MeLocaleKey.sendLabel] ?? 'err: sendLabel',
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
    );
  }

  Container otpWidget(
      context, index, otpLength, TextEditingController textEditingController) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: 50,
      width: 50,
      child: TextField(
        controller: textEditingController,
        style: Theme.of(context).textTheme.headline6,
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
