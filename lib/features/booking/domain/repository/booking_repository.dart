import 'package:cinema_app/core/base/repository.dart';
import 'package:cinema_app/core/error/failure.dart';
import 'package:cinema_app/features/booking/domain/entity/order_entity.dart';
import 'package:dartz/dartz.dart';

abstract class BookingRepository extends Repository{
  Future<Either<Failure, String>> bookSeats(String showtimeId, List<String> seats);
  Future<Either<Failure, String>> buySeats(String showtimeId, List<String> seats);
  Future<Either<Failure, List<OrderEntity>>> getUserOrders(String userId);
}