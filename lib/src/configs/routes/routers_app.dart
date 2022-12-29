import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:it_project/main.dart';
import 'package:it_project/src/configs/routes/routes_name_app.dart';
import 'package:it_project/src/features/app/fuser_local.dart';
import 'routes_page_app.dart';

class AppRouter {
  const AppRouter();

  GoRouter get router => GoRouter(
        initialLocation: Paths.mainScreen,
        routes: AppPages.pages,
        debugLogDiagnostics: true,
        navigatorKey: navigatorKey,
        redirect: (context, state) => _redirect(context, state),
      );

  _redirect(BuildContext context, GoRouterState state) {
    final isNeedAuthenticatePage = AppPages.needAuthenticatedPages.contains(
      state.location,
    );
    final isSigned = getIt<FUserLocal>().isLogged;
    if ((isSigned == false) & (isNeedAuthenticatePage == true)) {
      return Paths.loginScreen;
    }
    return null;
  }
}
