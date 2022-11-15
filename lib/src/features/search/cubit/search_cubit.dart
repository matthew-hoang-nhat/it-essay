import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:it_project/main.dart';
import 'package:it_project/src/features/login_register/cubit/parent_cubit.dart';
import 'package:it_project/src/utils/remote/model/category/category.dart';
import 'package:it_project/src/utils/remote/model/product/product.dart';
import 'package:it_project/src/utils/remote/model/search/content_search.dart';
import 'package:it_project/src/utils/repository/search_repository.dart';
import 'package:it_project/src/utils/repository/search_repository_impl.dart';

part 'search_state.dart';

enum SearchEnum {
  contentSearches,
  isLoading,
  // isEmpty,
  categories,
  // products,
  // isShowProducts,
}

class SearchCubit extends Cubit<SearchState>
    implements ParentCubit<SearchEnum> {
  SearchCubit()
      : super(const SearchInitial(
          contentSearches: [],
          categories: [],
          isLoading: false,
          // isEmpty: true,
          // isShowProducts: false,
        ));

  final SearchRepository _searchRepository = getIt<SearchRepositoryImpl>();

  searchContent(String text) async {
    print('searchContent');
    // addNewEvent(SearchEnum.isLoading, true);
    final searchContentsResponse = await _searchRepository.searchContent(text);
    if (searchContentsResponse.isSuccess) {
      print('success');
      addNewEvent(SearchEnum.contentSearches, searchContentsResponse.data);
      return;
    }

    print('false');
    // addNewEvent(SearchEnum.isLoading, false);
  }

  @override
  void addNewEvent(SearchEnum key, value) {
    if (isClosed) {
      return;
    }
    switch (key) {
      case SearchEnum.isLoading:
        emit(NewSearchState.fromOldSettingState(state, isLoading: value));
        break;
      case SearchEnum.contentSearches:
        emit(NewSearchState.fromOldSettingState(state, contentSearches: value));
        break;
      // case SearchEnum.products:
      //   emit(NewSearchState.fromOldSettingState(state, products: value));
      //   break;
      // case SearchEnum.isEmpty:
      //   emit(NewSearchState.fromOldSettingState(state, isEmpty: value));
      //   break;
      case SearchEnum.categories:
        emit(NewSearchState.fromOldSettingState(state, categories: value));
        break;
      // case SearchEnum.isShowProducts:
      //   emit(NewSearchState.fromOldSettingState(state, isShowProducts: value));
      //   break;
    }
  }
}
