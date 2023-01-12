import 'package:it_project/src/utils/remote/model/login/login_response.dart';
import 'package:it_project/src/utils/remote/services/auth_service/auth_service.dart';
import 'package:it_project/src/utils/remote/services/fresult.dart';

abstract class AuthRepository {
  final AuthService authService;

  AuthRepository({required this.authService});

  Future<FResult<String?>> registerUsernamePassword(
      {required String email,
      required String firstName,
      required String lastName,
      required String password,
      required String gender});
  Future<FResult<String?>> otpRegister({
    required String userId,
    required int otpCode,
  });
  Future<FResult<LoginResponse?>> manualLogin({
    required String email,
    required String password,
  });

  Future<FResult<LoginResponse>> googleLogin(
      {required String idToken, required String accessToken});

  Future<FResult<String>> emailResetPassword({required String email});
  Future<FResult<Map<String, dynamic>>> otpResetPassword(
      {required String otp, required String userId});
  Future<FResult<String>> finalResetPassword(
      {required String password,
      required String token,
      required String userId});

  Future<FResult<Map<String, String>>> refreshToken();
}
