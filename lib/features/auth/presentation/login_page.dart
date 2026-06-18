import 'package:cinema_app/core/auth/bloc/auth_bloc.dart';
import 'package:cinema_app/core/auth/bloc/auth_event.dart';
import 'package:cinema_app/core/auth/bloc/auth_state.dart';
import 'package:cinema_app/core/di/service_locator.dart';
import 'package:cinema_app/core/navigation/app_router.dart';
import 'package:cinema_app/core/theme/app_color.dart';
import 'package:cinema_app/features/auth/presentation/google_sign_in.dart';
import 'package:cinema_app/features/auth/routes.dart';
import 'package:cinema_app/shared/common_widgets/common_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
        LoginRequested(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      // backgroundColor: theme.colorScheme.surface,
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          final isLoading = state is LoginLoading;

          return Stack(
            children: [
              _buildLoginUI(theme),
              if (isLoading) _buildLoadingOverlay(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLoginUI(ThemeData theme) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoginFail) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.failure.interpretation.message)),
          );
          return;
        }
      },

      child: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topLeft,
            radius: 1.5,
            colors: [
              AppColors.electricBlue.withOpacity(0.55),
              theme.colorScheme.surface,
            ],
            stops: <double>[0.4, 1.0],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: _buildForm(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingOverlay() {
    return AbsorbPointer(
      absorbing: true,
      child: Container(
        color: Colors.black.withOpacity(0.5),
        child: const Center(
          child: CircularProgressIndicator(color: AppColors.electricBlue),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Icon(
              Icons.movie_filter_rounded,
              size: 80,
              color: AppColors.deepSpace,
            ),
          ),
          const SizedBox(height: 24),

          _buildWelcomeText(),
          const SizedBox(height: 40),

          _buildEmailTextField(),
          const SizedBox(height: 20),

          _buildPasswordTextField(),
          _buildForgotPassword(),

          const SizedBox(height: 40),

          _buildLoginButton(),

          const SizedBox(height: 20),
          Center(child: Text("or", style: TextStyle(fontSize: 16))),
          const SizedBox(height: 20),
          GoogleSignInButton(),

          const SizedBox(height: 32),
          _buildSignUpLink(),
        ],
      ),
    );
  }

  Widget _buildWelcomeText() {
    return Column(
      children: [
        Text(
          'Welcome Back',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            // color: theme.colorScheme.onSurface,
          ),
        ),
        const Text('Login to book your next premiere.'),
      ],
    );
  }

  Widget _buildEmailTextField() {
    return CommonTextField(
      controller: _emailController,
      label: "Email Address",
      prefixIcon: Icons.email_outlined,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Email is required";
        }

        if (!value.contains('@')) {
          return "Enter a valid email";
        }
        return null;
      },
    );
  }

  Widget _buildPasswordTextField() {
    return CommonTextField(
      controller: _passwordController,
      label: "Password",
      prefixIcon: Icons.lock_outline,
      isPassword: true,
      obscureText: !_isPasswordVisible,
      onSuffixIconPressed: () {
        setState(() {
          _isPasswordVisible = !_isPasswordVisible;
        });
      },
      validator: (value) {
        if (value == null || value.length < 6) {
          return "Min 6 characters";
        }

        return null;
      },
    );
  }

  Widget _buildLoginButton() {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final isLoading = state is LoginLoading;
        return ElevatedButton(
          onPressed: isLoading ? null : _onLoginPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.electricBlue,
            foregroundColor: Colors.black,
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: const Text(
            'Login',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }

  Widget _buildForgotPassword() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {},
        child: const Text(
          'Forget Password?',
          style: TextStyle(
            color: AppColors.electricBlue,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account? "),
        GestureDetector(
          onTap: () {
            _navigateToSignUp();
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(
              color: AppColors.electricBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  void _navigateToSignUp(){
    serviceLocator.get<AppRouter>().navigateToSignUp();
  }
}
