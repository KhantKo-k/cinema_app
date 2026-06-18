
import 'package:cinema_app/core/auth/model/user_auth_model.dart';
import 'package:cinema_app/core/auth/repositories/auth_repository.dart';
import 'package:cinema_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';

class SignUpUseCase {
  final AuthRepository repository;

  SignUpUseCase({required this.repository});

  Future<Either<Failure, UserAuthModel>> call( 
    String userName, 
    String email,
    String password,
    String phone,
  ) async {
    return await repository.signUp(
      userName, 
      email,
      password,
      phone,
    );
  }
} 