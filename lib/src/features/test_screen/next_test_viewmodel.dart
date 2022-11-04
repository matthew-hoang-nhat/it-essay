import 'dart:developer';

import 'package:get/get.dart';

class NextTestedViewModel extends GetxController {
  int? number;
  final RxBool _isLoadingObs = false.obs;
  String text = '';
  bool get isLoading => _isLoadingObs.value;
  set isLoading(bool value) {
    _isLoadingObs.value = value;
  }

  @override
  void onInit() {
    super.onInit();
    demoIsolate();
  }

  demoIsolate() async {
    // final port = ReceivePort();
    // await Isolate.spawn(heavyTask, port.sendPort);
    heavyTask();
    isLoading = true;
    // text = await port.first;
    isLoading = false;
  }
}

Future heavyTask() async {
  for (int i = 1; i < 10000; i++) {
    log('index: $i');
  }
}

// Future<void> heavyTask(SendPort port) {
// for (int i = 1; i < 5000; i++) {
//  1 log('index: $i');
// }
//   Isolate.exit(port, 'END ISOLATE');
// }

class IsolateModel {
  IsolateModel(this.iteration, this.multiplier);

  final int iteration;
  final int multiplier;
}
