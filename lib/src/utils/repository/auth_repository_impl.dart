import 'dart:developer';

import 'package:it_project/src/utils/remote/model/login/login_request.dart';
import 'package:it_project/src/utils/remote/model/login/login_response.dart';
import 'package:it_project/src/utils/remote/model/register/otp_register_request.dart';
import 'package:it_project/src/utils/remote/model/register/register_request.dart';
import 'package:it_project/src/utils/remote/model/user/profile_user.dart';
import 'package:it_project/src/utils/remote/services/fresult.dart';
import 'package:it_project/src/utils/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  AuthRepositoryImpl({
    required super.authService,
  });

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
  Future<FResult<ProfileUser>> getInfoUser() async {
    try {
      final result = await authService.getInfo();
      return FResult.success(ProfileUser.fromJson(result.data));
    } catch (ex) {
      log(ex.toString());
      return FResult.error(ex.toString());
    }
  }
}
