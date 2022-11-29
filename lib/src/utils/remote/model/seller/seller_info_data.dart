// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'seller_info_data.g.dart';

@JsonSerializable()
class SellerInfoData {
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'phone')
  String phone;
  @JsonKey(name: 'address')
  List<dynamic> addresses;
  SellerInfoData({
    required this.name,
    required this.phone,
    required this.addresses,
  });

  factory SellerInfoData.fromJson(Map<String, dynamic> json) =>
      _$SellerInfoDataFromJson(json);

  Map<String, dynamic> toJson() => _$SellerInfoDataToJson(this);
}
