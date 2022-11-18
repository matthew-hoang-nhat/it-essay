part of 'di_graph_setup.dart';

Future<void> _registerCoreModule() async {
  await registerAppSharedAsync();

  // Network
  getIt.registerSingleton(
      DioHttpClient('https://auth-server-btn-v1.herokuapp.com/v1'));
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
