import 'package:it_project/src/features/login_register/services/auth_service.dart';

abstract class AuthRepository {
  final AuthService authService;
  AuthRepository({required this.authService});

  Future<Map<bool, String?>> registerUsernamePassword(
      {required String email,
      required String firstName,
      required String lastName,
      required String password,
      required String gender});
  Future<Map<bool, String?>> otpRegister({
    required String userId,
    required int otpCode,
  });
  Future<Map<bool, String?>> manualLogin({
    required String email,
    required String password,
  });
}
