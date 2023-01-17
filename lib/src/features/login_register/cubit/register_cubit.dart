import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:it_project/main.dart';
import 'package:it_project/src/configs/locates/lang_vi.dart';
import 'package:it_project/src/configs/locates/me_locale_key.dart';
import 'package:it_project/src/configs/routes/routes_name_app.dart';

import 'package:it_project/src/utils/helpers/validate.dart';
import 'package:it_project/src/utils/repository/auth_repository.dart';
import 'package:it_project/src/utils/repository/auth_repository_impl.dart';

part 'register_state.dart';

enum RegisterEnum {
  isCheckBox,
}

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit()
      : super(const RegisterInitial(
            otpAnnouncement: '',
            registerAnnouncement: '',
            isClickedLogin: false,
            isLoading: false,
            isCheckBox: false,
            userId: '',
            time: '',
            emailUser: '',
            gender: 'male'));
  AuthRepository authRepository = getIt<AuthRepositoryImpl>();
  final meLocalKey = viVN;

  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final otpLength = 6;
  late final textEditingControllers =
      List.generate(otpLength, (_) => TextEditingController());

  final List<String> genders = ['male', 'female'];

  setField(RegisterEnum type, {required value}) {
    emit(state.copyWith(isCheckBox: value));
  }

  refreshCubit() {
    firstNameController.text = '';
    lastNameController.text = '';
    passwordController.text = '';
    confirmPasswordController.text = '';
    emailController.text = '';
    for (var item in textEditingControllers) {
      item.text = '';
    }

    emit(const RegisterInitial(
        otpAnnouncement: '',
        registerAnnouncement: '',
        isClickedLogin: false,
        isLoading: false,
        isCheckBox: false,
        time: '',
        userId: '',
        gender: 'male',
        emailUser: ''));
  }

  String otpCode() {
    String otpCode = '';
    for (var item in textEditingControllers) {
      otpCode += item.text;
    }
    return otpCode;
  }

  bool isEmptyField(
      emailText, firstName, lastName, gender, password, confirmPassword) {
    if (emailText.isEmpty ||
        firstName.isEmpty ||
        lastName.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      return true;
    }

    return false;
  }

  bool isAllValidated(
      {required email, required password, required confirmPassword}) {
    final isPasswordMatchConfirmPassword = password == confirmPassword;
    if (Validate().isInvalidPassword(password) ||
        Validate().isInvalidEmail(email) ||
        !isPasswordMatchConfirmPassword ||
        state.isCheckBox == false) return false;
    return true;
  }

  Future<void> registerButtonClick(context) async {
    const bool isClickedLogin = true;
    emit(state.copyWith(isClickedLogin: isClickedLogin));

    final emailText = emailController.text;
    final firstName = firstNameController.text;
    final lastName = lastNameController.text;
    final gender = state.gender;
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (isEmptyField(
        emailController.text,
        firstNameController.text,
        lastNameController.text,
        gender,
        passwordController.text,
        confirmPasswordController.text)) {
      return;
    }
    if (!isAllValidated(
        email: emailText,
        password: password,
        confirmPassword: confirmPassword)) {
      return;
    }

    emit(state.copyWith(isLoading: true));

    final registerResponse = await authRepository.registerUsernamePassword(
      email: emailText,
      firstName: firstName,
      lastName: lastName,
      gender: gender,
      password: password,
    );

    final isSucceedRegister = registerResponse.isSuccess;
    if (isSucceedRegister) {
      final userId = registerResponse.data;
      emit(state.copyWith(userId: userId, emailUser: emailText));

      GoRouter.of(context)
          .replace('${Paths.loginScreen}/${Paths.sOtpCheckScreen}');
      emit(state.copyWith(isLoading: false));

      return;
    }

    emit(state.copyWith(isLoading: false));
    final emailIsExistedAnnouncement = meLocalKey[MeLocaleKey.emailIsExisted];

    emit(state.copyWith(registerAnnouncement: emailIsExistedAnnouncement));
    return;
  }

  // /////////////////////////////////

  Timer? _timer;
  final int maxCount = 5;
  late int start = maxCount;

  Future<bool> sendOtpButtonClick() async {
    bool isLoading = true;
    emit(state.copyWith(isLoading: isLoading));

    final result = await _callApiOtpSend(int.parse(otpCode()), state.userId);

    isLoading = false;
    emit(state.copyWith(isLoading: isLoading));

    if (result) {
      return true;
    }
    return false;
  }

  Future<bool> _callApiOtpSend(int otp, userId) async {
    final otpRegisterResponse =
        await authRepository.otpRegister(userId: userId, otpCode: otp);

    final result = otpRegisterResponse.isSuccess;
    if (result) return true;

    const announcement = 'OTP sai rồi bạn ơi';
    emit(state.copyWith(otpAnnouncement: announcement));
    return false;
  }

  void _cancelTimer() {
    if (_timer != null) {
      _timer?.cancel();
    }
  }

  void startTimer() {
    _cancelTimer();
    start = maxCount;

    emit(state.copyWith(time: start.toString()));

    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start == 0) {
          timer.cancel();
          emit(state.copyWith(time: start.toString()));
        } else {
          start--;
          emit(state.copyWith(time: start.toString()));
        }
      },
    );
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
