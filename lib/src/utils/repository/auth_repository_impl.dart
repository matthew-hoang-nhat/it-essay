import 'package:dio/dio.dart';
import 'package:it_project/src/utils/remote/model/login/login_request.dart';
import 'package:it_project/src/utils/remote/model/register/otp_register_request.dart';
import 'package:it_project/src/utils/remote/model/register/register_request.dart';
import 'package:it_project/src/utils/remote/services/fresult.dart';
import 'package:it_project/src/utils/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  AuthRepositoryImpl({
    required super.authService,
  });

  @override
  Future<FResult<String?>> manualLogin(
      {required String email, required String password}) async {
    try {
      final result = await authService
          .manualLogin(LoginRequest(email: email, password: password));
      return FResult.success(result.accessToken);
    } catch (dioError) {
      if (dioError is DioError) {
        return FResult.error(dioError.toString());
      }
      final errMessage = dioError.toString();
      return FResult.error(errMessage);
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
    } catch (dioError) {
      if (dioError is DioError) {
        return FResult.error(dioError.toString());
      }
      return FResult.error(dioError.toString());
    }
  }

  @override
  Future<FResult<String?>> otpRegister(
      {required String userId, required int otpCode}) async {
    final otpRequest = OtpRegisterRequest(userId: userId, otp: otpCode);

    try {
      final result = await authService.otpRegister(otpRequest);
      return FResult.success('');
    } catch (dioError) {
      if (dioError is DioError) {
        // return dioError.errorsToString();
      }
      return FResult.error(dioError.toString());
    }
  }
}
