// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'package:it_project/src/utils/remote/model/order/get/address_code.dart';

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

  @JsonKey(name: 'isDefault')
  bool isDefault;

  @JsonKey(name: '_id')
  String? id;

  @JsonKey(name: 'addressCode')
  AddressCode? addressCode;

  Address({
    required this.addressCode,
    required this.name,
    required this.phoneNumber,
    required this.address,
    this.zipCode = 6300,
    this.code = 1,
    this.isDefault = false,
    this.id,
  });

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
