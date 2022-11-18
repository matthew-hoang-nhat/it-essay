// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import '../product/info_data.dart';
import 'contact_data.dart';
import 'local_data.dart';
import 'meta_data.dart';

part 'profile_user.g.dart';

@JsonSerializable()
class ProfileUser {
  @JsonKey(name: 'contact')
  ContactData contact;
  @JsonKey(name: 'local')
  LocalData local;
  @JsonKey(name: 'info')
  InfoData info;
  @JsonKey(name: 'role')
  String role;
  @JsonKey(name: 'meta')
  MetaData meta;
  ProfileUser({
    required this.contact,
    required this.local,
    required this.info,
    required this.role,
    required this.meta,
  });

  factory ProfileUser.fromJson(Map<String, dynamic> json) =>
      _$ProfileUserFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileUserToJson(this);
}
