// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  @JsonKey(name: 'access_token')
  String accessToken;
  @JsonKey(name: 'refresh_token')
  String refreshToken;

  @JsonKey(name: 'data')
  Map<String, dynamic> data;

  LoginResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
