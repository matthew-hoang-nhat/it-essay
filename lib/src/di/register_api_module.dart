part of 'di_graph_setup.dart';

void _registerApiModule() {
  // API Server
  Get.put(AuthService(Get.find<DioHttpClient>(tag: 'auth')));
}
