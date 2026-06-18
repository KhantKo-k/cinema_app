import 'package:cinema_app/core/error/failure.dart';
import 'package:cinema_app/features/seating/domain/entities/theater_entity.dart';
import 'package:cinema_app/features/seating/domain/repositories/theater_repository.dart';
import 'package:dartz/dartz.dart';

class GetTheaterUseCase {
  final TheaterRepository repository;

  GetTheaterUseCase({required this.repository});

  Future<Either<Failure, TheaterEntity>> call(String theaterId) async {
    return await repository.getTheater(theaterId);
  }
}