// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'info_data.g.dart';

@JsonSerializable()
class InfoData {
  @JsonKey(name: 'firstName')
  String? firstName;
  @JsonKey(name: 'lastName')
  String? lastName;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'birthDay')
  String? birthDay;
  @JsonKey(name: 'gender')
  String? gender;
  @JsonKey(name: 'avatar')
  String? avatar;
  InfoData(
      {this.firstName,
      this.lastName,
      this.name,
      this.avatar,
      this.gender,
      this.birthDay});

  factory InfoData.fromJson(Map<String, dynamic> json) =>
      _$InfoDataFromJson(json);

  Map<String, dynamic> toJson() => _$InfoDataToJson(this);
}
