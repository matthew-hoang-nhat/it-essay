import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:it_project/main.dart';
import 'package:it_project/src/configs/locates/lang_vi.dart';
import 'package:it_project/src/configs/locates/me_locale_key.dart';
import 'package:it_project/src/features/app/cubit/app_cubit.dart';
import 'package:it_project/src/features/login_register/cubit/parent_cubit.dart';

import 'package:it_project/src/utils/helpers/validate.dart';
import 'package:it_project/src/utils/repository/auth_repository.dart';
import 'package:it_project/src/utils/repository/auth_repository_impl.dart';

part 'login_state.dart';

enum LoginEnum { isLoading, isClickedLogin, announcementLogin }

class LoginCubit extends Cubit<LoginState> implements ParentCubit<LoginEnum> {
  LoginCubit()
      : super(LoginInitial(
          announcementLogin: '',
          isClickedLogin: false,
          isLoading: false,
          emailController: TextEditingController(),
          passwordController: TextEditingController(),
        ));
  final AuthRepository authRepository = getIt<AuthRepositoryImpl>();
  // final AppShared _appShared = getIt<AppShared>();

  // String? getTokenValue() => _appShared.getTokenValue();
  // void setTokenValue(String value) => _appShared.setTokenValue(value);

  final meLocalKey = viVN;

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

  Future<bool> loginCallApi(emailText, passwordText) async {
    const isClickedLogin = true;
    addNewEvent(LoginEnum.isClickedLogin, isClickedLogin);

    if (isEmptyFill(emailText, passwordText) == true) {
      return false;
    }
    if (isValidate(emailText, passwordText) == false) {
      final announcementLogin =
          meLocalKey[MeLocaleKey.emailOrPasswordNotValid] ??
              'err: emailOrPasswordNotValid';

      addNewEvent(LoginEnum.announcementLogin, announcementLogin);
      return false;
    }

    bool isLoading = true;
    addNewEvent(LoginEnum.isLoading, isLoading);

    final responseManualLogin = await authRepository.manualLogin(
      email: emailText,
      password: passwordText,
    );

    final isSuccess = responseManualLogin.isSuccess;

    isLoading = false;
    addNewEvent(LoginEnum.isLoading, isLoading);

    if (isSuccess == false) {
      final announcementLogin =
          meLocalKey[MeLocaleKey.emailOrPasswordNotMatch] ??
              'err: emailOrPasswordNotMatch';

      addNewEvent(LoginEnum.announcementLogin, announcementLogin);
      return false;
    }

    final user = responseManualLogin.data;
    if (user != null) {
      getIt<AppCubit>().state.fUserLocal.setUser(
          userId: user.data['_id']!,
          refreshToken: user.refreshToken,
          acceptToken: user.accessToken);
    } else {
      addNewEvent(LoginEnum.announcementLogin, 'Something error');
    }
    return true;
  }

  @override
  void addNewEvent(LoginEnum key, value) {
    if (isClosed) return;
    switch (key) {
      case LoginEnum.isLoading:
        emit(NewLoginState.fromOldSettingState(state, isLoading: value));
        break;
      case LoginEnum.announcementLogin:
        emit(
            NewLoginState.fromOldSettingState(state, announcementLogin: value));
        break;
      case LoginEnum.isClickedLogin:
        emit(NewLoginState.fromOldSettingState(state, isClickedLogin: value));
        break;
    }
  }
}
