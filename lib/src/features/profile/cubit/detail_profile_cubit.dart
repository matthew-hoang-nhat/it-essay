import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:it_project/main.dart';
import 'package:it_project/src/features/app/fuser_local.dart';
import 'package:it_project/src/features/login_register/cubit/parent_cubit.dart';
import 'package:it_project/src/local/dao/fuser_local_dao.dart';
import 'package:it_project/src/utils/remote/model/user/update_profile_user_data.dart';
import 'package:it_project/src/utils/repository/profile_respository.dart';
import 'package:it_project/src/utils/repository/profile_respository_impl.dart';
import 'package:it_project/src/utils/repository/up_file_repository.dart';
import 'package:it_project/src/utils/repository/up_file_repository_impl.dart';

part 'detail_profile_state.dart';

enum DetailProfileEnum {
  isLoading,
  email,
  firstName,
  lastName,
  phoneNumber,
  dateTime,
  gender,
  newAvatar
}

class DetailProfileCubit extends Cubit<DetailProfileState>
    implements ParentCubit<DetailProfileEnum> {
  DetailProfileCubit()
      : super(const DetailProfileInitial(
          isLoading: false,
          avatar: '',
          dateTime: '',
          email: '',
          gender: '',
          firstName: '',
          lastName: '',
          newAvatar: null,
          phoneNumber: '',
        ));

  final ProfileRepository _profileRepository = getIt<ProfileRepositoryImpl>();
  final UpFileRepository _upFileRepository = getIt<UpFileRepositoryImpl>();
  final FUserLocal _fUserLocal = getIt<FUserLocal>();

  initCubit() {
    final fUser = _fUserLocal.fUser!;
    emit(NewDetailProfileState.fromOldSettingState(
      state,
      gender: fUser.gender,
      avatar: fUser.avatar,
      dateTime: fUser.birthDay,
      email: fUser.email,
      firstName: fUser.firstName,
      lastName: fUser.lastName,
      phoneNumber: fUser.phoneNumber,
    ));
  }

  Future<void> updateProfileClick() async {
    String? avatarUrl;
    addNewEvent(DetailProfileEnum.isLoading, true);

    if (state.newAvatar != null) {
      avatarUrl = await _callApiUploadImage(state.newAvatar!);
    }

    await _callAPiUpdateProfile(
        birthDay: state.dateTime,
        gender: state.gender,
        firstName: state.firstName,
        lastName: state.lastName,
        phone: state.phoneNumber,
        avatar: avatarUrl);

    addNewEvent(DetailProfileEnum.isLoading, false);
  }

  Future<String?> _callApiUploadImage(XFile file) async {
    final response = await _upFileRepository.uploadFile(file);

    if (response.isSuccess) return response.data as String;
    return null;
  }

  Future _callAPiUpdateProfile({
    String? avatar,
    String? address,
    String? birthDay,
    String? firstName,
    String? lastName,
    String? gender,
    String? phone,
  }) async {
    final FUserLocalDao oldProfileUser = getIt<FUserLocal>().fUser!;

    await _profileRepository.updateProfileUser(
        newProfileUserData: UpdateProfileUserData(
      address: address ?? oldProfileUser.address,
      avatar: avatar ?? oldProfileUser.avatar,
      birthDay: birthDay ?? oldProfileUser.birthDay,
      gender: gender ?? oldProfileUser.gender,
      firstName: firstName ?? oldProfileUser.firstName,
      lastName: lastName ?? oldProfileUser.lastName,
      phone: phone ?? oldProfileUser.phoneNumber,
    ));
  }

  @override
  void addNewEvent(DetailProfileEnum key, value) {
    if (isClosed) {
      return;
    }
    switch (key) {
      case DetailProfileEnum.isLoading:
        emit(
            NewDetailProfileState.fromOldSettingState(state, isLoading: value));
        break;
      case DetailProfileEnum.email:
        emit(NewDetailProfileState.fromOldSettingState(state, email: value));
        break;
      case DetailProfileEnum.firstName:
        emit(
            NewDetailProfileState.fromOldSettingState(state, firstName: value));
        break;
      case DetailProfileEnum.lastName:
        emit(NewDetailProfileState.fromOldSettingState(state, lastName: value));
        print(state.lastName);
        break;
      case DetailProfileEnum.phoneNumber:
        emit(NewDetailProfileState.fromOldSettingState(state,
            phoneNumber: value));
        break;
      case DetailProfileEnum.dateTime:
        emit(NewDetailProfileState.fromOldSettingState(state, dateTime: value));
        break;
      case DetailProfileEnum.gender:
        emit(NewDetailProfileState.fromOldSettingState(state, gender: value));
        break;
      case DetailProfileEnum.newAvatar:
        emit(
            NewDetailProfileState.fromOldSettingState(state, newAvatar: value));
        break;
    }
  }
}
