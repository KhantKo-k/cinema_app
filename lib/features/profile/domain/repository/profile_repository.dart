import 'package:cinema_app/core/base/repository.dart';
import 'package:cinema_app/core/error/failure.dart';
import 'package:cinema_app/features/profile/domain/entity/profile_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ProfileRepository extends Repository{
  Future<Either<Failure, ProfileEntity>> getUserProfile(String userId);
  Future<Either<Failure, void>> updateUserProfile(ProfileEntity profile);
}