// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'district.dart';

part 'province.g.dart';

@JsonSerializable()
class Province {
  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'code')
  int code;

  @JsonKey(name: 'districts')
  List<District> districts;

  Province({
    required this.name,
    required this.code,
    required this.districts,
  });

  factory Province.fromJson(Map<String, dynamic> json) =>
      _$ProvinceFromJson(json);

  Map<String, dynamic> toJson() => _$ProvinceToJson(this);

  Province copyWith({
    String? name,
    int? code,
    List<District>? districts,
  }) {
    return Province(
      name: name ?? this.name,
      code: code ?? this.code,
      districts: districts ?? this.districts,
    );
  }
}
