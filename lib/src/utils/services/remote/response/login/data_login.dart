import 'package:json_annotation/json_annotation.dart';
part 'data_login.g.dart';

@JsonSerializable()
class DataLogin {
  @JsonKey(name: '_id')
  String? id;
  @JsonKey(name: 'nickName')
  String? nickName;
  @JsonKey(name: 'role')
  String? role;
  @JsonKey(name: 'meta')
  String? meta;
  @JsonKey(name: 'typeLogin')
  String? typeLogin;

  DataLogin({
    this.id,
    this.meta,
    this.nickName,
    this.role,
    this.typeLogin,
  });

  factory DataLogin.fromJson(Map<String, dynamic> json) =>
      _$DataLoginFromJson(json);

  Map<String, dynamic> toJson() => _$DataLoginToJson(this);
}
