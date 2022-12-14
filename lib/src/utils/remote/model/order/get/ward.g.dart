// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ward.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ward _$WardFromJson(Map<String, dynamic> json) => Ward(
      name: json['name'] as String,
      code: json['code'] as int,
      street: json['street'] as String?,
    );

Map<String, dynamic> _$WardToJson(Ward instance) => <String, dynamic>{
      'name': instance.name,
      'code': instance.code,
      'street': instance.street,
    };
