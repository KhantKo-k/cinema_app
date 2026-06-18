import 'package:cinema_app/core/error/failure.dart';
import 'package:cinema_app/features/seating/domain/entities/seat_type_entity.dart';
import 'package:cinema_app/features/seating/domain/repositories/theater_repository.dart';
import 'package:dartz/dartz.dart';

class GetSeatTypeUseCase {
  final TheaterRepository repository;
  const GetSeatTypeUseCase({required this.repository});

  Future<Either<Failure, List<SeatTypeEntity>>> call() async {
    return await repository.getSeatTypes();
  }
}