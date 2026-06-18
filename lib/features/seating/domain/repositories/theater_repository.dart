import 'package:cinema_app/core/base/repository.dart';
import 'package:cinema_app/core/error/failure.dart';
import 'package:cinema_app/features/seating/domain/entities/seat_entity.dart';
import 'package:cinema_app/features/seating/domain/entities/seat_type_entity.dart';
import 'package:cinema_app/features/seating/domain/entities/theater_entity.dart';
import 'package:dartz/dartz.dart';

abstract class TheaterRepository extends Repository{
  Future<Either<Failure, TheaterEntity>> getTheater(String theaterId);
  Future<Either<Failure, List<SeatTypeEntity>>> getSeatTypes();
  Stream<Either<Failure, List<SeatEntity>>> watchSeats(String showtimeId);
}