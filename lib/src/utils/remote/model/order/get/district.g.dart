// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'district.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

District _$DistrictFromJson(Map<String, dynamic> json) => District(
      name: json['name'] as String,
      code: json['code'] as int,
      wards: (json['wards'] as List<dynamic>)
          .map((e) => Ward.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DistrictToJson(District instance) => <String, dynamic>{
      'name': instance.name,
      'code': instance.code,
      'wards': instance.wards,
    };
