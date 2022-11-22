import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:it_project/main.dart';
import 'package:it_project/src/features/app/fuser_local.dart';
import 'package:it_project/src/features/login_register/cubit/parent_cubit.dart';
import 'package:it_project/src/local/dao/fuser_local_dao.dart';
import 'package:it_project/src/utils/remote/model/user/update_profile_user_data.dart';
import 'package:it_project/src/utils/repository/profile_respository.dart';
import 'package:it_project/src/utils/repository/profile_respository_impl.dart';

part 'edit_profile_state.dart';

enum EditProfileEnum { isLoading }

class EditProfileCubit extends Cubit<EditProfileState>
    implements ParentCubit<EditProfileEnum> {
  EditProfileCubit() : super(const EditProfileInitial(isLoading: false));
  final ProfileRepository profileRepository = getIt<ProfileRepositoryImpl>();

  final fUserLocal = getIt<FUserLocal>();

  Future<bool> updateProfile({
    String? avatar,
    String? address,
    String? birthDay,
    String? name,
    String? gender,
    String? phone,
  }) async {
    addNewEvent(EditProfileEnum.isLoading, true);
    final FUserLocalDao oldProfileUser = getIt<FUserLocal>().fUser!;
    final response = await profileRepository.updateProfileUser(
        newProfileUserData: UpdateProfileUserData(
      address: address ?? oldProfileUser.address,
      avatar: avatar ?? oldProfileUser.avatar,
      birthDay: birthDay ?? "12/11/2001",
      gender: "male",
      firstName: name ?? oldProfileUser.name,
      lastName: " ",
      phone: phone ?? oldProfileUser.phoneNumber,
    ));

    if (response.isSuccess) {
      final FUserLocalDao newProfileUser = fUserLocal.fUser!.copyWith(
        address: address ?? oldProfileUser.address,
        avatar: avatar ?? oldProfileUser.avatar,
        birthDay: birthDay ?? oldProfileUser.birthDay,
        gender: gender ?? oldProfileUser.gender,
        name: name ?? oldProfileUser.name,
        phoneNumber: phone ?? oldProfileUser.phoneNumber,
      );
      fUserLocal.fUser = newProfileUser;
      return true;
    }

    addNewEvent(EditProfileEnum.isLoading, false);
    return false;
  }

  @override
  void addNewEvent(EditProfileEnum key, value) {
    if (isClosed) {
      return;
    }
    switch (key) {
      case EditProfileEnum.isLoading:
        emit(NewEditProfileState.fromOldSettingState(state, isLoading: value));
        break;
    }
  }
}
