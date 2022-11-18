import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/main.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/configs/routes/routers_app.dart';
import 'package:it_project/src/features/app/cubit/app_cubit.dart';
import 'package:it_project/src/features/main/cubit/main_cubit.dart';
import 'package:it_project/src/features/main/home/cubit/home_cubit.dart';
import 'package:it_project/src/features/search/cubit/search_cubit.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final router = getIt<AppRouter>().router;
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppCubit()..initCubit()),
        BlocProvider(create: (context) => SearchCubit()),
        BlocProvider(create: (context) => HomeCubit()..initCubit()),
        BlocProvider(create: (context) => MainCubit()..reloadMainScreen()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: lightMode(),
        routerConfig: router,
      ),
    );
  }

  ThemeData lightMode() {
    return ThemeData(
        textTheme: GoogleFonts.nunitoTextTheme(),
        scaffoldBackgroundColor: AppColors.whiteColor,
        // backgroundColor: AppColors.redColor.withOpacity(0.9),

        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.whiteColor,
          foregroundColor: AppColors.brownColor,
          elevation: 0,
          titleTextStyle: GoogleFonts.nunito(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
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
