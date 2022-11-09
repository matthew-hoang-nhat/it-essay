import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:it_project/main.dart';
import 'package:it_project/src/features/login_register/cubit/parent_cubit.dart';
import 'package:it_project/src/utils/remote/model/category/category.dart';
import 'package:it_project/src/utils/remote/model/product/product.dart';
import 'package:it_project/src/utils/remote/model/search/content_search.dart';
import 'package:it_project/src/utils/repository/product_repository.dart';
import 'package:it_project/src/utils/repository/product_repository_impl.dart';
import 'package:it_project/src/utils/repository/search_repository.dart';
import 'package:it_project/src/utils/repository/search_repository_impl.dart';

part 'search_state.dart';

enum SearchEnum {
  contentSearches,
  isLoading,
  isEmpty,
  categories,
  products,
}

class SearchCubit extends Cubit<SearchState>
    implements ParentCubit<SearchEnum> {
  SearchCubit()
      : super(const SearchInitial(
          contentSearches: [],
          products: [],
          categories: [],
          isLoading: false,
          isEmpty: true,
        ));

  final SearchRepository _searchRepository = getIt<SearchRepositoryImpl>();

  final ProductRepository _productRepository = getIt<ProductRepositoryImpl>();

  searchContent(String text) async {
    addNewEvent(SearchEnum.isLoading, true);

    final searchContentsResponse = await _searchRepository.searchContent(text);
    if (searchContentsResponse.isSuccess) {
      addNewEvent(SearchEnum.contentSearches, searchContentsResponse.data);
    }
    addNewEvent(SearchEnum.isLoading, false);
  }

  getCategories() async {
    final categoriesResponse = await _productRepository.getCategories();
    if (categoriesResponse.isSuccess) {
      addNewEvent(SearchEnum.categories, categoriesResponse.data);
    }
  }

  getProducts() async {
    final productsResponse = await _productRepository.getProducts();
    if (productsResponse.isSuccess) {
      addNewEvent(SearchEnum.products, productsResponse.data);
      return;
    }
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
      case SearchEnum.products:
        emit(NewSearchState.fromOldSettingState(state, products: value));
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
