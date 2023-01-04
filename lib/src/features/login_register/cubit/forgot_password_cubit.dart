import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:it_project/main.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/configs/routes/routes_name_app.dart';
import 'package:it_project/src/utils/helpers/validate.dart';
import 'package:it_project/src/utils/repository/auth_repository_impl.dart';

part 'forgot_password_state.dart';

// enum ForgotPasswordStateEnum {
//   announcement,
//   otp,
//   time,
//   isLoading,
//   userId,
//   token,
//   emailUser,
//   newPassword,
//   confirmPassword,
//   newPasswordAnnouncement,
//   confirmPasswordAnnouncement,
//   totalAnnouncement,
// }

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit()
      : super(const ForgotPasswordInitial(
            announcement: '',
            emailUser: '',
            otp: '',
            time: '',
            isLoading: false,
            userId: '',
            token: '',
            confirmPassword: '',
            newPassword: '',
            newPasswordAnnouncement: '',
            confirmPasswordAnnouncement: '',
            totalAnnouncement: ''));

  TextEditingController emailController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final otpControllers = List.generate(6, (_) => TextEditingController());

  setEmailUser(String email) {
    emit(state.copyWith(emailUser: email));
  }

  setOtp(String otp) {
    emit(state.copyWith(otp: otp));
  }

  setNewPassword(String newPassword) {
    emit(state.copyWith(newPassword: newPassword));
  }

  setConfirmPassword(String confirmPassword) {
    emit(state.copyWith(confirmPassword: confirmPassword));
  }

  _refreshAllTextEditingControllers() {
    emailController.text = '';
    for (var item in otpControllers) {
      item.text = '';
    }
    newPasswordController.text = '';
    confirmPasswordController.text = '';
  }

  refreshCubit() {
    _refreshAllTextEditingControllers();
    emit(ForgotPasswordInitial(
        announcement: '',
        emailUser: '',
        otp: '',
        time: '',
        isLoading: false,
        userId: state.userId,
        token: state.token,
        confirmPassword: '',
        newPassword: '',
        newPasswordAnnouncement: '',
        confirmPasswordAnnouncement: '',
        totalAnnouncement: ''));
  }

  checkValidatedEmail() {
    if (Validate().isInvalidEmail(state.emailUser) &&
        state.emailUser.isNotEmpty) {
      const announcement = 'Email không hợp lệ';
      emit(state.copyWith(announcement: announcement));
      return;
    }

    emit(state.copyWith(announcement: ''));
  }

  sendMailOnClick(context) async {
    if (state.emailUser.isEmpty && state.announcement.isEmpty) {
      const announcement = 'Bạn chưa nhập ô này';
      emit(state.copyWith(announcement: announcement));
      return;
    }

    if (Validate().isInvalidEmail(state.emailUser)) return;

    emit(state.copyWith(isLoading: true));
    final result = await authRepo.emailResetPassword(email: state.emailUser);
    final userId = result.data;
    emit(state.copyWith(userId: userId, isLoading: false));

    if (result.isSuccess) {
      GoRouter.of(context).replace(
          '${Paths.loginScreen}/${Paths.sForgotPasswordScreen}/${Paths.sOtpCheckScreenV2}');
      return;
    }

    const totalAnnouncement = 'Email không tồn tại';
    emit(state.copyWith(totalAnnouncement: totalAnnouncement));
  }

  _checkNewPassword() {
    bool isHadError = false;
    if (Validate().isInvalidPassword(state.newPassword) &&
        state.newPassword.isNotEmpty) {
      const newPasswordAnnouncement =
          'Mật khẩu phải bao gồm 8 kí tự: chữ hoa, chữ thường, chữ số và kí tự đặc biệt.';

      emit(state.copyWith(newPasswordAnnouncement: newPasswordAnnouncement));
      isHadError = true;
    }
    if (isHadError == false) {
      emit(state.copyWith(newPasswordAnnouncement: ''));
    }
  }

  _checkConfirmPassword() {
    bool isHadError = false;
    if (state.newPassword != state.confirmPassword &&
        state.confirmPassword.isNotEmpty) {
      const confirmPasswordAnnouncement = 'Mật khẩu không khớp';
      emit(state.copyWith(
          confirmPasswordAnnouncement: confirmPasswordAnnouncement));
      isHadError = true;
    }
    if (isHadError == false) {
      emit(state.copyWith(confirmPasswordAnnouncement: ''));
    }
  }

  checkNewPasswordAndConfirmPassword() {
    _checkNewPassword();
    _checkConfirmPassword();
  }

  bool _isValidatedAllTextFields() {
    if (Validate().isInvalidPassword(state.newPassword)) return false;

    if (state.newPassword != state.confirmPassword) return false;
    return true;
  }

  Future<bool> _changePassword() async {
    final response = await authRepo.finalResetPassword(
        password: state.newPassword, token: state.token, userId: state.userId);
    return response.isSuccess;
  }

  changePasswordOnClick(context) async {
    final isValidatedAllTextField = _isValidatedAllTextFields();

    if (isValidatedAllTextField) {
      emit(state.copyWith(isLoading: true));
      final isSuccess = await _changePassword();
      emit(state.copyWith(isLoading: false));

      if (isSuccess) {
        Fluttertoast.showToast(
            msg: 'Đổi mật khẩu thành công',
            backgroundColor: AppColors.primaryColor);
        GoRouter.of(context).pop();
        return;
      }
    }

    const emptyAnnouncement = 'Bạn chưa nhập ô này';
    if (state.newPassword.isEmpty) {
      emit(state.copyWith(newPasswordAnnouncement: emptyAnnouncement));
    }
    if (state.confirmPassword.isEmpty) {
      emit(state.copyWith(confirmPasswordAnnouncement: emptyAnnouncement));
    }
  }

  refreshForgotPasswordSendEmail() {
    emit(state.copyWith(emailUser: ''));
  }

  String _otpCodeStr() {
    String otpCode = '';
    for (var item in otpControllers) {
      otpCode += item.text;
    }
    return otpCode;
  }

  sendOtpOnClick(context) async {
    final otpCode = _otpCodeStr();
    if (otpCode.length != 6) {
      const announcement = 'Bạn nhập chưa đủ';
      emit(state.copyWith(announcement: announcement));
      return;
    }

    emit(state.copyWith(isLoading: true));
    final result =
        await authRepo.otpResetPassword(otp: otpCode, userId: state.userId);
    emit(state.copyWith(isLoading: false));

    if (result.isSuccess) {
      final token = result.data!['token'];
      emit(state.copyWith(token: token));
      GoRouter.of(context).replace(
          '${Paths.loginScreen}/${Paths.sForgotPasswordScreen}/${Paths.sOtpCheckScreenV2}/${Paths.sResetPasswordScreen}');
      return;
    }

    Fluttertoast.showToast(
        msg: 'Mã OTP không đúng', backgroundColor: AppColors.redColor);
  }

  final authRepo = getIt<AuthRepositoryImpl>();

  // @override
  // void addNewEvent(ForgotPasswordStateEnum key, value) {
  //   if (isClosed) return;
  //   switch (key) {
  //     case ForgotPasswordStateEnum.time:
  //       emit(NewForgotPasswordState.fromOldSettingState(state, time: value));
  //       break;
  //     case ForgotPasswordStateEnum.otp:
  //       emit(NewForgotPasswordState.fromOldSettingState(state, otp: value));
  //       break;
  //     case ForgotPasswordStateEnum.announcement:
  //       emit(NewForgotPasswordState.fromOldSettingState(state,
  //           announcement: value));
  //       break;
  //     case ForgotPasswordStateEnum.isLoading:
  //       emit(NewForgotPasswordState.fromOldSettingState(state,
  //           isLoading: value));
  //       break;
  //     case ForgotPasswordStateEnum.token:
  //       emit(NewForgotPasswordState.fromOldSettingState(state, token: value));
  //       break;
  //     case ForgotPasswordStateEnum.userId:
  //       emit(NewForgotPasswordState.fromOldSettingState(state, userId: value));
  //       break;
  //     case ForgotPasswordStateEnum.emailUser:
  //       emit(NewForgotPasswordState.fromOldSettingState(state,
  //           emailUser: value));
  //       break;
  //     case ForgotPasswordStateEnum.confirmPasswordAnnouncement:
  //       emit(NewForgotPasswordState.fromOldSettingState(state,
  //           confirmPasswordAnnouncement: value));
  //       break;
  //     case ForgotPasswordStateEnum.newPasswordAnnouncement:
  //       emit(NewForgotPasswordState.fromOldSettingState(state,
  //           newPasswordAnnouncement: value));
  //       break;
  //     case ForgotPasswordStateEnum.newPassword:
  //       emit(NewForgotPasswordState.fromOldSettingState(state,
  //           newPassword: value));
  //       break;
  //     case ForgotPasswordStateEnum.confirmPassword:
  //       emit(NewForgotPasswordState.fromOldSettingState(state,
  //           confirmPassword: value));
  //       break;
  //     case ForgotPasswordStateEnum.totalAnnouncement:
  //       emit(NewForgotPasswordState.fromOldSettingState(state,
  //           totalAnnouncement: value));
  //       break;
  //   }
  // }
}
