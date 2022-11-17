// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:it_project/src/features/login_register/cubit/parent_cubit.dart';

// part 'detail_profile_state.dart';

// enum DetailProfileEnum { profileUser }

// class DetailProfileCubit extends Cubit<DetailProfileState>
//     implements ParentCubit<DetailProfileEnum> {
//   DetailProfileCubit()
//       : super(const DetailProfileInitial(
//           profileUser: null,
//         ));

//   // final ProfileRepository profileRepository = getIt<ProfileRepositoryImpl>();
//   bool isLoadingProfileUser = false;

//   getProfileUser() async {
//     isLoadingProfileUser = true;
//     final response = await profileRepository.getProfileUser();
//     if (response.isSuccess) {
//       addNewEvent(DetailProfileEnum.profileUser, response.data);
//     }
//     isLoadingProfileUser = false;
//   }

//   @override
//   void addNewEvent(DetailProfileEnum key, value) {
//     if (isClosed) {
//       return;
//     }
//     switch (key) {
//       case DetailProfileEnum.profileUser:
//         emit(NewDetailProfileState.fromOldSettingState(state,
//             profileUser: value));
//         break;
//     }
//   }
// }
