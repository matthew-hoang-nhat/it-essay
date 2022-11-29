import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable()
class Address {
  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'phoneNumber')
  String phoneNumber;

  @JsonKey(name: 'address')
  String address;

  @JsonKey(name: 'zipCode')
  int zipCode;
  @JsonKey(name: 'code')
  int code;

  @JsonKey(name: '_id')
  String? id;

  Address({
    required this.name,
    this.code = 1,
    required this.zipCode,
    required this.phoneNumber,
    required this.address,
    this.id,
  });

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
