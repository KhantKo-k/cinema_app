
import 'package:cinema_app/core/auth/model/user_auth_model.dart';
import 'package:cinema_app/core/error/failure.dart';
import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable{
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState{}

class LoginLoading extends AuthState{}

class SignUpLoading extends AuthState{}

class LoginFail extends AuthState{
  final Failure failure;

  const LoginFail({required this.failure});

  @override
  List<Object> get props => [failure];
}

class SignUpSuccess extends AuthState{
  final UserAuthModel userAuthModel;

  const SignUpSuccess({required this.userAuthModel});

  @override
  List<Object> get props => [userAuthModel];
}

class Authenticated extends AuthState{
  final UserAuthModel userAuthModel;

  const Authenticated({required this.userAuthModel});

  @override
  List<Object> get props => [userAuthModel];
}



class Unauthenticated extends AuthState{}