import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:it_project/main.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/utils/helpers/validate.dart';
import 'package:it_project/src/utils/repository/profile_repository_impl.dart';

part 'change_password_state.dart';

enum ChangePasswordStateEnum {
  oldPasswordAnnouncement,
  newPasswordAnnouncement,
  confirmPasswordAnnouncement,
  oldPassword,
  newPassword,
  confirmPasswordController,
  isLoading,
  totalAnnouncement,
  isAllValidated,
}

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit()
      : super(const ChangePasswordInitial(
          oldPasswordAnnouncement: '',
          newPasswordAnnouncement: '',
          confirmPasswordAnnouncement: '',
          totalAnnouncement: '',
          confirmPassword: '',
          newPassword: '',
          oldPassword: '',
          isLoading: false,
          isAllValidated: false,
        ));

  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final profileRepo = getIt<ProfileRepositoryImpl>();

  setNewPassword(String newPassword) {
    emit(state.copyWith(newPassword: newPassword));
  }

  setOldPassword(String oldPassword) {
    emit(state.copyWith(oldPassword: oldPassword));
  }

  setConfirmPassword(String confirmPassword) {
    emit(state.copyWith(confirmPassword: confirmPassword));
  }

  bool _isValidatedAllTextFields() {
    if (Validate().isInvalidPassword(state.newPassword)) return false;
    if (state.newPassword != state.confirmPassword) return false;
    return true;
  }

  Future<bool> _changePassword() async {
    final response = await profileRepo.changePassword(
      oldPassword: state.oldPassword,
      newPassword: state.newPassword,
    );
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

      const totalAnnouncement = 'Mật khẩu cũ của bạn chưa đúng';
      emit(state.copyWith(totalAnnouncement: totalAnnouncement));
      return;
    }

    const emptyAnnouncement = 'Bạn chưa nhập ô này';
    if (state.oldPassword.isEmpty) {
      emit(state.copyWith(oldPasswordAnnouncement: emptyAnnouncement));
    }
    if (state.newPassword.isEmpty) {
      emit(state.copyWith(newPasswordAnnouncement: emptyAnnouncement));
    }
    if (state.confirmPassword.isEmpty) {
      emit(state.copyWith(confirmPasswordAnnouncement: emptyAnnouncement));
    }
  }

  _checkNewPassword() {
    bool isHadError = false;
    if (Validate().isInvalidPassword(state.newPassword) &&
        state.newPassword.isNotEmpty) {
      const requirePasswordAnnouncement =
          'Mật khẩu phải bao gồm 8 kí tự: chữ hoa, chữ thường, chữ số và kí tự đặc biệt.';

      emit(
          state.copyWith(newPasswordAnnouncement: requirePasswordAnnouncement));

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
      const notMatchAnnouncement = 'Mật khẩu không khớp';
      emit(state.copyWith(confirmPasswordAnnouncement: notMatchAnnouncement));
      isHadError = true;
    }
    if (isHadError == false) {
      emit(state.copyWith(confirmPasswordAnnouncement: ''));
    }
  }

  _checkOldPassword() {
    if (state.oldPassword.isNotEmpty) {
      emit(state.copyWith(oldPasswordAnnouncement: ''));
    }
  }

  void checkAllTextFields() {
    _checkOldPassword();
    _checkNewPassword();
    _checkConfirmPassword();
    final isAllValidated = _isValidatedAllTextFields();
    emit(state.copyWith(isAllValidated: isAllValidated));
  }

  // @override
  // void addNewEvent(ChangePasswordStateEnum key, value) {
  //   if (isClosed) {
  //     return;
  //   }
  //   switch (key) {
  //     case ChangePasswordStateEnum.oldPasswordAnnouncement:
  //       emit(NewChangePasswordState.fromOldSettingState(state,
  //           oldPasswordAnnouncement: value));
  //       break;
  //     case ChangePasswordStateEnum.newPasswordAnnouncement:
  //       emit(NewChangePasswordState.fromOldSettingState(state,
  //           newPasswordAnnouncement: value));
  //       break;
  //     case ChangePasswordStateEnum.confirmPasswordAnnouncement:
  //       emit(NewChangePasswordState.fromOldSettingState(state,
  //           confirmPasswordAnnouncement: value));
  //       break;
  //     case ChangePasswordStateEnum.oldPassword:
  //       emit(NewChangePasswordState.fromOldSettingState(state,
  //           oldPassword: value));
  //       break;

  //     case ChangePasswordStateEnum.newPassword:
  //       emit(NewChangePasswordState.fromOldSettingState(state,
  //           newPassword: value));
  //       break;
  //     case ChangePasswordStateEnum.confirmPassword:
  //       emit(NewChangePasswordState.fromOldSettingState(state,
  //           confirmPassword: value));
  //       break;
  //     case ChangePasswordStateEnum.isLoading:
  //       emit(NewChangePasswordState.fromOldSettingState(state,
  //           isLoading: value));
  //       break;
  //     case ChangePasswordStateEnum.totalAnnouncement:
  //       emit(NewChangePasswordState.fromOldSettingState(state,
  //           totalAnnouncement: value));
  //       break;
  //     case ChangePasswordStateEnum.isAllValidated:
  //       emit(NewChangePasswordState.fromOldSettingState(state,
  //           isAllValidated: value));
  //       break;
  //   }
  // }
}
