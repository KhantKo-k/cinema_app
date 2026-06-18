import 'package:cinema_app/core/auth/model/user_auth_model.dart';
import 'package:cinema_app/core/base/repository.dart';
import 'package:cinema_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository extends Repository{
  Future<Either<Failure, UserAuthModel>> login( 
    String userName, String password
  );

  Future<void> logout();

  Future<Either<Failure, UserAuthModel>> googleSignIn();

  Future<Either<Failure, UserAuthModel>> signUp( 
    String userName,
    String email,
    String password,
    String phone,
  );

  Future<Either<Failure, UserAuthModel?>> restoreSession();
}