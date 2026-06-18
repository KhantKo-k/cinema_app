import 'package:cinema_app/core/di/service_locator.dart';
import 'package:cinema_app/core/navigation/app_router.dart';
import 'package:cinema_app/core/theme/app_color.dart';
import 'package:cinema_app/features/auth/routes.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Stack(
        children: [
          // 1. Background Image (Cinema Atmosphere)
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://images.unsplash.com/photo-1536440136628-849c177e76a1?q=80&w=1000'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Theme.of(context).colorScheme.surface.withOpacity(0.5),
                  Theme.of(context).colorScheme.surface, // The deep navy/black
                ],
                stops: const [0.0, 0.4, 0.7],
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Your Cinema,\nYour Way.",
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Experience the latest blockbusters in stunning 4K. Book tickets and snacks in seconds.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 40),

                  ElevatedButton(
                    onPressed: () {
                      _navigateToLogin();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.electricBlue,
                      foregroundColor: Colors.black, // Dark text on light blue
                      minimumSize: const Size(double.infinity, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 8,
                      shadowColor: Theme.of(context).colorScheme.primary.withOpacity(0.4),
                    ),
                    child: const Text(
                      "Get Started",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
  
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToLogin(){
    serviceLocator.get<AppRouter>().navigateToLogin();
  }
}