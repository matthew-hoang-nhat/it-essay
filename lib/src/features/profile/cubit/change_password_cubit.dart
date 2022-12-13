import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:it_project/main.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/features/login_register/cubit/parent_cubit.dart';
import 'package:it_project/src/utils/helpers/validate.dart';
import 'package:it_project/src/utils/repository/profile_respository_impl.dart';

part 'change_password_state.dart';

enum ChangePasswordStateEnum {
  oldPasswordAnnouncement,
  newPasswordAnnouncement,
  confirmPasswordAnnouncement,
  oldPassword,
  newPassword,
  confirmPassword,
  isLoading,
  totalAnnouncement,
  isAllValidated,
}

class ChangePasswordCubit extends Cubit<ChangePasswordState>
    implements ParentCubit<ChangePasswordStateEnum> {
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

  bool _isValidatedAllTextFields() {
    if (Validate().isInvalidPassword(state.newPassword)) return false;
    if (Validate().isInvalidPassword(state.oldPassword)) return false;
    if (state.newPassword != state.confirmPassword) return false;
    return true;
  }

  final profileRepo = getIt<ProfileRepositoryImpl>();

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
      addNewEvent(ChangePasswordStateEnum.isLoading, true);
      final isSuccess = await _changePassword();
      addNewEvent(ChangePasswordStateEnum.isLoading, false);

      if (isSuccess) {
        Fluttertoast.showToast(
            msg: 'Đổi mật khẩu thành công',
            backgroundColor: AppColors.primaryColor);
        GoRouter.of(context).pop();
        return;
      }

      addNewEvent(ChangePasswordStateEnum.totalAnnouncement,
          'Mật khẩu cũ của bạn chưa đúng');
      return;
    }

    if (state.oldPassword.isEmpty) {
      addNewEvent(ChangePasswordStateEnum.oldPasswordAnnouncement,
          'Bạn chưa nhập ô này');
    }
    if (state.newPassword.isEmpty) {
      addNewEvent(ChangePasswordStateEnum.newPasswordAnnouncement,
          'Bạn chưa nhập ô này');
    }
    if (state.confirmPassword.isEmpty) {
      addNewEvent(ChangePasswordStateEnum.confirmPasswordAnnouncement,
          'Bạn chưa nhập ô này');
    }
  }

  _checkNewPassword() {
    bool isHadError = false;
    if (Validate().isInvalidPassword(state.newPassword) &&
        state.newPassword.isNotEmpty) {
      addNewEvent(ChangePasswordStateEnum.newPasswordAnnouncement,
          'Mật khẩu phải bao gồm 8 kí tự: chữ hoa, chữ thường, chữ số và kí tự đặc biệt.');
      isHadError = true;
    }
    if (isHadError == false) {
      addNewEvent(ChangePasswordStateEnum.newPasswordAnnouncement, '');
    }
  }

  _checkConfirmPassword() {
    bool isHadError = false;
    if (state.newPassword != state.confirmPassword &&
        state.confirmPassword.isNotEmpty) {
      addNewEvent(ChangePasswordStateEnum.confirmPasswordAnnouncement,
          'Mật khẩu không khớp');
      isHadError = true;
    }
    if (isHadError == false) {
      addNewEvent(ChangePasswordStateEnum.confirmPasswordAnnouncement, '');
    }
  }

  _checkOldPassword() {
    if (state.oldPassword.isNotEmpty) {
      addNewEvent(ChangePasswordStateEnum.oldPasswordAnnouncement, '');
    }
  }

  void checkAllTextFields() {
    _checkOldPassword();
    _checkNewPassword();
    _checkConfirmPassword();
    final isAllValidated = _isValidatedAllTextFields();
    addNewEvent(ChangePasswordStateEnum.isAllValidated, isAllValidated);
  }

  @override
  void addNewEvent(ChangePasswordStateEnum key, value) {
    if (isClosed) {
      return;
    }
    switch (key) {
      case ChangePasswordStateEnum.oldPasswordAnnouncement:
        emit(NewChangePasswordState.fromOldSettingState(state,
            oldPasswordAnnouncement: value));
        break;
      case ChangePasswordStateEnum.newPasswordAnnouncement:
        emit(NewChangePasswordState.fromOldSettingState(state,
            newPasswordAnnouncement: value));
        break;
      case ChangePasswordStateEnum.confirmPasswordAnnouncement:
        emit(NewChangePasswordState.fromOldSettingState(state,
            confirmPasswordAnnouncement: value));
        break;
      case ChangePasswordStateEnum.oldPassword:
        emit(NewChangePasswordState.fromOldSettingState(state,
            oldPassword: value));
        break;

      case ChangePasswordStateEnum.newPassword:
        emit(NewChangePasswordState.fromOldSettingState(state,
            newPassword: value));
        break;
      case ChangePasswordStateEnum.confirmPassword:
        emit(NewChangePasswordState.fromOldSettingState(state,
            confirmPassword: value));
        break;
      case ChangePasswordStateEnum.isLoading:
        emit(NewChangePasswordState.fromOldSettingState(state,
            isLoading: value));
        break;
      case ChangePasswordStateEnum.totalAnnouncement:
        emit(NewChangePasswordState.fromOldSettingState(state,
            totalAnnouncement: value));
        break;
      case ChangePasswordStateEnum.isAllValidated:
        emit(NewChangePasswordState.fromOldSettingState(state,
            isAllValidated: value));
        break;
    }
  }
}
