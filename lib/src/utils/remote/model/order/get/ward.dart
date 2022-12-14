// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'ward.g.dart';

@JsonSerializable()
class Ward {
  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'code')
  int code;

  @JsonKey(name: 'street')
  String? street;

  Ward({
    required this.name,
    required this.code,
    this.street,
  });

  factory Ward.fromJson(Map<String, dynamic> json) => _$WardFromJson(json);

  Map<String, dynamic> toJson() => _$WardToJson(this);

  Ward copyWith({
    String? name,
    int? code,
    String? street,
  }) {
    return Ward(
      name: name ?? this.name,
      code: code ?? this.code,
      street: street ?? this.street,
    );
  }
}
