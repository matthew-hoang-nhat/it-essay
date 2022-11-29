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

enum HomeEnum {
  products,
  categories,
  flashSaleProducts,
  isFirstLoading,
  isLoadingProducts
}

class HomeCubit extends Cubit<HomeState> implements ParentCubit<HomeEnum> {
  HomeCubit()
      : super(const HomeInitial(
          products: [],
          categories: [],
          flashSaleProducts: [],
          isFirstLoading: false,
          isLoadingProducts: false,
        ));
  ProductRepository productRepository = getIt<ProductRepositoryImpl>();
  CategoryRepository categoryRepository = getIt<CategoryRepositoryImpl>();

  int _currentPageProducts = 0;
  int _currentPageFlashSale = 0;
  int _currentPageCategory = 0;

  bool isLoadingFlashSales = false;
  bool isLoadingCategories = false;

  initCubit() async {
    addNewEvent(HomeEnum.isFirstLoading, true);
    await Future.wait([
      loadPage(HomeEnum.products),
      loadPage(HomeEnum.categories),
      loadPage(HomeEnum.flashSaleProducts)
    ]);
    addNewEvent(HomeEnum.isFirstLoading, false);
  }

  bool isLastProduct = false;

  Future<void> loadPage(HomeEnum homeEnum) async {
    switch (homeEnum) {
      case HomeEnum.products:
        if (isLastProduct) return;
        if (state.isLoadingProducts) return;
        _currentPageProducts++;
        await getProducts();
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

  getProducts() async {
    addNewEvent(HomeEnum.isLoadingProducts, true);

    final productsResponse =
        await productRepository.getProducts(numberPage: _currentPageProducts);
    if (productsResponse.isSuccess) {
      addNewEvent(
          HomeEnum.products, [...state.products, ...productsResponse.data!]);
    }

    if (productsResponse.isError) {
      _currentPageProducts--;
      isLastProduct = true;
    }

    addNewEvent(HomeEnum.isLoadingProducts, false);
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
      case HomeEnum.isFirstLoading:
        emit(NewHomeState.fromOldSettingState(state, isFirstLoading: value));
        break;
      case HomeEnum.isLoadingProducts:
        emit(NewHomeState.fromOldSettingState(state, isLoadingProducts: value));
        break;
      default:
    }
  }
}
