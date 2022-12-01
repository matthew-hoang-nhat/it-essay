// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'ward.dart';

part 'district.g.dart';

@JsonSerializable()
class District {
  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'code')
  int code;

  @JsonKey(name: 'wards')
  List<Ward> wards;

  District({
    required this.name,
    required this.code,
    required this.wards,
  });

  factory District.fromJson(Map<String, dynamic> json) =>
      _$DistrictFromJson(json);

  Map<String, dynamic> toJson() => _$DistrictToJson(this);

  District copyWith({
    String? name,
    int? code,
    List<Ward>? wards,
  }) {
    return District(
      name: name ?? this.name,
      code: code ?? this.code,
      wards: wards ?? this.wards,
    );
  }
}
