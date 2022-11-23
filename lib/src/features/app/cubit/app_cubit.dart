import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:it_project/main.dart';
import 'package:it_project/src/features/app/fcart_local.dart';
import 'package:it_project/src/features/app/fuser_local.dart';
import 'package:it_project/src/features/login_register/cubit/parent_cubit.dart';
import 'package:it_project/src/local/dao/fuser_local_dao.dart';
import 'package:it_project/src/utils/repository/profile_respository.dart';
import 'package:it_project/src/utils/repository/profile_respository_impl.dart';

part 'app_state.dart';

enum AppCubitEnum { fUser, itemCartQuantity }

class AppCubit extends Cubit<AppState> implements ParentCubit<AppCubitEnum> {
  AppCubit()
      : super(AppInitial(
          fUser: getIt<FUserLocal>().fUser,
          itemCartQuantity: getIt<FCartLocal>().itemCarts.length,
        ));

  final ProfileRepository _profileRepo = getIt<ProfileRepositoryImpl>();

  final _fUserLocal = getIt<FUserLocal>();
  final _fCartLocal = getIt<FCartLocal>();

  bool get isLogged => _fUserLocal.isLogged;

  bool isLoadingProfileUser = false;

  initCubit() {
    if (_fUserLocal.isLogged) {
      fetchFUser();
    }
  }

  reGetItemCartQuantity() {
    addNewEvent(AppCubitEnum.itemCartQuantity, _fCartLocal.itemCarts.length);
  }

  logOut() {
    _fUserLocal.logOut();
    _fCartLocal.itemCarts = [];

    addNewEvent(AppCubitEnum.itemCartQuantity, 0);
  }

  Future<void> fetchFUser() async {
    isLoadingProfileUser = true;
    final response = await _profileRepo.getProfileUser();
    if (response.isSuccess) {
      final profileUser = response.data;
      if (response.isSuccess) {
        final FUserLocalDao newProfileUser;
        if (_fUserLocal.fUser != null) {
          newProfileUser = _fUserLocal.fUser!.copyWith(
              firstName: profileUser?.info.firstName,
              lastName: profileUser?.info.lastName,
              phoneNumber: profileUser?.contact.phone,
              email: profileUser?.local.email,
              avatar: profileUser?.info.avatar,
              gender: profileUser?.info.gender,
              birthDay: profileUser?.info.birthDay);
        } else {
          newProfileUser = FUserLocalDao(
              firstName: profileUser?.info.firstName,
              lastName: profileUser?.info.lastName,
              phoneNumber: profileUser?.contact.phone,
              email: profileUser?.local.email,
              avatar: profileUser?.info.avatar,
              birthDay: profileUser?.info.birthDay,
              gender: profileUser?.info.gender ?? 'male');
        }
        _fUserLocal.fUser = newProfileUser;
        addNewEvent(AppCubitEnum.fUser, newProfileUser);
      }
    }

    isLoadingProfileUser = false;
  }

  @override
  void addNewEvent(AppCubitEnum key, value) {
    if (isClosed) return;
    switch (key) {
      case AppCubitEnum.fUser:
        _fUserLocal.fUser = value;
        emit(NewAppState.fromOldSettingState(state, fUser: value));
        break;
      case AppCubitEnum.itemCartQuantity:
        emit(NewAppState.fromOldSettingState(state, itemCartQuantity: value));
        break;
      default:
    }
  }
}
