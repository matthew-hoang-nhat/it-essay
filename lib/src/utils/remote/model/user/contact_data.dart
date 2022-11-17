import 'package:json_annotation/json_annotation.dart';

part 'contact_data.g.dart';

@JsonSerializable()
class ContactData {
  @JsonKey(name: 'phone')
  String phone;

  ContactData({
    required this.phone,
  });

  factory ContactData.fromJson(Map<String, dynamic> json) =>
      _$ContactDataFromJson(json);

  Map<String, dynamic> toJson() => _$ContactDataToJson(this);
}
