// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_profile_user_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateProfileUserRequest _$UpdateProfileUserRequestFromJson(
        Map<String, dynamic> json) =>
    UpdateProfileUserRequest(
      profile: json['profile'] == null
          ? null
          : UpdateProfileUserData.fromJson(
              json['profile'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UpdateProfileUserRequestToJson(
        UpdateProfileUserRequest instance) =>
    <String, dynamic>{
      'profile': instance.profile,
    };
