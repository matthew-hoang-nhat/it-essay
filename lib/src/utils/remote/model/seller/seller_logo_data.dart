import 'package:json_annotation/json_annotation.dart';

part 'seller_logo_data.g.dart';

@JsonSerializable()
class SellerLogoData {
  @JsonKey(name: 'fileLink')
  String fileLink;

  SellerLogoData({
    required this.fileLink,
  });

  factory SellerLogoData.fromJson(Map<String, dynamic> json) =>
      _$SellerLogoDataFromJson(json);

  Map<String, dynamic> toJson() => _$SellerLogoDataToJson(this);
}
