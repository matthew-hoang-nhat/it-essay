// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:json_annotation/json_annotation.dart';

// part 'update_profile_user_data.g.dart';

// @JsonSerializable()
// class UpdateProfileUserData {
//   @JsonKey(name: 'address')
//   String? address;
//   @JsonKey(name: 'phone')
//   String? phone;
//   @JsonKey(name: 'firstName')
//   String? firstName;
//   @JsonKey(name: 'lastName')
//   String? lastName;
//   @JsonKey(name: 'avatar')
//   String? avatar;
//   @JsonKey(name: 'language')
//   String language;
//   @JsonKey(name: 'birthDay')
//   String? birthDay;
//   @JsonKey(name: 'gender')
//   String? gender;

//   UpdateProfileUserData(
//       {this.address,
//       this.phone,
//       this.firstName,
//       this.lastName,
//       this.avatar,
//       this.language = 'vi',
//       this.birthDay,
//       this.gender});

//   factory UpdateProfileUserData.fromJson(Map<String, dynamic> json) =>
//       _$UpdateProfileUserDataFromJson(json);

//   Map<String, dynamic> toJson() => _$UpdateProfileUserDataToJson(this);

//   UpdateProfileUserData copyWith({
//     String? address,
//     String? phone,
//     String? firstName,
//     String? lastName,
//     String? avatar,
//     String? language,
//     String? birthDay,
//     String? gender,
//   }) {
//     return UpdateProfileUserData(
//       address: address ?? this.address,
//       phone: phone ?? this.phone,
//       firstName: firstName ?? this.firstName,
//       lastName: lastName ?? this.lastName,
//       avatar: avatar ?? this.avatar,
//       language: language ?? this.language,
//       birthDay: birthDay ?? this.birthDay,
//       gender: gender ?? this.gender,
//     );
//   }
// }
