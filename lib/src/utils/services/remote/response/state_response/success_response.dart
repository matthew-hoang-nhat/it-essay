import 'package:json_annotation/json_annotation.dart';

import 'data_success.dart';
part 'success_response.g.dart';

@JsonSerializable()
class SuccessResponse {
  // @JsonKey(name: 'status')
  // int status;
  @JsonKey(name: 'data')
  DataSuccess data;

  SuccessResponse({required this.data});

  factory SuccessResponse.fromJson(Map<String, dynamic> json) =>
      _$SuccessResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SuccessResponseToJson(this);
}
