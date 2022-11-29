part of 'di_graph_setup.dart';

void _registerApiModule() {
  // API Server
  getIt.registerSingleton(AuthService(getIt<DioHttpClient>()));
  getIt.registerSingleton(CategoryService(getIt<DioHttpClient>()));
  getIt.registerSingleton(ProductService(getIt<DioHttpClient>()));
  getIt.registerSingleton(SearchService(getIt<DioHttpClient>()));
  getIt.registerSingleton(SellerService(getIt<DioHttpClient>()));
  getIt.registerSingleton(
      UpFileService(getIt<DioHttpClient>(instanceName: 'upFileServer')));
}
