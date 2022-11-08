import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:it_project/main.dart';
import 'package:it_project/src/features/login_register/cubit/parent_cubit.dart';
import 'package:it_project/src/features/main/home_product/repositories/product_repository.dart';
import 'package:it_project/src/features/main/home_product/repositories/product_repository_impl.dart';
import 'package:it_project/src/features/main/home_product/services/models/category.dart';
import 'package:it_project/src/features/search/remote/model/content_search.dart';
import 'package:it_project/src/features/search/repositories/search_repository.dart';
import 'package:it_project/src/features/search/repositories/search_repository_impl.dart';

part 'search_state.dart';

enum SearchEnum { contentSearches, isLoading, isEmpty, categories }

class SearchCubit extends Cubit<SearchState>
    implements ParentCubit<SearchEnum> {
  SearchCubit()
      : super(const SearchInitial(
          contentSearches: [],
          categories: [],
          isLoading: false,
          isEmpty: true,
        ));

  final SearchRepository _searchRepository = getIt<SearchRepositoryImpl>();

  final ProductRepository _productRepository = getIt<ProductRepositoryImpl>();

  searchContent(String text) async {
    addNewEvent(SearchEnum.isLoading, true);

    final searchContents = await _searchRepository.searchContent(text);

    addNewEvent(SearchEnum.contentSearches, searchContents);
    addNewEvent(SearchEnum.isLoading, false);
  }

  getCategories() async {
    final categories = await _productRepository.getCategories();
    if (isClosed == false) {
      addNewEvent(SearchEnum.categories, categories);
    }
  }

  @override
  void addNewEvent(SearchEnum key, value) {
    switch (key) {
      case SearchEnum.isLoading:
        emit(NewSearchState.fromOldSettingState(state, isLoading: value));
        break;
      case SearchEnum.contentSearches:
        emit(NewSearchState.fromOldSettingState(state, contentSearches: value));
        break;
      case SearchEnum.isEmpty:
        emit(NewSearchState.fromOldSettingState(state, isEmpty: value));
        break;
      case SearchEnum.categories:
        emit(NewSearchState.fromOldSettingState(state, categories: value));
        break;
    }
  }
}
