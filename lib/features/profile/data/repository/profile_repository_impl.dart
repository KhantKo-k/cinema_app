import 'package:cinema_app/core/error/failure.dart';
import 'package:cinema_app/features/profile/data/datasource/profile_remote_datasource.dart';
import 'package:cinema_app/features/profile/data/model/profile_model.dart';
import 'package:cinema_app/features/profile/domain/entity/profile_entity.dart';
import 'package:cinema_app/features/profile/domain/repository/profile_repository.dart';
import 'package:dartz/dartz.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  final ProfileRemoteDatasource datasource;

  ProfileRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, ProfileEntity>> getUserProfile(String userId) async {
    return await on(() async => await datasource.getProfile(userId));
  }

  @override
  Future<Either<Failure, void>> updateUserProfile(ProfileEntity profile) async {
    return await on(
      () async => await datasource.updateProfile(profile as ProfileModel),
    );
  }
}
