// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seller_info_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SellerInfoData _$SellerInfoDataFromJson(Map<String, dynamic> json) =>
    SellerInfoData(
      name: json['name'] as String,
      phone: json['phone'] as String,
      addresses: json['address'] as List<dynamic>,
    );

Map<String, dynamic> _$SellerInfoDataToJson(SellerInfoData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'phone': instance.phone,
      'address': instance.addresses,
    };
