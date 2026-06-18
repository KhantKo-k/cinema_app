

import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable{
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthEvent{
  
}

class LoginRequested extends AuthEvent{
  final String email;
  final String password;

  const LoginRequested({required this.email, required this.password});

  @override
  List<Object> get props => [email];
}

class SignUpRequested extends AuthEvent{
  final String name;
  final String email;
  final String password;
  final String phone;

  const SignUpRequested({required this.name,
  required this.email, 
  required this.password,
  required this.phone,
  });

  @override
  List<Object> get props => [name, email, phone];
}

class LogoutRequested extends AuthEvent{

}

class GoogleSignInRequested extends AuthEvent{
  
}