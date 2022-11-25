// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_seller.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileSeller _$ProfileSellerFromJson(Map<String, dynamic> json) =>
    ProfileSeller(
      id: json['_id'] as String,
      info: SellerInfoData.fromJson(json['info'] as Map<String, dynamic>),
      logo: json['logo'] == null
          ? null
          : SellerLogoData.fromJson(json['logo'] as Map<String, dynamic>),
      slogan: json['slogan'] as String?,
      meta: json['meta'] == null
          ? null
          : SellerMetaData.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProfileSellerToJson(ProfileSeller instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'info': instance.info,
      'logo': instance.logo,
      'slogan': instance.slogan,
      'meta': instance.meta,
    };
