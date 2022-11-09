import 'package:json_annotation/json_annotation.dart';
part 'info_data.g.dart';

@JsonSerializable()
class InfoData {
  @JsonKey(name: 'name')
  String name;

  InfoData({required this.name});

  factory InfoData.fromJson(Map<String, dynamic> json) =>
      _$InfoDataFromJson(json);

  Map<String, dynamic> toJson() => _$InfoDataToJson(this);
}
