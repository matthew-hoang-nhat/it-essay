import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:it_project/main.dart';
import 'package:it_project/src/features/app/fuser_local.dart';
import 'package:it_project/src/features/login_register/cubit/parent_cubit.dart';
import 'package:it_project/src/local/dao/fuser_local_dao.dart';
import 'package:it_project/src/utils/repository/profile_respository.dart';
import 'package:it_project/src/utils/repository/profile_respository_impl.dart';

part 'profile_state.dart';

enum ProfileEnum { profileUser }

class ProfileCubit extends Cubit<ProfileState>
    implements ParentCubit<ProfileEnum> {
  final ProfileRepository profileRepository = getIt<ProfileRepositoryImpl>();
  bool isLoadingProfileUser = false;

  ProfileCubit()
      : super(ProfileInitial(profileUser: getIt<FUserLocal>().fUser!));
  final fUserLocal = getIt<FUserLocal>();

  getProfileUser() async {
    isLoadingProfileUser = true;
    final response = await profileRepository.getProfileUser();
    if (response.isSuccess) {
      final profileUser = response.data;
      if (response.isSuccess) {
        final FUserLocalDao newProfileUser = fUserLocal.fUser!.copyWith(
          name: profileUser?.info.firstName,
          phoneNumber: profileUser?.contact.phone,
          email: profileUser?.local.email,
          avatar: profileUser?.info.avatar,
        );
        fUserLocal.fUser = newProfileUser;
        addNewEvent(ProfileEnum.profileUser, newProfileUser);
      }
    }
    isLoadingProfileUser = false;
  }

  @override
  void addNewEvent(ProfileEnum key, value) {
    if (isClosed) {
      return;
    }
    switch (key) {
      case ProfileEnum.profileUser:
        emit(NewProfileState.fromOldSettingState(state, profileUser: value));
        break;
    }
  }
}
