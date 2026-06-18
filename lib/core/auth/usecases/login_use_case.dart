
import 'package:cinema_app/core/auth/model/user_auth_model.dart';
import 'package:cinema_app/core/auth/repositories/auth_repository.dart';
import 'package:cinema_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase({required this.repository});

  Future<Either<Failure, UserAuthModel>> call( 
    String userName, String password
  ) async {
    return await repository.login(userName, password);
  }
} 