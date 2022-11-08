import 'package:dio/dio.dart';
import 'package:it_project/src/features/login_register/services/login/login_request.dart';
import 'package:it_project/src/features/login_register/services/login/login_response.dart';
import 'package:it_project/src/features/login_register/services/register/otp_register_request.dart';
import 'package:it_project/src/features/login_register/services/register/register_request.dart';
import 'package:it_project/src/features/login_register/services/register/register_response.dart';

import 'package:it_project/src/utils/services/state_response/success_response.dart';

import 'package:retrofit/retrofit.dart';

part 'auth_service.g.dart';

@RestApi()
abstract class AuthService {
  factory AuthService(Dio dio, {String baseUrl}) = _AuthService;

  @POST("/auth/login")
  Future<LoginResponse> manualLogin(@Body() LoginRequest loginRequest);

  @POST("/auth/mobile-register")
  Future<RegisterResponse> register(@Body() RegisterRequest loginRequest);

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

  // @GET("/api/me")
  // Future<GetMeResponse> getMe();

  @GET("/auth/logout")
  Future<SuccessResponse> logOut(@Body() LoginRequest loginRequest);
}
