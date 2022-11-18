// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:it_project/main.dart';
// import 'package:it_project/src/features/login_register/cubit/parent_cubit.dart';
// import 'package:it_project/src/utils/remote/model/user/profile_user.dart';
// import 'package:it_project/src/utils/repository/profile_respository.dart';
// import 'package:it_project/src/utils/repository/profile_respository_impl.dart';

// part 'user_state.dart';

// enum UserEnum { profileUser }

// class UserCubit extends Cubit<UserState> implements ParentCubit<UserEnum> {
//   UserCubit()
//       : super(const UserInitial(
//           profileUser: null,
//         ));

//   final ProfileRepository profileRepository = getIt<ProfileRepositoryImpl>();
//   bool isLoadingProfileUser = false;

//   getProfileUser() async {
//     isLoadingProfileUser = true;
//     final response = await profileRepository.getProfileUser();
//     if (response.isSuccess) {
//       addNewEvent(UserEnum.profileUser, response.data);
//     }
//     isLoadingProfileUser = false;
//   }

//   @override
//   void addNewEvent(UserEnum key, value) {
//     if (isClosed) {
//       return;
//     }
//     switch (key) {
//       case UserEnum.profileUser:
//         emit(NewUserState.fromOldSettingState(state, profileUser: value));
//         break;
//     }
//   }
// }
