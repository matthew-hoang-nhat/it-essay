import 'package:json_annotation/json_annotation.dart';

import 'data_meta.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  @JsonKey(name: 'data')
  DataMeta? data;
  @JsonKey(name: 'access_token')
  String accessToken;

  LoginResponse({
    this.data,
    required this.accessToken,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
