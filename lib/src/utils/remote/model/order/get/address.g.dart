// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      addressCode: json['addressCode'] == null
          ? null
          : AddressCode.fromJson(json['addressCode'] as Map<String, dynamic>),
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
      address: json['address'] as String,
      zipCode: json['zipCode'] as int? ?? 6300,
      code: json['code'] as int? ?? 1,
      isDefault: json['isDefault'] as bool? ?? false,
      id: json['_id'] as String?,
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'address': instance.address,
      'zipCode': instance.zipCode,
      'code': instance.code,
      'isDefault': instance.isDefault,
      '_id': instance.id,
      'addressCode': instance.addressCode,
    };
