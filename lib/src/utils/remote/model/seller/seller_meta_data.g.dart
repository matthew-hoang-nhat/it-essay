// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seller_meta_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SellerMetaData _$SellerMetaDataFromJson(Map<String, dynamic> json) =>
    SellerMetaData(
      totalSold: json['totalSold'] as int,
      totalProduct: json['totalProduct'] as int,
      totalEvaluation: json['totalEvaluation'] as int,
      ranking: json['ranking'] as int,
    );

Map<String, dynamic> _$SellerMetaDataToJson(SellerMetaData instance) =>
    <String, dynamic>{
      'totalSold': instance.totalSold,
      'totalProduct': instance.totalProduct,
      'totalEvaluation': instance.totalEvaluation,
      'ranking': instance.ranking,
    };
