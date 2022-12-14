part of 'di_graph_setup.dart';

Future<void> _registerCoreModule() async {
  await registerAppSharedAsync();

  // Network
  getIt.registerSingleton(
      DioHttpClient('https://auth-server-v1-btn-production.up.railway.app/v1'));
  getIt.registerSingleton(
      DioHttpClient('https://external-services-production.up.railway.app'),
      instanceName: 'upFileServer');

  getIt.registerSingleton(DioHttpClient('https://provinces.open-api.vn/api'),
      instanceName: 'locationServer');
}

registerAppSharedAsync() async {
  final Directory directory = await getApplicationDocumentsDirectory();
  Hive
    ..init(directory.path)
    ..registerAdapter(ItemCartAdapter())
    ..registerAdapter(FUserLocalDaoAdapter());
  final Box box = await Hive.openBox(AppConstants.keyBox);

  getIt.registerSingleton<Box>(box);
  getIt.registerSingleton<FCartLocal>(FCartLocal());
  getIt.registerSingleton<FUserLocal>(FUserLocal());
}
