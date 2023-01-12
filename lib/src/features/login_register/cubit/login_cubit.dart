import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:it_project/main.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
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

enum TypeLoginEnum { manual, google }

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
      _storeProfileUserInLocal(loginResponse, TypeLoginEnum.manual);
    } else {
      addNewEvent(LoginEnum.announcementLogin, 'Something error');
    }
    return FResult.success('Thành công');
  }

  final serverClientId =
      '177322333542-5s78k6m5htmshg70qiprq450413qafts.apps.googleusercontent.com';
  late final googleSignIn =
      GoogleSignIn(serverClientId: serverClientId, scopes: [
    'https://www.googleapis.com/auth/userinfo.profile',
    'https://www.googleapis.com/auth/userinfo.email'
  ]);
  Future<void> googleLoginClick() async {
    addNewEvent(LoginEnum.isLoading, true);

    if (await googleSignIn.isSignedIn() == true) {
      googleSignIn.signOut();
    }
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final idToken = googleAuth?.idToken ?? '';
    final accessToken = googleAuth?.accessToken ?? '';
    final result = await authRepository.googleLogin(
        idToken: idToken, accessToken: accessToken);

    if (result.isSuccess) {
      final loginResponse = result.data!;
      await _storeProfileUserInLocal(loginResponse, TypeLoginEnum.google);
    }
    if (result.isError) {
      _announceAccountNotExist();
    }

    addNewEvent(LoginEnum.isLoading, false);
  }

  _announceAccountNotExist() {
    Fluttertoast.showToast(
        msg: 'Tài khoản chưa được đăng ký với Bitini',
        backgroundColor: AppColors.redColor,
        textColor: AppColors.whiteColor);
  }

  _storeProfileUserInLocal(
      LoginResponse loginResponse, TypeLoginEnum typeLogin) {
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
    GoRouter.of(context).go(Paths.mainScreen);
    BlocProvider.of<AppCubit>(context).afterLoginInAppCubit();
    BlocProvider.of<MainCubit>(context).reloadMainScreen();

    String name = '';
    switch (typeLogin) {
      case TypeLoginEnum.manual:
        final String lastName = loginResponse.data['lastName'] ?? '';
        final String firstName = loginResponse.data['firstName'] ?? '';
        name = '$firstName $lastName';
        break;
      case TypeLoginEnum.google:
        final String firstName = loginResponse.data['name'] ?? '';
        name = firstName;
        break;
      default:
    }

    Fluttertoast.showToast(
        msg: 'Chào mừng $name đến với Bitini',
        backgroundColor: AppColors.primaryColor,
        textColor: AppColors.whiteColor);
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
