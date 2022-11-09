import 'package:json_annotation/json_annotation.dart';
part 'logo_data.g.dart';

@JsonSerializable()
class LogoData {
  @JsonKey(name: 'fileLink')
  String fileLink;

  LogoData({required this.fileLink});

  factory LogoData.fromJson(Map<String, dynamic> json) =>
      _$LogoDataFromJson(json);

  Map<String, dynamic> toJson() => _$LogoDataToJson(this);
}
