import 'package:dio/dio.dart';
import 'package:it_project/src/features/login_register/repositories/auth_repository.dart';
import 'package:it_project/src/features/login_register/services/login/login_request.dart';
import 'package:it_project/src/features/login_register/services/register/otp_register_request.dart';
import 'package:it_project/src/features/login_register/services/register/register_request.dart';

class AuthRepositoryImpl extends AuthRepository {
  AuthRepositoryImpl({
    required super.authService,
  });

  @override
  Future<Map<bool, String?>> manualLogin(
      {required String email, required String password}) async {
    try {
      final result = await authService
          .manualLogin(LoginRequest(email: email, password: password));
      return {true: result.accessToken};
    } catch (dioError) {
      if (dioError is DioError) {
        // return dioError.errorsToString();
      }
      final errMessage = dioError.toString();
      return {false: errMessage};
    }
  }

  @override
  Future<Map<bool, String?>> registerUsernamePassword(
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
      return {true: userId};
    } catch (dioError) {
      if (dioError is DioError) {
        // return dioError.errorsToString();
      }
      return {false: dioError.toString()};
    }
  }

  @override
  Future<Map<bool, String?>> otpRegister(
      {required String userId, required int otpCode}) async {
    final otpRequest = OtpRegisterRequest(userId: userId, otp: otpCode);

    try {
      final result = await authService.otpRegister(otpRequest);
      return {true: null};
    } catch (dioError) {
      if (dioError is DioError) {
        // return dioError.errorsToString();
      }
      return {false: dioError.toString()};
    }
  }
}
