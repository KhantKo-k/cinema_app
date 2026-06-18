
import 'package:cinema_app/core/error/failure.dart';
import 'package:cinema_app/features/booking/domain/repository/booking_repository.dart';
import 'package:dartz/dartz.dart';

class BookSeatsUseCase {
  final BookingRepository repository;

  const BookSeatsUseCase({required this.repository});

  Future<Either<Failure, String>> call(String showtimeId, List<String> seats) async {
    return await repository.bookSeats(showtimeId, seats);
  }
}