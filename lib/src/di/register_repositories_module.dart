part of 'di_graph_setup.dart';

Future<void> _registerRepositoriesModule() async {
  getIt.registerSingleton(AuthRepositoryImpl(
    authService: getIt<AuthService>(),
  ));
  getIt.registerSingleton(ProductRepositoryImpl(
    productService: getIt<ProductService>(),
  ));
  getIt.registerSingleton(SearchRepositoryImpl(
    searchService: getIt<SearchService>(),
  ));
  getIt.registerSingleton(CategoryRepositoryImpl(
    categoryService: getIt<CategoryService>(),
  ));
  // getIt.registerSingleton(
  //     ProfileRepositoryImpl(profileService: getIt<AuthService>()));

  getIt.registerSingleton<AppCubit>(AppCubit());
}
