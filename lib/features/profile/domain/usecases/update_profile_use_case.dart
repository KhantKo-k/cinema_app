import 'package:cinema_app/core/error/failure.dart';
import 'package:cinema_app/features/profile/domain/entity/profile_entity.dart';
import 'package:cinema_app/features/profile/domain/repository/profile_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateProfileUseCase {
  final ProfileRepository repository;

  UpdateProfileUseCase({required this.repository});

  Future<Either<Failure, void>> call(ProfileEntity profile) async {
    return await repository.updateUserProfile(profile);
  }
}