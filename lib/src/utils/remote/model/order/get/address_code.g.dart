// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_code.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressCode _$AddressCodeFromJson(Map<String, dynamic> json) => AddressCode(
      district: json['district'] as int,
      provinceId: json['province'] as int,
      street: json['street'] as String?,
      wardId: json['ward'] as int,
    );

Map<String, dynamic> _$AddressCodeToJson(AddressCode instance) =>
    <String, dynamic>{
      'district': instance.district,
      'province': instance.provinceId,
      'street': instance.street,
      'ward': instance.wardId,
    };
