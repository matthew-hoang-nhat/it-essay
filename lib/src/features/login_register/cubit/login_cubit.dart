import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:it_project/main.dart';
import 'package:it_project/src/configs/locates/lang_vi.dart';
import 'package:it_project/src/configs/locates/me_locale_key.dart';
import 'package:it_project/src/configs/routes/routes_name_app.dart';
import 'package:it_project/src/features/app/cubit/app_cubit.dart';
import 'package:it_project/src/features/app/fuser_local.dart';
import 'package:it_project/src/features/login_register/cubit/parent_cubit.dart';
import 'package:it_project/src/features/main/cubit/main_cubit.dart';
import 'package:it_project/src/local/dao/fuser_local_dao.dart';

import 'package:it_project/src/utils/helpers/validate.dart';
import 'package:it_project/src/utils/remote/model/login/login_response.dart';
import 'package:it_project/src/utils/remote/services/fresult.dart';
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

  Future<FResult<String>> manualLogin(emailText, passwordText) async {
    const isClickedLogin = true;
    addNewEvent(LoginEnum.isClickedLogin, isClickedLogin);

    if (isEmptyFill(emailText, passwordText) == true) {
      return FResult.error('Thất bại');
    }
    if (isValidate(emailText, passwordText) == false) {
      final announcementLogin =
          meLocalKey[MeLocaleKey.emailOrPasswordNotValid] ??
              'err: emailOrPasswordNotValid';

      addNewEvent(LoginEnum.announcementLogin, announcementLogin);
      return FResult.error('Thất bại');
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
      return FResult.error('Thất bại');
    }

    final loginResponse = responseManualLogin.data;
    if (loginResponse != null) {
      _loginSuccessHandle(loginResponse);
    } else {
      addNewEvent(LoginEnum.announcementLogin, 'Something error');
    }
    return FResult.success('Thành công');
  }

  Future<FResult<String>> googleLoginClick() async {
    const serverClientId =
        '177322333542-5s78k6m5htmshg70qiprq450413qafts.apps.googleusercontent.com';
    final GoogleSignInAccount? googleUser =
        await GoogleSignIn(serverClientId: serverClientId, scopes: [
      'https://www.googleapis.com/auth/userinfo.profile',
      'https://www.googleapis.com/auth/userinfo.email'
    ]).signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final idToken = googleAuth?.idToken ?? '';
    final accessToken = googleAuth?.accessToken ?? '';
    final result = await authRepository.googleLogin(
        idToken: idToken, accessToken: accessToken);

    if (result.isSuccess) {
      final loginResponse = result.data!;
      _loginSuccessHandle(loginResponse);
      return FResult.success('Đăng nhập thành công');
    }
    if (result.isError) {
      _loginFailHandle();
      return FResult.error('Đăng nhập thất bại');
    }

    return FResult.exception('Đăng nhập Exception');
  }

  _loginFailHandle() {}
  _loginSuccessHandle(LoginResponse loginResponse) {
    getIt<FUserLocal>().fUser = FUserLocalDao(
        phoneNumber: '',
        firstName: loginResponse.data['firstName'],
        lastName: loginResponse.data['lastName'],
        avatar: loginResponse.data['profilePicture'],
        userId: loginResponse.data['_id']!,
        refreshToken: loginResponse.refreshToken,
        accessToken: loginResponse.accessToken,
        gender: 'male');

    final context = navigatorKey.currentContext!;
    BlocProvider.of<AppCubit>(context).afterLoginInAppCubit();
    GoRouter.of(context).go(Paths.mainScreen);
    BlocProvider.of<MainCubit>(context).reloadMainScreen();
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
