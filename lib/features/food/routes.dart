import 'package:cinema_app/core/navigation/app_router.dart';
import 'package:cinema_app/features/food/presentation/food_page.dart';
import 'package:go_router/go_router.dart';

class FoodRoutes {
  static const String food = '/food';

  static final shellRoutes = [
    GoRoute(
      path: food,
      builder: (context, state) => const FoodPage(),
    ),
  ];
}

extension ProfileRoutesExtension on AppRouter{
  void naviagetToProfiel(){
    router.go(FoodRoutes.food);
  }
}