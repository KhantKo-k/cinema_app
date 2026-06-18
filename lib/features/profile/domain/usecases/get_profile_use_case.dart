import 'package:cinema_app/core/error/failure.dart';
import 'package:cinema_app/features/profile/domain/entity/profile_entity.dart';
import 'package:cinema_app/features/profile/domain/repository/profile_repository.dart';
import 'package:dartz/dartz.dart';

class GetProfileUseCase {
  final ProfileRepository repository;

  GetProfileUseCase({required this.repository});

  Future<Either<Failure, ProfileEntity>> call(String userId) async {
    return await repository.getUserProfile(userId);
  }
}