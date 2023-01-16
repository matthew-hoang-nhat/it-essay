import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:it_project/main.dart';
import 'package:it_project/src/features/search/screens/detail_search_screen.dart';
import 'package:it_project/src/utils/remote/model/category/category.dart';
import 'package:it_project/src/utils/remote/model/product/product.dart';
import 'package:it_project/src/utils/repository/category_repository.dart';
import 'package:it_project/src/utils/repository/category_repository_impl.dart';
import 'package:it_project/src/utils/repository/product_repository.dart';
import 'package:it_project/src/utils/repository/product_repository_impl.dart';

part 'search_state.dart';

enum TypeSearchFilterEnum { category, price, sellerId }

enum TypeRefreshFilterEnum {
  refreshFilterWithoutSeller,
  refreshFilterAndSeller,
  refreshFilterWithoutCategory
}

enum TypeSearchLoadProductsEnum {
  loadMore,
  newSearchSameFilter,
  newSearchRefreshFilter,
  newSearchSameFilterWithoutSeller,
  newSearchSameFilterWithoutCategory
}

enum TypeSearchEnum {
  nameProduct,
  summary;

  @override
  String toString() {
    switch (this) {
      case TypeSearchEnum.nameProduct:
        return 'Tên sản phẩm';
      case TypeSearchEnum.summary:
        return 'Tóm tắt';
    }
  }
}

enum SearchCubitEnum {
  searchText,
  filterCategory,
  typeSearch,
  minPrice,
  products,
  onTypeFilter,
  filterSellerId,
}

class SearchCubit extends Cubit<SearchState> {
  SearchCubit()
      : super(const SearchInitial(
            onTypeFilter: null,
            isLoading: false,
            isLoadingMore: false,
            products: [],
            typeFilters: [
              TypeSearchFilterEnum.sellerId,
              TypeSearchFilterEnum.category,
              TypeSearchFilterEnum.price
            ],
            typeSearch: TypeSearchEnum.nameProduct,
            valueTypeFilters: {},
            valuesTypeFilters: {}));

  final CategoryRepository _categoryRepo = getIt<CategoryRepositoryImpl>();
  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();
  final ProductRepository _productRepository = getIt<ProductRepositoryImpl>();
  int _currentPageProducts = 1;
  bool isLoadingProducts = false;
  bool isLastPage = false;
  String currentSearchText = '';

  Future searchProducts(TypeSearchLoadProductsEnum typeSearchProducts) async {
    switch (typeSearchProducts) {
      case TypeSearchLoadProductsEnum.newSearchSameFilter:
        emit(state.copyWith(isLoading: true));
        _currentPageProducts = 1;
        await _getProducts();
        emit(state.copyWith(isLoading: false));
        break;

      case TypeSearchLoadProductsEnum.newSearchRefreshFilter:
        emit(state.copyWith(isLoading: true));
        _currentPageProducts = 1;
        _refreshFilter(TypeRefreshFilterEnum.refreshFilterWithoutSeller);
        await _getProducts();
        emit(state.copyWith(isLoading: false));
        break;

      case TypeSearchLoadProductsEnum.newSearchSameFilterWithoutSeller:
        emit(state.copyWith(isLoading: true));
        _currentPageProducts = 1;
        _refreshFilter(TypeRefreshFilterEnum.refreshFilterWithoutSeller);
        await _getProducts();
        emit(state.copyWith(isLoading: false));
        break;

      case TypeSearchLoadProductsEnum.newSearchSameFilterWithoutCategory:
        emit(state.copyWith(isLoading: true));
        _currentPageProducts = 1;
        _refreshFilter(TypeRefreshFilterEnum.refreshFilterWithoutCategory);
        await _getProducts();
        emit(state.copyWith(isLoading: false));
        break;

      case TypeSearchLoadProductsEnum.loadMore:
        _currentPageProducts++;
        emit(state.copyWith(isLoadingMore: true));
        await _getProducts();
        emit(state.copyWith(isLoadingMore: false));
        break;
      default:
    }
  }

