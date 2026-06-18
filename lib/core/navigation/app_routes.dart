import 'package:cinema_app/features/home/presentation/splash_screen.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static const splash = '/splash';

  static final splashRoute = GoRoute(
    path: splash,
    builder: (context, state) => const SplashPage(),
  );
}