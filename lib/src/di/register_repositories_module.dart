part of 'di_graph_setup.dart';

Future<void> _registerRepositoriesModule() async {
  // Repository
  Get.put(AuthRepository(
    Get.find<AppShared>(),
    Get.find(),
  ));
}
