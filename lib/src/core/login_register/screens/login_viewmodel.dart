import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:it_project/src/configs/locates/me_locale_key.dart';
import 'package:it_project/src/utils/helpers/validate.dart';
import 'package:it_project/src/configs/locates/translation_manager.dart';

import '../../../utils/app_pages.dart';
import '../repositories/auth_repository.dart';

class LoginViewModel extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

// ignore: unnecessary_cast
  final Rx<String?> _announcementLoginObs = (null as String?).obs;

  final RxBool _isClickedLoginObs = false.obs;

  final RxBool _isLoadingObs = false.obs;

  final meLocalKey = Get.find<TranslationManager>().keys['vi_VN'];

  bool isEmptyFill() {
    if (emailController.text.isEmpty) return true;
    if (passwordController.text.isEmpty) return true;

    return false;
  }

  bool isValidate() {
    if (Validate().isInvalidPassword(passwordController.text)) {
      return false;
    }
    if (Validate().isInvalidEmail(emailController.text)) {
      return false;
    }
    return true;
  }

  loginButtonClick() async {
    isClickedLogin = true;
    if (isEmptyFill() == true) {
      return;
    }
    if (isValidate() == false) {
      announcementLogin = meLocalKey?[MeLocaleKey.emailOrPasswordNotValid] ??
          'err: emailOrPasswordNotValid';
      return;
    }

    isLoading = true;

    String? result = await Get.find<AuthRepository>().manualLogin(
      email: emailController.text,
      password: passwordController.text,
    );

    isLoading = false;

    bool isSucceedLogin = (result == null);
    if (isSucceedLogin == false) {
      announcementLogin = meLocalKey?[MeLocaleKey.emailOrPasswordNotMatch] ??
          'err: emailOrPasswordNotMatch';
      return;
    }
    bool isLogged = (result == null);
    if (isLogged == true) {
      Get.toNamed(AppPages.mainScreen);
    }
  }

//////////////////////////////////////
  bool get isClickedLogin {
    return _isClickedLoginObs.value;
  }

  set isClickedLogin(bool value) {
    _isClickedLoginObs.value = value;
  }

  bool get isLoading {
    return _isLoadingObs.value;
  }

  set isLoading(bool value) {
    _isLoadingObs.value = value;
  }

  String? get announcementLogin {
    return _announcementLoginObs.value;
  }

  set announcementLogin(String? value) {
    _announcementLoginObs.value = value;
  }
}
