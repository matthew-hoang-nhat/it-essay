import 'package:it_project/src/utils/remote/model/user/update_profile_user_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_profile_user_request.g.dart';

@JsonSerializable()
class UpdateProfileUserRequest {
  @JsonKey(name: 'profile')
  UpdateProfileUserData? profile;

  UpdateProfileUserRequest({
    this.profile,
  });

  factory UpdateProfileUserRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileUserRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateProfileUserRequestToJson(this);
}
