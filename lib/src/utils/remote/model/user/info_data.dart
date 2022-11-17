// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'info_data.g.dart';

@JsonSerializable()
class InfoData {
  @JsonKey(name: 'firstName')
  String firstName;
  @JsonKey(name: 'lastName')
  String lastName;
  @JsonKey(name: 'gender')
  String gender;
  @JsonKey(name: 'nickName')
  String nickName;
  @JsonKey(name: 'language')
  String language;
  InfoData({
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.nickName,
    required this.language,
  });

  

  factory InfoData.fromJson(Map<String, dynamic> json) =>
      _$InfoDataFromJson(json);

  Map<String, dynamic> toJson() => _$InfoDataToJson(this);
}
