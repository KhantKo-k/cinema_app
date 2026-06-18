import 'package:cinema_app/core/auth/bloc/auth_bloc.dart';
import 'package:cinema_app/core/auth/bloc/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    context.read<AuthBloc>().add(AppStarted());

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        context.go('/'); // trigger redirect
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: SizedBox(
          height: 250, // Force a size
          width: 250,

          child: Lottie.asset('assets/Untitled_file.json'),
        ),
      ),
    );
  }
}
