// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_register_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OtpRegisterRequest _$OtpRegisterRequestFromJson(Map<String, dynamic> json) =>
    OtpRegisterRequest(
      userId: json['userId'] as String,
      otp: json['otp'] as int,
    );

Map<String, dynamic> _$OtpRegisterRequestToJson(OtpRegisterRequest instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'otp': instance.otp,
    };
