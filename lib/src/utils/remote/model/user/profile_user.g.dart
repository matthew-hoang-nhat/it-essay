// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileUser _$ProfileUserFromJson(Map<String, dynamic> json) => ProfileUser(
      contact: ContactData.fromJson(json['contact'] as Map<String, dynamic>),
      local: LocalData.fromJson(json['local'] as Map<String, dynamic>),
      info: InfoData.fromJson(json['info'] as Map<String, dynamic>),
      role: json['role'] as String,
      meta: MetaData.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProfileUserToJson(ProfileUser instance) =>
    <String, dynamic>{
      'contact': instance.contact,
      'local': instance.local,
      'info': instance.info,
      'role': instance.role,
      'meta': instance.meta,
    };
