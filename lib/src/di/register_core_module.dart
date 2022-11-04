part of 'di_graph_setup.dart';

Future<void> _registerCoreModule() async {
  await Get.putAsync<AppShared>(() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    final Box box = await Hive.openBox(AppShared.keyBox);
    return AppShared(box);
  });

  // Network
  Get.put(DioHttpClient('https://auth-server-btn-v1.herokuapp.com/v1'),
      tag: 'auth');
}
