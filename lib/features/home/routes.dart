import 'package:cinema_app/features/food/routes.dart';
import 'package:cinema_app/features/home/presentation/home_screen.dart';
import 'package:cinema_app/features/home/presentation/landing_screen.dart';
import 'package:cinema_app/features/movies/routes.dart';
import 'package:cinema_app/features/profile/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

final _movieNavigatorKey = GlobalKey<NavigatorState>();
final _foodNavigatorKey = GlobalKey<NavigatorState>();
final _profileNavigatorKey = GlobalKey<NavigatorState>();

class HomeRoutes {
  static const landing = '/';
  static const home = MoviesRoutes.movies;
  static const food = FoodRoutes.food;
  static const profile = ProfileRoutes.profile;

  static final routes = [
    GoRoute(path: landing, builder: (context, state) => const WelcomePage()),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return HomeScreen(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _movieNavigatorKey,
          routes: [
            ...MoviesRoutes.shellRoutes,
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _foodNavigatorKey,
          routes: [
           ...FoodRoutes.shellRoutes
          ]
        ),
        StatefulShellBranch(
          navigatorKey: _profileNavigatorKey,
          routes: [
            ...ProfileRoutes.shellRoutes,
            
          ]
        ),
      ],
    ),
  ];
}
