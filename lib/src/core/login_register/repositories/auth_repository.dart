import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:it_project/src/utils/app_shared.dart';

import '../../../utils/services/auth_service/auth_service.dart';

import '../../../utils/services/auth_service/request/otp_register_request.dart';
import '../../../utils/services/auth_service/request/register_request.dart';
import '../../../utils/services/remote/request/login/login_request.dart';
import '../../../utils/services/remote/response/state_response/error_response.dart';

part '../../../utils/helpers/extensions.dart';

class AuthRepository {
  final AppShared _appShared;

  final AuthService _authService;

  AuthRepository(this._appShared, this._authService);

  void setTokenValue(String value) => _appShared.setTokenValue(value);
  Stream<String?>? watchTokenValue() => _appShared.watchTokenValue();

  Future<String?> manualLogin(
      {required String email, required String password}) async {
    try {
      final result = await _authService
          .manualLogin(LoginRequest(email: email, password: password));
      Get.find<AppShared>().setTokenValue(result.accessToken);
      return null;
    } catch (dioError) {
      if (dioError is DioError) {
        return dioError.errorsToString();
      }
      return dioError.toString();
    }
  }

  Future<String?> registerUsernamePassword(
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
      final result = await _authService.register(registerRequest);
      return null;
    } catch (dioError) {
      if (dioError is DioError) {
        return dioError.errorsToString();
      }
      return dioError.toString();
    }
  }

  Future<String?> otpRegister(
      {required String email, required int otpCode}) async {
    final otpRequest = OtpRegisterRequest(email: email, otp: otpCode);

    try {
      final result = await _authService.otpRegister(otpRequest);
      return null;
    } catch (dioError) {
      if (dioError is DioError) {
        return dioError.errorsToString();
      }
      return dioError.toString();
    }
  }
}
