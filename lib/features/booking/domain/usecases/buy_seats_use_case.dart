
import 'package:cinema_app/core/error/failure.dart';
import 'package:cinema_app/features/booking/domain/repository/booking_repository.dart';
import 'package:dartz/dartz.dart';

class BuySeatsUseCase {
  final BookingRepository repository;

  const BuySeatsUseCase({required this.repository});

  Future<Either<Failure, String>> call(String showtimeId, List<String> seats) async {
    return await repository.buySeats(showtimeId, seats);
  }
}