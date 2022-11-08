import 'package:flutter/material.dart';
import 'package:it_project/src/di/di_graph_setup.dart';

Future<void> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependenciesGraph();
}
