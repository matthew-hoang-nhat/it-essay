import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:it_project/src/ui/test_screen/next_test_viewmodel.dart';

import 'next_test_viewmodel.dart';

class NextTestScreen extends GetView<NextTestedViewModel> {
  const NextTestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isLoading == true
        ? const Scaffold()
        : Scaffold(body: Column(children: [Text(controller.text)])));
  }
}
