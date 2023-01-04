import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:it_project/main.dart';
import 'package:it_project/src/features/app/fuser_local.dart';
import 'package:it_project/src/features/profile/screens/detail_profile_screen.dart';
import 'package:it_project/src/local/dao/fuser_local_dao.dart';
import 'package:it_project/src/utils/helpers/validate.dart';
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

class DetailProfileCubit extends Cubit<DetailProfileState> {
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
            isAllValidated: true,
            firstNameAnnouncement: '',
            lastNameAnnouncement: '',
            phoneNumberAnnouncement: ''));

  final ProfileRepository _profileRepository = getIt<ProfileRepositoryImpl>();
  final UpFileRepository _upFileRepository = getIt<UpFileRepositoryImpl>();
  final FUserLocal _fUserLocal = getIt<FUserLocal>();
  late final emailEditingController = TextEditingController(text: state.email);
  late final firstNameEditingController =
      TextEditingController(text: state.firstName);
  late final lastNameEditingController =
      TextEditingController(text: state.lastName);
  late final phoneNumberController =
      TextEditingController(text: state.phoneNumber);

  initCubit() {
    final fUser = _fUserLocal.fUser!;
    emit(state.copyWith(
      gender: fUser.gender,
      avatar: fUser.avatar,
      dateTime: fUser.birthDay,
      email: fUser.email,
      firstName: fUser.firstName,
      lastName: fUser.lastName,
      phoneNumber: fUser.phoneNumber,
    ));
  }

  setNewAvatar(XFile? file) {
    emit(state.copyWith(newAvatar: file));
  }

  setFirstName(String value) {
    emit(state.copyWith(firstName: value));
  }

  setLastName(String value) {
    emit(state.copyWith(lastName: value));
  }

  setPhoneNumber(String value) {
    emit(state.copyWith(phoneNumber: value));
  }

  setGender(String genderValue) {
    emit(state.copyWith(gender: genderValue));
  }

  setDateTime(String? dateTime) {
    emit(state.copyWith(dateTime: dateTime));
  }

  checkTextFieldValidate(value, {required EditFieldProfileEnum type}) {
    const nameValidatedAnnouncement = 'Tên không hợp lệ';
    const phoneNumberValidatedAnnouncement = 'Số điện thoại bao gồm 10 số';
    bool isAllValidated = true;
    switch (type) {
      case EditFieldProfileEnum.firstName:
        if (Validate().isInvalidName(value)) {
          emit(
              state.copyWith(firstNameAnnouncement: nameValidatedAnnouncement));
          isAllValidated = false;
          break;
        }
        emit(state.copyWith(firstNameAnnouncement: ''));
        break;

      case EditFieldProfileEnum.lastName:
        if (Validate().isInvalidName(value)) {
          emit(state.copyWith(lastNameAnnouncement: nameValidatedAnnouncement));
          isAllValidated = false;
          break;
        }
        emit(state.copyWith(lastNameAnnouncement: ''));
        break;

      case EditFieldProfileEnum.phoneNumber:
        if (Validate().isInvalidPhoneNumber(value)) {
          emit(state.copyWith(
              phoneNumberAnnouncement: phoneNumberValidatedAnnouncement));
          isAllValidated = false;
          break;
        }
        emit(state.copyWith(phoneNumberAnnouncement: ''));
        break;
      default:
    }
    emit(state.copyWith(isAllValidated: isAllValidated));
  }

  Future<void> updateProfileClick() async {
    String? avatarUrl;

    emit(state.copyWith(isLoading: true));
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
    emit(state.copyWith(isLoading: false));
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

  // @override
  // void addNewEvent(DetailProfileEnum key, value) {
  //   if (isClosed) {
  //     return;
  //   }
  //   switch (key) {
  //     case DetailProfileEnum.isLoading:
  //       emit(
  //           NewDetailProfileState.fromOldSettingState(state, isLoading: value));
  //       break;
  //     case DetailProfileEnum.email:
  //       emit(NewDetailProfileState.fromOldSettingState(state, email: value));
  //       break;
  //     case DetailProfileEnum.firstName:
  //       emit(
  //           NewDetailProfileState.fromOldSettingState(state, firstName: value));
  //       break;
  //     case DetailProfileEnum.lastName:
  //       emit(NewDetailProfileState.fromOldSettingState(state, lastName: value));
  //       print(state.lastName);
  //       break;
  //     case DetailProfileEnum.phoneNumber:
  //       emit(NewDetailProfileState.fromOldSettingState(state,
  //           phoneNumber: value));
  //       break;
  //     case DetailProfileEnum.dateTime:
  //       emit(NewDetailProfileState.fromOldSettingState(state, dateTime: value));
  //       break;
  //     case DetailProfileEnum.gender:
  //       emit(NewDetailProfileState.fromOldSettingState(state, gender: value));
  //       break;
  //     case DetailProfileEnum.newAvatar:
  //       emit(
  //           NewDetailProfileState.fromOldSettingState(state, newAvatar: value));
  //       break;
  //   }
  // }
}
