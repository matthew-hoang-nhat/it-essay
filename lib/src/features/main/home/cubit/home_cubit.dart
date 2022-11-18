import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:it_project/main.dart';
import 'package:it_project/src/features/login_register/cubit/parent_cubit.dart';
import 'package:it_project/src/utils/remote/model/category/category.dart';
import 'package:it_project/src/utils/remote/model/product/product.dart';
import 'package:it_project/src/utils/repository/category_repository.dart';
import 'package:it_project/src/utils/repository/category_repository_impl.dart';
import 'package:it_project/src/utils/repository/product_repository.dart';
import 'package:it_project/src/utils/repository/product_repository_impl.dart';

part 'home_state.dart';

enum HomeEnum { products, categories, flashSaleProducts }

class HomeCubit extends Cubit<HomeState> implements ParentCubit<HomeEnum> {
  HomeCubit()
      : super(const HomeInitial(
            products: [], categories: [], flashSaleProducts: []));
  ProductRepository productRepository = getIt<ProductRepositoryImpl>();
  CategoryRepository categoryRepository = getIt<CategoryRepositoryImpl>();

  int _currentPageProducts = 0;
  int _currentPageFlashSale = 0;
  int _currentPageCategory = 0;

  bool isLoadingFlashSales = false;
  bool isLoadingCategories = false;
  bool isLoadingProducts = false;

  initBloc() {
    loadPage(HomeEnum.products);
    loadPage(HomeEnum.categories);
    loadPage(HomeEnum.flashSaleProducts);
  }

  void loadPage(HomeEnum homeEnum) {
    switch (homeEnum) {
      case HomeEnum.products:
        if (isLoadingProducts) return;
        _currentPageProducts++;
        getProducts();
        break;
      case HomeEnum.categories:
        if (isLoadingCategories) return;
        _currentPageCategory++;
        getCategories();
        break;
      case HomeEnum.flashSaleProducts:
        if (isLoadingFlashSales) return;
        _currentPageFlashSale++;
        getFlashSaleProducts();
        break;
      default:
    }
  }

  void getProducts() async {
    isLoadingProducts = true;
    final productsResponse =
        await productRepository.getProducts(numberPage: _currentPageProducts);
    if (productsResponse.isSuccess) {
      addNewEvent(
          HomeEnum.products, [...state.products, ...productsResponse.data!]);
    }

    if (productsResponse.isError) {
      _currentPageProducts--;
    }

    isLoadingProducts = false;
  }

  void getCategories() async {
    isLoadingCategories = true;

    final categoriesResponse = await categoryRepository.getCategories(
        numberPage: _currentPageCategory);
    if (categoriesResponse.isSuccess) {
      addNewEvent(HomeEnum.categories, categoriesResponse.data);
    }

    isLoadingCategories = false;
  }

  void getFlashSaleProducts() async {
    isLoadingFlashSales = true;

    final productsResponse = await productRepository.getFlashSaleProducts(
        numberPage: _currentPageFlashSale);
    if (productsResponse.isSuccess) {
      addNewEvent(HomeEnum.flashSaleProducts,
          [...state.flashSaleProducts, ...productsResponse.data!]);
    }

    isLoadingFlashSales = false;
  }

  @override
  void addNewEvent(HomeEnum key, value) {
    if (isClosed) return;
    switch (key) {
      case HomeEnum.products:
        emit(NewHomeState.fromOldSettingState(state, products: value));
        break;
      case HomeEnum.categories:
        emit(NewHomeState.fromOldSettingState(state, categories: value));
        break;
      case HomeEnum.flashSaleProducts:
        emit(NewHomeState.fromOldSettingState(state, flashSaleProducts: value));
        break;
      default:
    }
  }
}
