import 'package:json_annotation/json_annotation.dart';
part 'data_error.g.dart';

@JsonSerializable()
class DataError {
  @JsonKey(name: 'message')
  String? message;

  DataError({this.message});

  factory DataError.fromJson(Map<String, dynamic> json) =>
      _$DataErrorFromJson(json);

  Map<String, dynamic> toJson() => _$DataErrorToJson(this);
}
