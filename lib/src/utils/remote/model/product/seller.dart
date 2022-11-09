import 'package:it_project/src/utils/remote/model/product/info_data.dart';
import 'package:it_project/src/utils/remote/model/product/logo_data.dart';

import 'package:json_annotation/json_annotation.dart';

part 'seller.g.dart';

@JsonSerializable()
class Seller {
  @JsonKey(name: 'info')
  InfoData infoData;
  @JsonKey(name: 'logo')
  LogoData logoData;
  @JsonKey(name: 'userId')
  String userId;

  Seller({
    required this.infoData,
    required this.logoData,
    required this.userId,
  });

  factory Seller.fromJson(Map<String, dynamic> json) => _$SellerFromJson(json);

  Map<String, dynamic> toJson() => _$SellerToJson(this);
}
