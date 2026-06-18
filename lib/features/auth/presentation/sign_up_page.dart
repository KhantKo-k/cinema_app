import 'package:cinema_app/core/auth/bloc/auth_bloc.dart';
import 'package:cinema_app/core/auth/bloc/auth_event.dart';
import 'package:cinema_app/core/auth/bloc/auth_state.dart';
import 'package:cinema_app/core/di/service_locator.dart';
import 'package:cinema_app/core/navigation/app_router.dart';
import 'package:cinema_app/core/theme/app_color.dart';
import 'package:cinema_app/features/auth/routes.dart';
import 'package:cinema_app/shared/common_widgets/common_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<StatefulWidget> createState() => _SingUpPageState();
}

class _SingUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();

  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is LoginFail) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.failure.interpretation.message)),
            );
          }

          if (state is SignUpSuccess) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Sign Up Success!"),
                  content: const Text(
                    "Your account has been created. Please login.",
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        _navigateToLogin();
                      },
                      child: const Text('OK'),
                    ),
                  ],
                );
              },
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is SignUpLoading;
          return Stack(
            children: [
              Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: const Alignment(1.0, -0.1),
                    radius: 1.2,
                    colors: [
                      AppColors.electricBlue.withOpacity(0.6),
                      theme.colorScheme.surface,
                    ],
                  ),
                ),
                child: SafeArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: _buildSignUpForm(),
                  ),
                ),
              ),

              if (isLoading)
                Container(
                  color: Colors.black.withOpacity(0.6),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.electricBlue,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSignUpForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 140),
          const Text(
            'Create Account',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const Text(
            'Join the cinema community today.',
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),

          const SizedBox(height: 60),

          // Name Field
          CommonTextField(
            controller: _nameController,
            label: "Full Name",
            prefixIcon: Icons.person_outline_rounded,
            validator: (value) => value!.isEmpty ? "Enter your name" : null,
          ),
          const SizedBox(height: 20),

          CommonTextField(
            controller: _emailController,
            label: "Email Address",
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            validator: (value) => (value == null || !value.contains('@'))
                ? "Enter valid email"
                : null,
          ),
          const SizedBox(height: 20),

          CommonTextField(
            controller: _passwordController,
            label: "Password",
            prefixIcon: Icons.lock_outline,
            isPassword: true,
            obscureText: !_isPasswordVisible,
            onSuffixIconPressed: () =>
                setState(() => _isPasswordVisible = !_isPasswordVisible),
            validator: (value) => value!.length < 6 ? "Min 6 characters" : null,
          ),
          const SizedBox(height: 20),

          CommonTextField(
            controller: _phoneController,
            label: "Phone",
            prefixIcon: Icons.phone_callback,
            validator: (value) =>
                value!.length < 8 ? "Wrong phone number" : null,
          ),
          const SizedBox(height: 40),

          ElevatedButton(
            onPressed: _onSignUpPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.electricBlue,
              foregroundColor: Colors.black,
              minimumSize: const Size(double.infinity, 56),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text(
              'Sign Up',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(height: 24),

          Center(
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: RichText(
                text: TextSpan(
                  text: "Already have an account? ",
                  style: const TextStyle(color: Colors.grey),
                  children: [
                    TextSpan(
                      text: "Login",
                      style: TextStyle(
                        color: AppColors.electricBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onSignUpPressed() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    context.read<AuthBloc>().add(
      SignUpRequested(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        phone: _phoneController.text.trim(),
      ),
    );
  }

  void _navigateToLogin() {
    serviceLocator.get<AppRouter>().navigateToLogin();
  }
}
