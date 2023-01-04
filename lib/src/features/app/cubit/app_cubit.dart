import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:it_project/main.dart';
import 'package:it_project/src/features/app/fcart_local.dart';
import 'package:it_project/src/features/app/fuser_local.dart';
import 'package:it_project/src/features/shopping_cart/mixin/action_cart.dart';
import 'package:it_project/src/local/dao/fuser_local_dao.dart';
import 'package:it_project/src/services/socket_manager.dart';
import 'package:it_project/src/utils/remote/model/order/get/address.dart';
import 'package:it_project/src/utils/repository/profile_respository.dart';
import 'package:it_project/src/utils/repository/profile_respository_impl.dart';

part 'app_state.dart';

enum AppCubitEnum { fUser, itemCartQuantity, address }

class AppCubit extends Cubit<AppState> with ActionCart {
  AppCubit()
      : super(AppInitial(
            fUser: getIt<FUserLocal>().fUser,
            itemCartQuantity: getIt<FCartLocal>().itemCarts.length,
            address: null));
  final ProfileRepository _profileRepo = getIt<ProfileRepositoryImpl>();

  final _fUserLocal = getIt<FUserLocal>();
  final _fCartLocal = getIt<FCartLocal>();

  bool get isLogged => _fUserLocal.isLogged;

  bool isLoadingProfileUser = false;

  addAddress(Address address) {
    emit(state.copyWith(address: address));
  }

  initCubit() async {
    if (_fUserLocal.isLogged) {
      fetchFUser();
      getIt<SocketManager>().connect();
      await fetchItemCartsServerMixin();
    }

    reGetItemCartQuantity();
  }

  _loadItemCartsServer() async {
    await updateItemCartsMixin(
        itemCarts: FCartLocal().itemCarts, type: ActionCartTypeEnum.server);
    await fetchItemCartsServerMixin();
    reGetItemCartQuantity();
  }

  reGetItemCartQuantity() {
    final itemCartQuantity = _fCartLocal.itemCarts.length;
    emit(state.copyWith(itemCartQuantity: itemCartQuantity));
  }

  logOut() {
    getIt<SocketManager>().disconnect();
    _fUserLocal.logOut();
    _fCartLocal.itemCarts = [];
    emit(state.copyWith(itemCartQuantity: 0));
  }

  fetchUserAndLoadItemCartsServer() async {
    await fetchFUser();
    await _loadItemCartsServer();
  }

  fetchFUser() async {
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

        emit(state.copyWith(fUser: newProfileUser));
      }
    }

    isLoadingProfileUser = false;
  }

  // @override
  // void addNewEvent(AppCubitEnum key, value) {
  //   if (isClosed) return;
  //   switch (key) {
  //     case AppCubitEnum.fUser:
  //       _fUserLocal.fUser = value;
  //       emit(state.copyWith(fUser: value));
  //       // NewAppState.fromOldSettingState(state, fUser: value));
  //       break;
  //     case AppCubitEnum.itemCartQuantity:
  //       emit(NewAppState.fromOldSettingState(state, itemCartQuantity: value));
  //       break;
  //     case AppCubitEnum.address:
  //       emit(NewAppState.fromOldSettingState(state, address: value));
  //       break;
  //     default:
  //   }
  // }
}
