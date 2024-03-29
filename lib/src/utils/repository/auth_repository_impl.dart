import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:it_project/src/utils/remote/model/login/login_request.dart';
import 'package:it_project/src/utils/remote/model/login/login_response.dart';
import 'package:it_project/src/utils/remote/model/register/otp_register_request.dart';
import 'package:it_project/src/utils/remote/model/register/register_request.dart';
import 'package:it_project/src/utils/remote/services/fresult.dart';
import 'package:it_project/src/utils/repository/auth_repository.dart';
import 'package:logger/logger.dart';

class AuthRepositoryImpl extends AuthRepository {
  AuthRepositoryImpl({required super.authService});

  @override
  Future<FResult<LoginResponse?>> manualLogin(
      {required String email, required String password}) async {
    try {
      final result = await authService
          .manualLogin(LoginRequest(email: email, password: password));
      return FResult.success(result);
    } catch (ex) {
      log(ex.toString());
      return FResult.error(ex.toString());
    }
  }

  @override
  Future<FResult<String?>> registerUsernamePassword(
      {required String email,
      required String firstName,
      required String lastName,
      required String password,
      required String gender}) async {
    final registerRequest = RegisterRequest(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        gender: gender);

    try {
      final responseRegister = await authService.register(registerRequest);

      final userId = responseRegister.userId;
      return FResult.success(userId);
    } catch (ex) {
      if (ex is DioError) {
        log(ex.error);
      }

      log(ex.toString());

      return FResult.error(ex.toString());
    }
  }

  @override
  Future<FResult<String?>> otpRegister(
      {required String userId, required int otpCode}) async {
    final otpRequest = OtpRegisterRequest(userId: userId, otp: otpCode);

    try {
      final result = await authService.otpRegister(otpRequest);
      return FResult.success('');
    } catch (ex) {
      log(ex.toString());

      return FResult.error(ex.toString());
    }
  }

  @override
  Future<FResult<String>> emailResetPassword({required String email}) async {
    final emailResetPassword = {'email': email};

    try {
      final result = await authService.emailResetPassword(emailResetPassword);
      return FResult.success(result['userId']);
    } catch (ex) {
      Logger().e(ex);
      return FResult.error(ex.toString());
    }
  }

  @override
  Future<FResult<String>> finalResetPassword(
      {required String password,
      required String token,
      required String userId}) async {
    final finalResetPasswordRequest = {
      'userId': userId,
      'token': token,
      'password': password
    };

    try {
      final result = await authService.finalResetPassword(
          resetPasswordRequest: finalResetPasswordRequest);
      return FResult.success('');
    } catch (ex) {
      Logger().e(ex);
      return FResult.error(ex.toString());
    }
  }

  @override
  Future<FResult<Map<String, dynamic>>> otpResetPassword(
      {required String otp, required String userId}) async {
    final otpResetPasswordRequest = {'otp': otp, 'userId': userId};

    try {
      final result =
          await authService.otpResetPassword(otpResetPasswordRequest);

      return FResult.success(result.data);
    } catch (ex) {
      Logger().e(ex);
      return FResult.error(ex.toString());
    }
  }

  @override
  Future<FResult<LoginResponse>> googleLogin(
      {required String idToken, required String accessToken}) async {
    try {
      final loginResponse = await authService.googleLogin(
          accessToken: accessToken, idToken: idToken);

      return FResult.success(loginResponse);
    } catch (ex) {
      Logger().e(ex);
      return FResult.error(ex.toString());
    }
  }

  @override
  Future<FResult<Map<String, String>>> refreshToken() async {
    try {
      final response = await authService.refreshToken();
      return FResult.success(response);
    } catch (ex) {
      return FResult.error(ex.toString());
    }
  }

  // @override
  // Future<FResult<Map>> refreshToken() async {
  // try {
  // final result = await authService.refreshToken();
  // print(result);
  // return FResult.success(jsonDecode(result));
  // } catch (ex) {
  //   log(ex.toString());
  //   return FResult.error(ex.toString());
  // }
  // }
}
