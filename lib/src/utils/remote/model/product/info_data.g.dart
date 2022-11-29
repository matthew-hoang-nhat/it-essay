// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InfoData _$InfoDataFromJson(Map<String, dynamic> json) => InfoData(
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      name: json['name'] as String?,
      avatar: json['avatar'] as String?,
      gender: json['gender'] as String?,
      birthDay: json['birthDay'] as String?,
    );

Map<String, dynamic> _$InfoDataToJson(InfoData instance) => <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'name': instance.name,
      'birthDay': instance.birthDay,
      'gender': instance.gender,
      'avatar': instance.avatar,
    };
