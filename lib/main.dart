import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/src/configs/bindings/login_binding.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/core/login_register/screens/login_screen.dart';
import 'package:it_project/src/di/di_graph_setup.dart';

import 'package:it_project/src/utils/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependenciesGraph();
  runApp(DevicePreview(
    builder: (context) => const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightMode(),
      getPages: AppPages.pages,
      home: const LoginScreen(),
      initialBinding: LoginBinding(),
    );
  }

  ThemeData lightMode() {
    return ThemeData(
        textTheme: TextTheme(
          headline1: GoogleFonts.nunito(),
        ),
        scaffoldBackgroundColor: AppColors.whiteColor,
        // backgroundColor: AppColors.redColor.withOpacity(0.9),
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.whiteColor,
          foregroundColor: AppColors.brownColor,
          elevation: 0,
        ),
        bottomAppBarColor: Colors.transparent);
  }

  ThemeData darkMode() {
    return ThemeData(
        textTheme: TextTheme(
          headline1: GoogleFonts.nunito(),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.whiteColor,
          foregroundColor: AppColors.brownColor,
          elevation: 0,
        ));
  }
}
