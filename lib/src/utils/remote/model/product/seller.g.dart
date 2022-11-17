// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seller.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Seller _$SellerFromJson(Map<String, dynamic> json) => Seller(
      infoData: InfoData.fromJson(json['info'] as Map<String, dynamic>),
      logoData: json['logo'] == null
          ? null
          : LogoData.fromJson(json['logo'] as Map<String, dynamic>),
      userId: json['userId'] as String?,
    );

Map<String, dynamic> _$SellerToJson(Seller instance) => <String, dynamic>{
      'info': instance.infoData,
      'logo': instance.logoData,
      'userId': instance.userId,
    };
