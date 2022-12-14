// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'address_code.g.dart';

@JsonSerializable()
class AddressCode {
  @JsonKey(name: 'district')
  int district;

  @JsonKey(name: 'province')
  int provinceId;

  @JsonKey(name: 'street')
  String? street;

  @JsonKey(name: 'ward')
  int wardId;
  AddressCode({
    required this.district,
    required this.provinceId,
    required this.street,
    required this.wardId,
  });

  factory AddressCode.fromJson(Map<String, dynamic> json) =>
      _$AddressCodeFromJson(json);

  Map<String, dynamic> toJson() => _$AddressCodeToJson(this);
}
