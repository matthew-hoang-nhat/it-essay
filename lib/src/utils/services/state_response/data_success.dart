import 'package:json_annotation/json_annotation.dart';
part 'data_success.g.dart';

@JsonSerializable()
class DataSuccess {
  @JsonKey(name: 'message')
  String? message;

  DataSuccess({this.message});

  factory DataSuccess.fromJson(Map<String, dynamic> json) =>
      _$DataSuccessFromJson(json);

  Map<String, dynamic> toJson() => _$DataSuccessToJson(this);
}
