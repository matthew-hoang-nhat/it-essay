import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/src/ui/base/bindings/main_binding.dart';
import 'package:it_project/src/ui/main_screen.dart';
import 'package:it_project/src/utils/app_pages.dart';

void main() {
  runApp(
    // DevicePreview(
    // builder: ((context) => const MyApp()),
    const MyApp(),
    // )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.nunitoTextTheme(),
      ),
      getPages: AppPages.pages,
      home: const MainScreen(),

      initialBinding: MainBinding(),
      // home: const LoginScreen(),
    );
  }
}
