// import 'dart:developer';

// import 'package:dio/dio.dart';
// import 'package:it_project/src/utils/remote/model/user/update_profile_user_data.dart';
// import 'package:it_project/src/utils/remote/model/user/update_profile_user_request.dart';
// import 'package:it_project/src/utils/remote/services/fresult.dart';
// import 'package:it_project/src/utils/remote/model/user/profile_user.dart';
// import 'package:it_project/src/utils/repository/profile_respository.dart';

// class ProfileRepositoryImpl extends ProfileRepository {
//   ProfileRepositoryImpl({required super.profileService});

//   @override
//   Future<FResult<ProfileUser>> getProfileUser() async {
//     try {
//       final dataResponse = await profileService.getInfo();
//       final ProfileUser profileUser = ProfileUser.fromJson(dataResponse.data);

//       return FResult.success(profileUser);
//     } catch (ex) {
//       print(ex.toString());
//       if (ex is DioError) {
//         log('getProfileUser: ${ex.error}');
//       }
//       return FResult.error(ex.toString());
//     }
//   }

//   @override
//   Future<FResult<String>> updateProfileUser(
//       {required UpdateProfileUserData newProfileUserData}) async {
//     try {
//       await profileService.updateProfileUser(
//           UpdateProfileUserRequest(profile: newProfileUserData));
//       return FResult.success('Thành công');
//     } catch (ex) {
//       if (ex is DioError) {
//         log('updateProfileUser: ${ex.error}');
//       }
//       return FResult.error(ex.toString());
//     }
//   }
// }
