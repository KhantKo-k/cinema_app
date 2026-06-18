import 'package:cinema_app/core/auth/bloc/auth_bloc.dart';
import 'package:cinema_app/core/auth/bloc/auth_event.dart';
import 'package:cinema_app/core/auth/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final isLoading = state is LoginLoading; 

        return ElevatedButton(
          onPressed: isLoading ? null : () => _handleGoogleSignIn(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey.shade200,
            foregroundColor: Colors.black87,
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child:
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/google.png', width: 32,),
                    const SizedBox(width: 12),
                    const Text(
                      "Continue with Google",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
        );
      },
    );
  }

  void _handleGoogleSignIn(BuildContext context) {
    context.read<AuthBloc>().add(GoogleSignInRequested());
  }
}