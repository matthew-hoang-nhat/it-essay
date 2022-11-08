import 'package:json_annotation/json_annotation.dart';
part 'data_meta.g.dart';

@JsonSerializable()
class DataMeta {
  @JsonKey(name: 'totalBuy')
  int? totalBuy;
  @JsonKey(name: 'totalCancel')
  int? totalCancel;

  DataMeta({
    this.totalBuy,
    this.totalCancel,
  });

  factory DataMeta.fromJson(Map<String, dynamic> json) =>
      _$DataMetaFromJson(json);

  Map<String, dynamic> toJson() => _$DataMetaToJson(this);
}
