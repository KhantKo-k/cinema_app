import 'package:cinema_app/core/auth/bloc/auth_bloc.dart';
import 'package:cinema_app/core/auth/bloc/auth_state.dart';
import 'package:cinema_app/core/debug/chucker_navigator_observers.dart'
    if (dart.vm.product) 'package:cinema_app/core/debug/empty_navigator_observers.dart';
import 'package:cinema_app/core/navigation/app_routes.dart';
import 'package:cinema_app/core/navigation/locale_refresh_notifier.dart';
import 'package:cinema_app/core/navigation/router_refresh_listenable.dart';
import 'package:cinema_app/features/auth/routes.dart';
import 'package:cinema_app/features/cinemas/routes.dart';
import 'package:cinema_app/features/home/routes.dart';
import 'package:cinema_app/features/movies/routes.dart';
import 'package:cinema_app/features/profile/routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppNavigatorKey {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static BuildContext get context => navigatorKey.currentContext!;
}

class AppRouter {
  final GoRouter router;

  AppRouter(AuthBloc authBloc, LocaleRefreshNotifier localeRefresh)
    : router = GoRouter(
        navigatorKey: AppNavigatorKey.navigatorKey,
        observers: debugNavigatorObservers(),
        initialLocation: AppRoutes.splash,
        refreshListenable: Listenable.merge([
          RouterRefreshListenable(authBloc.stream),
          localeRefresh,
        ]),
        routes: [
          AppRoutes.splashRoute,
          ...AuthRoutes.rotues,
          ...HomeRoutes.routes,
          ...MoviesRoutes.routes,
          ...CinemasRoutes.routes,
          ...ProfileRoutes.routes
        ],
        redirect: (context, state) {
          final authState = authBloc.state;
          final isAuthenticated = authState is Authenticated;

          if (kDebugMode) {
            debugPrint('current path: ${state.topRoute}');
          }

          if (state.fullPath == AppRoutes.splash) {
            return null;
          }

          if (!isAuthenticated && state.fullPath == AuthRoutes.signup) {
            return AuthRoutes.signup;
          }
          if (!isAuthenticated &&
              (state.fullPath != HomeRoutes.landing &&
                  state.fullPath != AuthRoutes.login)) {
            if (kDebugMode) debugPrint('Not authenticated, redirecting to landing');
            return HomeRoutes.landing;
          }
          if (state.topRoute?.path == AuthRoutes.login && isAuthenticated) {
            if (kDebugMode) debugPrint('Login success, redirecting to home');
            return HomeRoutes.home;
          }
          return null;
        },
      );
}
