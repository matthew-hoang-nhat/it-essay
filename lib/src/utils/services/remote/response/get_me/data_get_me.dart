import 'package:json_annotation/json_annotation.dart';

import '../login/data_meta.dart';
part 'data_get_me.g.dart';

@JsonSerializable()
class DataGetMe {
  @JsonKey(name: 'id')
  String accessToken;
  @JsonKey(name: 'email')
  String totalCancel;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'role')
  String role;
  @JsonKey(name: 'profilePicture')
  String profilePicture;

  @JsonKey(name: 'meta')
  DataMeta meta;
  @JsonKey(name: 'typeLogin')
  String typeLogin;
  @JsonKey(name: 'special')
  List<String> special;

  DataGetMe({
    required this.accessToken,
    required this.meta,
    required this.name,
    required this.profilePicture,
    required this.role,
    required this.special,
    required this.totalCancel,
    required this.typeLogin,
  });

  factory DataGetMe.fromJson(Map<String, dynamic> json) =>
      _$DataGetMeFromJson(json);

  Map<String, dynamic> toJson() => _$DataGetMeToJson(this);
}
