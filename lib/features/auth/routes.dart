
import 'package:cinema_app/core/navigation/app_router.dart';
import 'package:cinema_app/features/auth/presentation/login_page.dart';
import 'package:cinema_app/features/auth/presentation/sign_up_page.dart';
import 'package:go_router/go_router.dart';

class AuthRoutes{
  static const login = '/login';
  static const signup = '/signup';

  static final rotues = [
    GoRoute(
      path: login,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: signup,
      builder: (context, state) => const SignUpPage(),
    )
  ];
}

extension AuthRoutesExtension on AppRouter{
  void navigateToLogin(){
    router.go(AuthRoutes.login);
  }

  void navigateToSignUp(){
    router.push(AuthRoutes.signup);
  }
}