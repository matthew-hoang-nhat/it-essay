import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:it_project/main.dart';
import 'package:it_project/src/features/app/fcart.dart';
import 'package:it_project/src/features/app/fuser.dart';
import 'package:it_project/src/features/login_register/cubit/parent_cubit.dart';
import 'package:it_project/src/utils/repository/auth_repository.dart';
import 'package:it_project/src/utils/repository/auth_repository_impl.dart';
import 'package:it_project/src/utils/repository/category_repository.dart';
import 'package:it_project/src/utils/repository/category_repository_impl.dart';
import 'package:it_project/src/utils/repository/product_repository.dart';
import 'package:it_project/src/utils/repository/product_repository_impl.dart';
import 'package:it_project/src/utils/repository/search_repository.dart';
import 'package:it_project/src/utils/repository/search_repository_impl.dart';

part 'app_state.dart';

enum AppCubitEnum { fCart, fUser }

class AppCubit extends Cubit<AppState> implements ParentCubit<AppCubitEnum> {
  AppCubit()
      : super(AppInitial(
          fCartLocal: FCartLocal(),
          fUserLocal: FUserLocal(),
        ));
  final AuthRepository authRepo = getIt<AuthRepositoryImpl>();
  final SearchRepository searchRepo = getIt<SearchRepositoryImpl>();
  final ProductRepository productRepo = getIt<ProductRepositoryImpl>();
  final CategoryRepository categoryRepo = getIt<CategoryRepositoryImpl>();

  @override
  void addNewEvent(AppCubitEnum key, value) {
    if (isClosed) return;
    switch (key) {
      case AppCubitEnum.fCart:
        emit(NewAppState.fromOldSettingState(state, fCartLocal: FCartLocal()));
        break;
      default:
    }
  }
}
