import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:it_project/src/utils/app_pages.dart';

import '../../../configs/locates/translation_manager.dart';
import '../repositories/auth_repository.dart';

class OtpCheckViewModel extends GetxController {
  final otpLength = 6;
  late final textEditingControllers =
      List.generate(otpLength, (index) => TextEditingController());

  final emailUser = Get.arguments;
  final meLocalKey = Get.find<TranslationManager>().keys['vi_VN'];
  bool isLoading = false;

  // ignore: unnecessary_cast
  final Rx<String?> _announcementObs = (null as String?).obs;

  @override
  void onInit() {
    super.onInit();
    setUp();
  }

  setUp() {
    startTimer();
  }

  sendButtonClick() async {
    String otpCode = '';
    for (var item in textEditingControllers) {
      otpCode += item.text;
    }
    isLoading = true;
    final result = await callApiOtpSend(int.parse(otpCode));
    isLoading = false;

    if (result) {
      Get.offAllNamed(AppPages.homeScreen);
    }
  }

  Future<bool> callApiOtpSend(int otp) async {
    final result = await Get.find<AuthRepository>()
        .otpRegister(email: emailUser, otpCode: otp);
    if (result == null) return true;
    announcement = 'OTP sai rồi bạn ơi';
    return false;
  }

  late Timer _timer;
  final int maxCount = 5;
  late final RxInt _startObs = maxCount.obs;

  void startTimer() {
    start = 5;
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start == 0) {
          timer.cancel();
        } else {
          start--;
        }
      },
    );
  }

  @override
  void onClose() {
    _timer.cancel();

    super.onClose();
  }

  int get start {
    return _startObs.value;
  }

  set start(int value) {
    _startObs.value = value;
  }

  // getter setter
  String? get announcement {
    return _announcementObs.value;
  }

  set announcement(String? value) {
    _announcementObs.value = value;
  }
}
