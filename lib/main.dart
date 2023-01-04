import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:it_project/app.dart';
import 'package:it_project/locator.dart';

final getIt = GetIt.instance;

bool isFuture = false;
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  await initializeApp();
  runApp(const App());
}
