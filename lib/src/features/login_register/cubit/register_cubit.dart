import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:it_project/main.dart';
import 'package:it_project/src/configs/locates/lang_vi.dart';
import 'package:it_project/src/configs/locates/me_locale_key.dart';
import 'package:it_project/src/features/login_register/cubit/parent_cubit.dart';

import 'package:it_project/src/utils/helpers/validate.dart';
import 'package:it_project/src/utils/repository/auth_repository.dart';
import 'package:it_project/src/utils/repository/auth_repository_impl.dart';

part 'register_state.dart';

enum RegisterEnum {
  isLoading,
  isClickedLogin,
  announcement,
  isCheckBox,
}

class RegisterCubit extends Cubit<RegisterState>
    implements ParentCubit<RegisterEnum> {
  RegisterCubit()
      : super(const RegisterInitial(
            announcement: '',
            isClickedLogin: false,
            isLoading: false,
            isCheckBox: false));
  AuthRepository authRepository = getIt<AuthRepositoryImpl>();
  final meLocalKey = viVN;

  @override
  void addNewEvent(RegisterEnum key, value) {
    if (isClosed == true) return;
    switch (key) {
      case RegisterEnum.announcement:
        emit(NewRegisterState.fromOldSettingState(state, announcement: value));
        break;
      case RegisterEnum.isCheckBox:
        emit(NewRegisterState.fromOldSettingState(state, isCheckBox: value));
        break;
      case RegisterEnum.isLoading:
        emit(NewRegisterState.fromOldSettingState(state, isLoading: value));
        break;
      case RegisterEnum.isClickedLogin:
        emit(
            NewRegisterState.fromOldSettingState(state, isClickedLogin: value));
        break;
    }
  }

  bool isEmptyFill(String emailText, String passwordText) {
    if (emailText.isEmpty) return true;
    if (passwordText.isEmpty) return true;

    return false;
  }

  bool isValidate(String emailText, String passwordText) {
    if (Validate().isInvalidPassword(passwordText)) {
      return false;
    }
    if (Validate().isInvalidEmail(emailText)) {
      return false;
    }
    return true;
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

  Future<String?> registerButtonClick(
      {required emailText,
      required firstName,
      required lastName,
      required gender,
      required password,
      required confirmPassword}) async {
    const bool isClickedLogin = true;
    emit(NewRegisterState.fromOldSettingState(state,
        isClickedLogin: isClickedLogin));

    if (isEmptyField(
        emailText, firstName, lastName, gender, password, confirmPassword)) {
      return null;
    }
    if (!isAllValidated(
        email: emailText,
        password: password,
        confirmPassword: confirmPassword)) {
      return null;
    }

    bool isLoading = true;
    emit(NewRegisterState.fromOldSettingState(state, isLoading: isLoading));

    final registerResponse = await authRepository.registerUsernamePassword(
      email: emailText,
      firstName: firstName,
      lastName: lastName,
      gender: gender,
      password: password,
    );

    final isSucceedRegister = registerResponse.isSuccess;
    if (isSucceedRegister) {
      return registerResponse.data;
    }

    addNewEvent(RegisterEnum.isLoading, false);
    final announcement = meLocalKey[MeLocaleKey.emailIsExisted];
    addNewEvent(RegisterEnum.announcement, announcement);

    return null;
  }
}
