import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_project/main.dart';
import 'package:it_project/src/features/address/cubit/address_cubit.dart';
import 'package:it_project/src/features/app/f_cart_local.dart';
import 'package:it_project/src/features/app/f_user_local.dart';
import 'package:it_project/src/features/main/notification/cubit/notification_cubit.dart';
import 'package:it_project/src/features/shopping_cart/mixin/action_cart.dart';
import 'package:it_project/src/local/dao/f_user_local_dao.dart';
import 'package:it_project/src/services/socket_manager.dart';
import 'package:it_project/src/utils/remote/model/order/get/address.dart';
import 'package:it_project/src/utils/repository/profile_repository.dart';
import 'package:it_project/src/utils/repository/profile_repository_impl.dart';

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

  changeSelectAddress(Address address) {
    emit(state.copyWith(address: address));
  }

  afterLoginInAppCubit() {
    _fetchUserAndLoadItemCartsServer();
    initCubits();
  }

  initCubit() async {
    if (_fUserLocal.isLogged) {
      getIt<SocketManager>().connect();
      afterLoginInAppCubit();
    }

    reGetItemCartQuantity();
  }

  _loadItemCartsServer() async {
    await updateItemCartsMixin(
        itemCarts: FCartLocal().itemCarts, type: ActionCartTypeEnum.server);
    await fetchItemCartsServerMixin();
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

  initCubits() {
    final context = navigatorKey.currentContext!;
    context.read<NotificationCubit>().initCubit();
    context.read<AddressCubit>().initCubit();
  }

  _fetchUserAndLoadItemCartsServer() async {
    fetchFUser();
    _loadItemCartsServer();
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
}
