import 'package:cinema_app/core/auth/model/user_auth_model.dart';
import 'package:cinema_app/core/auth/repositories/auth_repository.dart';
import 'package:cinema_app/core/error/failure.dart';
import 'package:cinema_app/features/auth/data/auth_remote_data_source.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl extends AuthRepository{
  final AuthRemoteDataSource dataSource;
  AuthRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, UserAuthModel>> login(
    String email, String password
  ) async {
    return await on(() async => await dataSource.login(email, password));
  }

  @override
  Future<void> logout() async {
    await dataSource.signOut();
  }

  @override
  Future<Either<Failure, UserAuthModel>> googleSignIn() async {
    return await on(() async => await dataSource.googleSignIn());
  }

  @override
  Future<Either<Failure, UserAuthModel>> signUp( 
    String userName, String email, String password, String phone
  ) async {
    return await on(() async => await dataSource.signUp(userName, email, password, phone));
  }

  @override
  Future<Either<Failure, UserAuthModel?>> restoreSession() async {
    return await on(() async => await dataSource.restoreSession());
  }
}