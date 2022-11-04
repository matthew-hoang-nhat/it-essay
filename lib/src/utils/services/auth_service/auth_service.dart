import 'package:dio/dio.dart';
import 'package:it_project/src/utils/services/auth_service/request/otp_register_request.dart';
import 'package:it_project/src/utils/services/auth_service/request/register_request.dart';
import 'package:it_project/src/utils/services/remote/request/login/login_request.dart';
import 'package:it_project/src/utils/services/remote/response/get_me/get_me_response.dart';
import 'package:it_project/src/utils/services/remote/response/login/login_response.dart';
import 'package:it_project/src/utils/services/remote/response/state_response/success_response.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_service.g.dart';

@RestApi()
abstract class AuthService {
  factory AuthService(Dio dio, {String baseUrl}) = _AuthService;

  @POST("/auth/login")
  Future<LoginResponse> manualLogin(@Body() LoginRequest loginRequest);

  @POST("/auth/mobile-register")
  Future<SuccessResponse> register(@Body() RegisterRequest loginRequest);

  @POST("/auth/otp-register")
  Future<SuccessResponse> otpRegister(
      @Body() OtpRegisterRequest otpRegisterRequest);

  // @GET("/api/oauth/google")
  // Future<> googleLogin(@Body() LoginRequest loginRequest);

  // @POST("/auth/email-reset-password")
  // Future<SuccessResponse> emailResetPassword(@Body() String email);

  // @POST("/auth/otp-reset-password")
  // Future<SuccessResponse> otpResetPassword(@Body() int otp);

  // @POST("/auth/reset-password")
  // Future<SuccessResponse> resetPassword(
  //     {@Body() required Map<String, String> tokenAndPassword});

  @GET("/api/me")
  Future<GetMeResponse> getMe();

  @GET("/auth/logout")
  Future<SuccessResponse> logOut(@Body() LoginRequest loginRequest);
}
