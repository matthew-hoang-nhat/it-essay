import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:it_project/app.dart';
import 'package:it_project/locator.dart';

final getIt = GetIt.instance;

void main() async {
  await initializeApp();
  runApp(
      // const App()
      DevicePreview(
    builder: (context) => const App(),
  ));
}
