import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:it_project/main.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/configs/routes/routes_name_app.dart';
import 'package:it_project/src/utils/helpers/validate.dart';
import 'package:it_project/src/utils/repository/auth_repository_impl.dart';

import 'parent_cubit.dart';

part 'forgot_password_state.dart';

enum ForgotPasswordStateEnum {
  announcement,
  otp,
  time,
  isLoading,
  userId,
  token,
  emailUser,
  newPassword,
  confirmPassword,
  newPasswordAnnouncement,
  confirmPasswordAnnouncement,
  totalAnnouncement,
}

class ForgotPasswordCubit extends Cubit<ForgotPasswordState>
    implements ParentCubit<ForgotPasswordStateEnum> {
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

  refreshCubit() {
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
      addNewEvent(ForgotPasswordStateEnum.announcement, announcement);
      return;
    }
    addNewEvent(ForgotPasswordStateEnum.announcement, '');
  }

  sendMailOnClick(context) async {
    if (state.emailUser.isEmpty && state.announcement.isEmpty) {
      const announcement = 'Bạn chưa nhập ô này';
      addNewEvent(ForgotPasswordStateEnum.announcement, announcement);
      return;
    }

    if (Validate().isInvalidEmail(state.emailUser)) return;

    addNewEvent(ForgotPasswordStateEnum.isLoading, true);
    final result = await authRepo.emailResetPassword(email: state.emailUser);

    final userId = result.data;
    addNewEvent(ForgotPasswordStateEnum.userId, userId);

    addNewEvent(ForgotPasswordStateEnum.isLoading, false);

    if (result.isSuccess) {
      GoRouter.of(context).replace(
          '${Paths.loginScreen}/${Paths.sForgotPasswordScreen}/${Paths.sOtpCheckScreenV2}');
      return;
    }

    addNewEvent(
        ForgotPasswordStateEnum.totalAnnouncement, 'Email không tồn tại');
  }

  _checkNewPassword() {
    bool isHadError = false;
    if (Validate().isInvalidPassword(state.newPassword) &&
        state.newPassword.isNotEmpty) {
      addNewEvent(ForgotPasswordStateEnum.newPasswordAnnouncement,
          'Mật khẩu phải bao gồm 8 kí tự: chữ hoa, chữ thường, chữ số và kí tự đặc biệt.');
      isHadError = true;
    }
    if (isHadError == false) {
      addNewEvent(ForgotPasswordStateEnum.newPasswordAnnouncement, '');
    }
  }

  _checkConfirmPassword() {
    bool isHadError = false;
    if (state.newPassword != state.confirmPassword &&
        state.confirmPassword.isNotEmpty) {
      addNewEvent(ForgotPasswordStateEnum.confirmPasswordAnnouncement,
          'Mật khẩu không khớp');
      isHadError = true;
    }
    if (isHadError == false) {
      addNewEvent(ForgotPasswordStateEnum.confirmPasswordAnnouncement, '');
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
      addNewEvent(ForgotPasswordStateEnum.isLoading, true);
      final isSuccess = await _changePassword();
      addNewEvent(ForgotPasswordStateEnum.isLoading, false);

      if (isSuccess) {
        Fluttertoast.showToast(
            msg: 'Đổi mật khẩu thành công',
            backgroundColor: AppColors.primaryColor);
        GoRouter.of(context).pop();
        return;
      }
    }

    if (state.newPassword.isEmpty) {
      addNewEvent(ForgotPasswordStateEnum.newPasswordAnnouncement,
          'Bạn chưa nhập ô này');
    }
    if (state.confirmPassword.isEmpty) {
      addNewEvent(ForgotPasswordStateEnum.confirmPasswordAnnouncement,
          'Bạn chưa nhập ô này');
    }
  }

  sendOtpOnClick(context) async {
    if (state.otp.length != 6) {
      const announcement = 'Bạn nhập chưa đủ';
      addNewEvent(ForgotPasswordStateEnum.announcement, announcement);
      return;
    }
    addNewEvent(ForgotPasswordStateEnum.isLoading, true);
    final result =
        await authRepo.otpResetPassword(otp: state.otp, userId: state.userId);

    addNewEvent(ForgotPasswordStateEnum.isLoading, false);

    if (result.isSuccess) {
      final token = result.data!['token'];
      addNewEvent(ForgotPasswordStateEnum.token, token);
      GoRouter.of(context).replace(
          '${Paths.loginScreen}/${Paths.sForgotPasswordScreen}/${Paths.sOtpCheckScreenV2}/${Paths.sResetPasswordScreen}');
      return;
    }

    Fluttertoast.showToast(
        msg: 'Mã OTP không đúng', backgroundColor: AppColors.redColor);
  }

  final authRepo = getIt<AuthRepositoryImpl>();

  @override
  void addNewEvent(ForgotPasswordStateEnum key, value) {
    if (isClosed) return;
    switch (key) {
      case ForgotPasswordStateEnum.time:
        emit(NewForgotPasswordState.fromOldSettingState(state, time: value));
        break;
      case ForgotPasswordStateEnum.otp:
        emit(NewForgotPasswordState.fromOldSettingState(state, otp: value));
        break;
      case ForgotPasswordStateEnum.announcement:
        emit(NewForgotPasswordState.fromOldSettingState(state,
            announcement: value));
        break;
      case ForgotPasswordStateEnum.isLoading:
        emit(NewForgotPasswordState.fromOldSettingState(state,
            isLoading: value));
        break;
      case ForgotPasswordStateEnum.token:
        emit(NewForgotPasswordState.fromOldSettingState(state, token: value));
        break;
      case ForgotPasswordStateEnum.userId:
        emit(NewForgotPasswordState.fromOldSettingState(state, userId: value));
        break;
      case ForgotPasswordStateEnum.emailUser:
        emit(NewForgotPasswordState.fromOldSettingState(state,
            emailUser: value));
        break;
      case ForgotPasswordStateEnum.confirmPasswordAnnouncement:
        emit(NewForgotPasswordState.fromOldSettingState(state,
            confirmPasswordAnnouncement: value));
        break;
      case ForgotPasswordStateEnum.newPasswordAnnouncement:
        emit(NewForgotPasswordState.fromOldSettingState(state,
            newPasswordAnnouncement: value));
        break;
      case ForgotPasswordStateEnum.newPassword:
        emit(NewForgotPasswordState.fromOldSettingState(state,
            newPassword: value));
        break;
      case ForgotPasswordStateEnum.confirmPassword:
        emit(NewForgotPasswordState.fromOldSettingState(state,
            confirmPassword: value));
        break;
      case ForgotPasswordStateEnum.totalAnnouncement:
        emit(NewForgotPasswordState.fromOldSettingState(state,
            totalAnnouncement: value));
        break;
    }
  }
}