  Future _getProducts() async {
    if (isLoadingProducts) return;
    isLoadingProducts = true;
    final name = state.typeSearch == TypeSearchEnum.nameProduct
        ? currentSearchText
        : null;
    final summary =
        state.typeSearch == TypeSearchEnum.summary ? currentSearchText : null;

    final double minPrice =
        state.valueTypeFilters[TypeSearchFilterEnum.price] ?? 0;

    final categoryId =
        (state.valueTypeFilters[TypeSearchFilterEnum.category] as Category?)
            ?.id;

    final sellerId = state.valueTypeFilters[TypeSearchFilterEnum.sellerId];

    final productsResponse = await _productRepository.getProducts(
        numberPage: _currentPageProducts,
        name: name,
        summary: summary,
        minPrice: minPrice - 1,
        categoryId: categoryId,
        sellerId: sellerId);

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

  void _refreshFilter(TypeRefreshFilterEnum type) {
    switch (type) {
      case TypeRefreshFilterEnum.refreshFilterAndSeller:
        emit(state.copyWith(valueTypeFilters: {}));

        break;
      case TypeRefreshFilterEnum.refreshFilterWithoutSeller:
        final newValueTypeFilters = <TypeSearchFilterEnum, dynamic>{};

        final sellerId =
            state.valueTypeFilters[TypeSearchFilterEnum.sellerId] as String?;

        newValueTypeFilters[TypeSearchFilterEnum.sellerId] = sellerId;

        emit(state.copyWith(valueTypeFilters: newValueTypeFilters));
        break;
      case TypeRefreshFilterEnum.refreshFilterWithoutCategory:
        final newValueTypeFilters = <TypeSearchFilterEnum, dynamic>{};
        final category =
            state.valueTypeFilters[TypeSearchFilterEnum.category] as Category?;
        newValueTypeFilters[TypeSearchFilterEnum.category] = category;
        emit(state.copyWith(valueTypeFilters: newValueTypeFilters));
        break;
      default:
    }
  }

  Future _getCategories() async {
    final categoriesResult = await _categoryRepo.getCategories();

    if (categoriesResult.isSuccess) {
      final newValuesTypeFilters =
          Map<TypeSearchFilterEnum, dynamic>.from(state.valuesTypeFilters);

      newValuesTypeFilters[TypeSearchFilterEnum.category] =
          categoriesResult.data;
      emit(state.copyWith(valuesTypeFilters: newValuesTypeFilters));
    }
  }

  void setCurrentSearchText({String? value}) {
    currentSearchText = searchController.text;
    if (value != null) {
      currentSearchText = value;
      searchController.text = value;
    }
  }

  void _setUpScrollProductsController() {
    scrollController.addListener(() {
      if (scrollController.hasClients) {
        if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent * 0.99) {
          searchProducts(TypeSearchLoadProductsEnum.loadMore);
        }
      }
    });
  }

  void initCubit({Map<DetailSearchExtraEnum, dynamic>? extra}) async {
    _setUpScrollProductsController();
    _getCategories();
    _getAndSetExtra(extra);
  }

  _getAndSetExtra(Map<DetailSearchExtraEnum, dynamic>? extra) async {
    final sellerId = extra?[DetailSearchExtraEnum.sellerId];
    final category = extra?[DetailSearchExtraEnum.category];
    final searchTextExtra = extra?[DetailSearchExtraEnum.searchText];
    if (sellerId != null) {
      final newValueTypeFilters =
          Map<TypeSearchFilterEnum, dynamic>.from(state.valueTypeFilters);
      newValueTypeFilters[TypeSearchFilterEnum.sellerId] = sellerId;

      final newValuesTypeFilters =
          Map<TypeSearchFilterEnum, dynamic>.from(state.valuesTypeFilters);
      newValuesTypeFilters[TypeSearchFilterEnum.sellerId] = [sellerId, null];

      emit(state.copyWith(
          valueTypeFilters: newValueTypeFilters,
          valuesTypeFilters: newValuesTypeFilters));
    }

    if (category != null) {
      final newValueTypeFilters =
          Map<TypeSearchFilterEnum, dynamic>.from(state.valueTypeFilters);
      newValueTypeFilters[TypeSearchFilterEnum.category] = category;

      emit(state.copyWith(valueTypeFilters: newValueTypeFilters));
    }

    if (searchTextExtra != null) {
      setField(SearchCubitEnum.searchText, value: searchTextExtra);
      currentSearchText = searchTextExtra;
      await searchProducts(TypeSearchLoadProductsEnum.newSearchRefreshFilter);
    }
  }

  var focusNode = FocusNode();

  @override
  void emit(SearchState state) {
    if (isClosed) return;
    super.emit(state);
  }

  void setField(SearchCubitEnum key, {value}) {
    switch (key) {
      case SearchCubitEnum.searchText:
        searchController.text = value;
        break;

      case SearchCubitEnum.filterCategory:
        final newValueTypeFilters =
            Map<TypeSearchFilterEnum, dynamic>.from(state.valueTypeFilters);

        newValueTypeFilters[TypeSearchFilterEnum.category] = value;

        emit(state.copyWith(valueTypeFilters: newValueTypeFilters));
        break;
      case SearchCubitEnum.filterSellerId:
        final newValueTypeFilters =
            Map<TypeSearchFilterEnum, dynamic>.from(state.valueTypeFilters);

        newValueTypeFilters[TypeSearchFilterEnum.sellerId] = value;

        emit(state.copyWith(valueTypeFilters: newValueTypeFilters));
        break;

      case SearchCubitEnum.typeSearch:
        emit(state.copyWith(typeSearch: value));
        break;
      case SearchCubitEnum.onTypeFilter:
        if (state.onTypeFilter == value) {
          emit(state.copyWith(onTypeFilter: const Wrapped.value(null)));
          break;
        }
        emit(state.copyWith(onTypeFilter: Wrapped.value(value)));
        break;

      case SearchCubitEnum.minPrice:
        final newValueTypeFilters =
            Map<TypeSearchFilterEnum, dynamic>.from(state.valueTypeFilters);

        newValueTypeFilters[TypeSearchFilterEnum.price] = value;

        emit(state.copyWith(valueTypeFilters: newValueTypeFilters));
        break;

      case SearchCubitEnum.products:
        emit(state.copyWith(products: value as List<Product>));
        break;

      default:
    }
  }
}
