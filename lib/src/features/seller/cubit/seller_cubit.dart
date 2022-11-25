import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:it_project/main.dart';
import 'package:it_project/src/features/login_register/cubit/parent_cubit.dart';
import 'package:it_project/src/utils/remote/model/category/category.dart';
import 'package:it_project/src/utils/remote/model/product/product.dart';
import 'package:it_project/src/utils/remote/model/seller/profile_seller.dart';
import 'package:it_project/src/utils/repository/seller_repository.dart';
import 'package:it_project/src/utils/repository/seller_repository_impl.dart';

part 'seller_state.dart';

enum SellerEnum {
  profileSeller,
  products,
  isLoading,
  tabIndex,
  categories,
  isLoadingProducts,
  productsOfCategory,
}

class SellerCubit extends Cubit<SellerState>
    implements ParentCubit<SellerEnum> {
  SellerCubit({required ProfileSeller profileSeller})
      : super(DetailSellerInitial(
          products: const [],
          profileSeller: profileSeller,
          productsOfCategory: const {},
          isEmpty: false,
          tabIndex: 0,
          isLoading: false,
          isLoadingProducts: false,
          categories: const [],
        ));
  final SellerRepository _sellerRepository = getIt<SellerRepositoryImpl>();
  int _currentPageProducts = 0;
  // bool _isLoadingProducts = false;
  bool _isLoadingCategories = false;

  final controller = ScrollController();

  initCubit() async {
    addNewEvent(SellerEnum.isLoading, true);
    settingController();
    loadProducts();
    _getInfo();
    await loadCategories();
    await loadProductsOfCategory();
    addNewEvent(SellerEnum.isLoading, false);
  }

  Future loadProductsOfCategory() async {
    // for (var item in state.categories) {
    //   _getProductsOfCategory(item.id);
    // }
    return Future.value(
        Future.wait(state.categories.map((e) => _getProductsOfCategory(e.id))));
  }

  void settingController() {
    controller.addListener(() {
      if (controller.position.pixels >=
          controller.position.maxScrollExtent * 0.7) {
        if (state.tabIndex == 1) {
          loadProducts();
        }
      }
    });
  }

  Future<void> _getProductsOfCategory(categoryId) async {
    final productsCategoryResponse = await _sellerRepository.getProducts(
        categoryId: categoryId,
        sellerId: state.profileSeller.id,
        currentPage: 1,
        limit: 3);

    if (productsCategoryResponse.isSuccess) {
      final newProductsOfCategory =
          Map<String, List<Product>>.from(state.productsOfCategory);
      newProductsOfCategory[categoryId] = productsCategoryResponse.data!;
      addNewEvent(SellerEnum.productsOfCategory, newProductsOfCategory);
    }
  }

  loadProducts() {
    if (state.isLoadingProducts) return;
    _currentPageProducts++;
    Future.value(_getProducts());
  }

  _getProducts() async {
    addNewEvent(SellerEnum.isLoadingProducts, true);
    // _isLoadingProducts = true;
    final productsResponse = await _sellerRepository.getProducts(
      sellerId: state.profileSeller.id,
      currentPage: _currentPageProducts,
    );

    if (productsResponse.isSuccess) {
      addNewEvent(
          SellerEnum.products, [...state.products, ...productsResponse.data!]);
    }

    if (productsResponse.isError) {
      _currentPageProducts--;
    }

    addNewEvent(SellerEnum.isLoadingProducts, false);
    // _isLoadingProducts = false;
  }

  bool _isLoadedCategories = false;
  loadCategories() async {
    if (_isLoadedCategories) return;
    if (_isLoadingCategories) return;
    await _getCategories();
  }

  _getCategories() async {
    _isLoadingCategories = true;
    final response = await _sellerRepository.getCategories(
      sellerId: state.profileSeller.id,
    );

    if (response.isSuccess) {
      addNewEvent(SellerEnum.categories, response.data);
    }

    _isLoadingCategories = false;
    _isLoadedCategories = true;
  }

  _getInfo() async {
    final response = await _sellerRepository.getInfo(
      sellerId: state.profileSeller.id,
    );

    if (response.isSuccess) {
      addNewEvent(SellerEnum.profileSeller, response.data);
    }
  }

  @override
  void addNewEvent(SellerEnum key, value) {
    if (isClosed) return;
    switch (key) {
      case SellerEnum.products:
        emit(NewSellerState.fromOldSettingState(state, products: value));
        break;
      case SellerEnum.tabIndex:
        emit(NewSellerState.fromOldSettingState(state, tabIndex: value));
        break;
      case SellerEnum.categories:
        emit(NewSellerState.fromOldSettingState(state, categories: value));
        break;
      case SellerEnum.productsOfCategory:
        emit(NewSellerState.fromOldSettingState(state,
            productsOfCategory: value));
        break;
      case SellerEnum.isLoading:
        emit(NewSellerState.fromOldSettingState(state, isLoading: value));
        break;
      case SellerEnum.profileSeller:
        emit(NewSellerState.fromOldSettingState(state, profileSeller: value));
        break;
      case SellerEnum.isLoadingProducts:
        emit(NewSellerState.fromOldSettingState(state,
            isLoadingProducts: value));
        break;
      default:
    }
  }
}
