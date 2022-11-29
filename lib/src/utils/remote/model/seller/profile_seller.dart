// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'package:it_project/src/utils/remote/model/seller/seller_info_data.dart';
import 'package:it_project/src/utils/remote/model/seller/seller_logo_data.dart';
import 'package:it_project/src/utils/remote/model/seller/seller_meta_data.dart';

part 'profile_seller.g.dart';

@JsonSerializable()
class ProfileSeller {
  @JsonKey(name: '_id')
  String id;
  @JsonKey(name: 'info')
  SellerInfoData info;
  @JsonKey(name: 'logo')
  SellerLogoData? logo;
  @JsonKey(name: 'slogan')
  String? slogan;
  @JsonKey(name: 'meta')
  SellerMetaData? meta;

  ProfileSeller({
    required this.id,
    required this.info,
    this.logo,
    this.slogan,
    this.meta,
  });

  factory ProfileSeller.fromJson(Map<String, dynamic> json) =>
      _$ProfileSellerFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileSellerToJson(this);
}
