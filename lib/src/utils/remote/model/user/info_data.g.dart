// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InfoData _$InfoDataFromJson(Map<String, dynamic> json) => InfoData(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      gender: json['gender'] as String,
      nickName: json['nickName'] as String,
      language: json['language'] as String,
    );

Map<String, dynamic> _$InfoDataToJson(InfoData instance) => <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'gender': instance.gender,
      'nickName': instance.nickName,
      'language': instance.language,
    };
