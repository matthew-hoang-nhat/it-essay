// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'seller_meta_data.g.dart';

@JsonSerializable()
class SellerMetaData {
  @JsonKey(name: 'totalSold')
  int totalSold;
  @JsonKey(name: 'totalProduct')
  int totalProduct;
  @JsonKey(name: 'totalEvaluation')
  int totalEvaluation;
  @JsonKey(name: 'ranking')
  int ranking;
  SellerMetaData({
    required this.totalSold,
    required this.totalProduct,
    required this.totalEvaluation,
    required this.ranking,
  });

  factory SellerMetaData.fromJson(Map<String, dynamic> json) =>
      _$SellerMetaDataFromJson(json);

  Map<String, dynamic> toJson() => _$SellerMetaDataToJson(this);
}
