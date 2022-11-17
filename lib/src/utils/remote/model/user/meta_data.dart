// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'meta_data.g.dart';

@JsonSerializable()
class MetaData {
  @JsonKey(name: 'totalBuy')
  int? totalBuy;
  @JsonKey(name: 'email')
  int? totalCancel;
  MetaData({
    this.totalBuy,
    this.totalCancel,
  });

  factory MetaData.fromJson(Map<String, dynamic> json) =>
      _$MetaDataFromJson(json);

  Map<String, dynamic> toJson() => _$MetaDataToJson(this);
}
