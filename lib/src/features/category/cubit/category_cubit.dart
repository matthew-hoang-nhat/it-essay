import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_project/main.dart';
import 'package:it_project/src/features/login_register/cubit/parent_cubit.dart';
import 'package:it_project/src/utils/remote/model/category/category.dart';
import 'package:it_project/src/utils/repository/category_repository.dart';
import 'package:it_project/src/utils/repository/category_repository_impl.dart';

part 'category_state.dart';

enum CategoryEnum { categories }

class CategoryCubit extends Cubit<CategoryState>
    implements ParentCubit<CategoryEnum> {
  CategoryCubit()
      : super(const CategoryInitial(
          categories: [],
        ));
  CategoryRepository categoryRepository = getIt<CategoryRepositoryImpl>();

  bool isLoadingCategories = false;

  void loadPage(CategoryEnum categoryEnum) {
    switch (categoryEnum) {
      case CategoryEnum.categories:
        if (isLoadingCategories) return;
        getCategories();
        break;

      default:
    }
  }

  void getCategories() async {
    isLoadingCategories = true;
    final categoryResponse = await categoryRepository.getCategories(
        // numberPage: _currentPageCategories,
        );
    if (categoryResponse.isSuccess) {
      addNewEvent(CategoryEnum.categories,
          [...state.categories, ...categoryResponse.data!]);
    }

    if (categoryResponse.isError) {}

    isLoadingCategories = false;
  }

  @override
  void addNewEvent(CategoryEnum key, value) {
    if (isClosed) return;
    switch (key) {
      case CategoryEnum.categories:
        emit(NewCategoryState.fromOldSettingState(state, categories: value));
        break;
      default:
    }
  }
}
