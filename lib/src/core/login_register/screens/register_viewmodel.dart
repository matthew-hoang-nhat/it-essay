import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:it_project/src/utils/helpers/validate.dart';
import 'package:it_project/src/configs/locates/translation_manager.dart';

class RegisterViewModel extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final RxBool _isCheckBoxObs = false.obs;

  final List<String> genders = ['male', 'female'];
  final RxString _valueGenderObs = 'male'.obs;
  final meLocalKey = Get.find<TranslationManager>().keys['vi_VN'];
  final RxBool _isClickedLoginObs = false.obs;
  // ignore: unnecessary_cast
  final Rx<String?> _announcementRegisterObs = (null as String?).obs;

  final RxBool _isLoadingObs = false.obs;

  bool isEmptyField() {
    if (emailController.text.isEmpty ||
        firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      return true;
    }

    return false;
  }

  bool isAllValidated() {
    final isPasswordMatchConfirmPassword =
        passwordController.text == confirmPasswordController.text;
    if (Validate().isInvalidPassword(passwordController.text) ||
        Validate().isInvalidEmail(emailController.text) ||
        !isPasswordMatchConfirmPassword) return false;
    return true;
  }

  registerButtonClick() async {
    isClickedLogin = true;
    if (isEmptyField()) return;
    if (!isAllValidated()) return;

    isLoading = true;

    // final registerResponse =
    //     await Get.find<AuthRepository>().registerUsernamePassword(
    //   email: emailController.text,
    //   firstName: firstNameController.text,
    //   lastName: lastNameController.text,
    //   gender: valueGender,
    //   password: passwordController.text,
    // );

    // final isSucceedRegister = (registerResponse == null);
    // if (isSucceedRegister) {
    //   Get.toNamed(AppPages.otpCheckScreen, arguments: emailController.text);
    //   return;
    // }

    isLoading = false;
    // announcement = meLocalKey?[MeLocaleKey.emailIsExisted];
  }

  // GetterSetter
  String? get announcement {
    return _announcementRegisterObs.value;
  }

  set announcement(String? value) {
    _announcementRegisterObs.value = value;
  }

  String get valueGender {
    return _valueGenderObs.value;
  }

  set valueGender(String value) {
    _valueGenderObs.value = value;
  }

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

  bool get isCheckBox {
    return _isCheckBoxObs.value;
  }

  set isCheckBox(bool value) {
    _isCheckBoxObs.value = value;
  }
}
