
import 'package:cinema_app/core/error/failure.dart';
import 'package:cinema_app/features/seating/domain/entities/seat_entity.dart';
import 'package:cinema_app/features/seating/domain/repositories/theater_repository.dart';
import 'package:dartz/dartz.dart';

class WatchSeatUseCase {
  final TheaterRepository repository;
  const WatchSeatUseCase({required this.repository});

  Stream<Either<Failure, List<SeatEntity>>> call(String showtimeId) {
    return repository.watchSeats(showtimeId);
  }
}