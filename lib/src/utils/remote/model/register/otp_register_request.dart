import 'package:json_annotation/json_annotation.dart';
part 'otp_register_request.g.dart';

@JsonSerializable()
class OtpRegisterRequest {
  @JsonKey(name: 'userId')
  String userId;
  @JsonKey(name: 'otp')
  int otp;

  OtpRegisterRequest({
    required this.userId,
    required this.otp,
  });

  factory OtpRegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$OtpRegisterRequestFromJson(json);

  Map<String, dynamic> toJson() => _$OtpRegisterRequestToJson(this);
}
