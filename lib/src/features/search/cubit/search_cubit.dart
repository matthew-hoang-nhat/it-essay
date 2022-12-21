import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:it_project/main.dart';
import 'package:it_project/src/utils/remote/model/category/category.dart';
import 'package:it_project/src/utils/remote/model/product/product.dart';
import 'package:it_project/src/utils/remote/model/search/content_search.dart';
import 'package:it_project/src/utils/repository/category_repository.dart';
import 'package:it_project/src/utils/repository/category_repository_impl.dart';
import 'package:it_project/src/utils/repository/product_repository.dart';
import 'package:it_project/src/utils/repository/product_repository_impl.dart';
import 'package:it_project/src/utils/repository/search_repository.dart';
import 'package:it_project/src/utils/repository/search_repository_impl.dart';

part 'search_state.dart';

enum SearchCubitEnum {
  searchText,
  filterCategory,
  searchType,
  minPrice,
  typeFilter,
}

enum SearchTypeFilterEnum { category, price, nothing }

enum SearchTypeEnum {
  nameProduct,
  summary;

  @override
  String toString() {
    switch (this) {
      case SearchTypeEnum.nameProduct:
        return 'Tên sản phẩm';
      case SearchTypeEnum.summary:
        return 'Tóm tắt';
    }
  }
}

enum SearchCubitLoadProductEnum {
  loadMore,
  refreshOnlyFilter,
  refreshOnlyProducts,
  refresh
}

class SearchCubit extends Cubit<SearchState> {
  SearchCubit()
      : super(const SearchInitial(
            contentSearches: [],
            categories: [],
            isLoading: false,
            isLoadingMore: false,
            searchType: SearchTypeEnum.nameProduct,
            categoryFilter: null,
            products: [],
            typeFilter: SearchTypeFilterEnum.nothing,
            minPrice: 0,
            sellerFilter: null));

  final SearchRepository _searchRepository = getIt<SearchRepositoryImpl>();
  final CategoryRepository _categoryRepository =
      getIt<CategoryRepositoryImpl>();
  Timer? _debounce;

  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();

  onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (searchController.text.isNotEmpty) {
        _searchContent(searchController.text);
      }
    });
  }

  _searchContent(String text) async {
    final searchContentsResponse = await _searchRepository.searchContent(text);
    if (searchContentsResponse.isSuccess) {
      final contentSearches = searchContentsResponse.data;
      emit(state.copyWith(contentSearches: contentSearches));
      return;
    }
  }

  getCategories() async {
    final categories = await _categoryRepository.getCategories();

    if (categories.isSuccess) {
      emit(state.copyWith(categories: categories.data));
    }
  }

  final ProductRepository _productRepository = getIt<ProductRepositoryImpl>();

  int _currentPageProducts = 1;
  bool isLoadingProducts = false;

  bool isLastPage = false;

  loadPageProducts(SearchCubitLoadProductEnum typeLoad) async {
    if (isLoadingProducts) return;

    switch (typeLoad) {
      case SearchCubitLoadProductEnum.refresh:
        emit(state.copyWith(isLoading: true));

        _currentPageProducts = 1;
        isLastPage = false;
        searchController.text = '';
        emit(state.copyWith(
            minPrice: 0,
            typeFilter: SearchTypeFilterEnum.nothing,
            searchType: SearchTypeEnum.nameProduct,
            categoryFilter: const Wrapped.value(null)));

        await _getProducts();
        emit(state.copyWith(isLoading: false));
        return;
      case SearchCubitLoadProductEnum.refreshOnlyFilter:
        emit(state.copyWith(isLoading: true));

        _currentPageProducts = 1;
        isLastPage = false;
        emit(state.copyWith(
            minPrice: 0,
            typeFilter: SearchTypeFilterEnum.nothing,
            categoryFilter: const Wrapped.value(null)));
        await _getProducts();
        emit(state.copyWith(isLoading: false));
        return;
      case SearchCubitLoadProductEnum.refreshOnlyProducts:
        emit(state.copyWith(isLoading: true));
        _currentPageProducts = 1;
        isLastPage = false;
        await _getProducts();
        emit(state.copyWith(isLoading: false));
        return;
      case SearchCubitLoadProductEnum.loadMore:
        if (isLastPage) return;
        emit(state.copyWith(isLoadingMore: true));
        _currentPageProducts++;
        await _getProducts();
        emit(state.copyWith(isLoading: false, isLoadingMore: false));
        break;
      default:
    }
  }

  _getProducts() async {
    isLoadingProducts = true;
    final productsResponse = await _productRepository.getProducts(
      numberPage: _currentPageProducts,
      name: state.searchType == SearchTypeEnum.nameProduct
          ? searchController.text
          : null,
      summary: state.searchType == SearchTypeEnum.summary
          ? searchController.text
          : null,
      minPrice: state.minPrice - 1,
      categoryId: state.categoryFilter?.id,
    );

    if (productsResponse.isSuccess) {
      final products = productsResponse.data!;
      if (_currentPageProducts > 1) {
        emit(state.copyWith(products: [...state.products, ...products]));
      } else {
        emit(state.copyWith(products: products));
      }
    }
    if (productsResponse.isError && _currentPageProducts == 1) {
      emit(state.copyWith(products: []));
    }

    if (productsResponse.isError && _currentPageProducts != 1) {
      isLastPage = true;
    }

    isLoadingProducts = false;
  }

  refreshCubit() {
    emit(SearchInitial(
        contentSearches: const [],
        categories: state.categories,
        isLoading: false,
        isLoadingMore: false,
        categoryFilter: null,
        minPrice: 0,
        typeFilter: SearchTypeFilterEnum.nothing,
        products: const [],
        searchType: SearchTypeEnum.nameProduct,
        sellerFilter: null));
  }

  setUpScrollProductsController() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent * 0.99) {
        loadPageProducts(SearchCubitLoadProductEnum.loadMore);
      }
    });
  }

  initCubit() {
    setUpScrollProductsController();
    getCategories();
  }

  var focusNode = FocusNode();

  @override
  void emit(SearchState state) {
    if (isClosed) return;
    super.emit(state);
  }

  setField(SearchCubitEnum key, {value}) {
    switch (key) {
      case SearchCubitEnum.searchText:
        searchController.text = value;
        break;
      case SearchCubitEnum.filterCategory:
        emit(state.copyWith(categoryFilter: Wrapped.value(value)));
        break;
      case SearchCubitEnum.searchType:
        emit(state.copyWith(searchType: value));
        break;
      case SearchCubitEnum.minPrice:
        emit(state.copyWith(minPrice: value));
        break;

      case SearchCubitEnum.typeFilter:
        if (state.typeFilter == value) {
          emit(state.copyWith(typeFilter: SearchTypeFilterEnum.nothing));
          return;
        }
        emit(state.copyWith(typeFilter: value));
        break;
      default:
    }
  }
}
