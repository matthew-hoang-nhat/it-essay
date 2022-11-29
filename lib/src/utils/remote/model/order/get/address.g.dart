// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      name: json['name'] as String,
      code: json['code'] as int? ?? 1,
      zipCode: json['zipCode'] as int,
      phoneNumber: json['phoneNumber'] as String,
      address: json['address'] as String,
      id: json['_id'] as String?,
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'address': instance.address,
      'zipCode': instance.zipCode,
      'code': instance.code,
      '_id': instance.id,
    };
