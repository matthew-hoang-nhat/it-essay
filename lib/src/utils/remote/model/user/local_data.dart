import 'package:json_annotation/json_annotation.dart';

part 'local_data.g.dart';

@JsonSerializable()
class LocalData {
  @JsonKey(name: 'email')
  String email;

  LocalData({
    required this.email,
  });

  factory LocalData.fromJson(Map<String, dynamic> json) =>
      _$LocalDataFromJson(json);

  Map<String, dynamic> toJson() => _$LocalDataToJson(this);
}
