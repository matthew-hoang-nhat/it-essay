import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/main.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/configs/routes/routers_app.dart';
import 'package:it_project/src/features/main/home/cubit/home_cubit.dart';
import 'package:it_project/src/features/search/cubit/search_cubit.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final router = getIt<AppRouter>().router;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SearchCubit()),
        BlocProvider(create: (context) => HomeCubit()),
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
