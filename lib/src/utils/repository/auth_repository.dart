import 'package:it_project/src/utils/remote/model/login/login_response.dart';
import 'package:it_project/src/utils/remote/model/user/profile_user.dart';
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
  Future<FResult<ProfileUser>> getInfoUser();
}
