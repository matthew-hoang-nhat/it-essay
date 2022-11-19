import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:it_project/main.dart';
import 'package:it_project/src/features/app/fcart_local.dart';
import 'package:it_project/src/features/app/fuser_local.dart';
import 'package:it_project/src/features/login_register/cubit/parent_cubit.dart';
import 'package:it_project/src/local/dao/fuser_local_dao.dart';
import 'package:it_project/src/utils/repository/auth_repository.dart';
import 'package:it_project/src/utils/repository/auth_repository_impl.dart';
import 'package:it_project/src/utils/repository/category_repository.dart';
import 'package:it_project/src/utils/repository/category_repository_impl.dart';
import 'package:it_project/src/utils/repository/product_repository.dart';
import 'package:it_project/src/utils/repository/product_repository_impl.dart';
import 'package:it_project/src/utils/repository/profile_respository.dart';
import 'package:it_project/src/utils/repository/profile_respository_impl.dart';
import 'package:it_project/src/utils/repository/search_repository.dart';
import 'package:it_project/src/utils/repository/search_repository_impl.dart';

part 'app_state.dart';

enum AppCubitEnum { fUser, itemCartQuantity }

class AppCubit extends Cubit<AppState> implements ParentCubit<AppCubitEnum> {
  AppCubit()
      : super(AppInitial(
          fUser: getIt<FUserLocal>().fUser,
          itemCartQuantity: getIt<FCartLocal>().itemCarts.length,
        ));

  final AuthRepository authRepo = getIt<AuthRepositoryImpl>();
  final ProfileRepository profileRepo = getIt<ProfileRepositoryImpl>();
  final SearchRepository searchRepo = getIt<SearchRepositoryImpl>();
  final ProductRepository productRepo = getIt<ProductRepositoryImpl>();
  final CategoryRepository categoryRepo = getIt<CategoryRepositoryImpl>();

  final _fUserLocal = getIt<FUserLocal>();
  final _fCartLocal = getIt<FCartLocal>();

  bool get isLogged => _fUserLocal.isLogged;

  bool isLoadingProfileUser = false;

  initCubit() {
    fetchFUser();
  }

  reGetItemCartQuantity() {
    addNewEvent(AppCubitEnum.itemCartQuantity, _fCartLocal.itemCarts.length);
  }

  Future<void> fetchFUser() async {
    isLoadingProfileUser = true;
    final response = await profileRepo.getProfileUser();
    if (response.isSuccess) {
      final profileUser = response.data;
      if (response.isSuccess) {
        if (_fUserLocal.fUser != null) {
          final FUserLocalDao newProfileUser = _fUserLocal.fUser!.copyWith(
            name: profileUser?.info.firstName,
            phoneNumber: profileUser?.contact.phone,
            email: profileUser?.local.email,
            avatar: profileUser?.info.avatar,
          );
          _fUserLocal.fUser = newProfileUser;
        } else {
          _fUserLocal.fUser = FUserLocalDao(
            name: profileUser?.info.firstName,
            phoneNumber: profileUser?.contact.phone,
            email: profileUser?.local.email,
            avatar: profileUser?.info.avatar,
          );
        }
      }
    }
    addNewEvent(AppCubitEnum.fUser, null);

    isLoadingProfileUser = false;
  }

  @override
  void addNewEvent(AppCubitEnum key, value) {
    if (isClosed) return;
    switch (key) {
      case AppCubitEnum.fUser:
        emit(NewAppState.fromOldSettingState(state,
            fUser: getIt<FUserLocal>().fUser?.copyWith()));
        break;
      case AppCubitEnum.itemCartQuantity:
        emit(NewAppState.fromOldSettingState(state, itemCartQuantity: value));
        break;
      default:
    }
  }
}
