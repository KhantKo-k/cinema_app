import 'package:cinema_app/core/error/failure.dart';
import 'package:cinema_app/features/booking/data/datasource/booking_remote_datasource.dart';
import 'package:cinema_app/features/booking/domain/entity/order_entity.dart';
import 'package:cinema_app/features/booking/domain/repository/booking_repository.dart';
import 'package:dartz/dartz.dart';

class BookingRepositoryImpl extends BookingRepository {
  final BookingRemoteDatasource datasource;
  BookingRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, String>> bookSeats(
    String showtimeId,
    List<String> seats,
  ) async {
    return await on(
      () async => await datasource.createOrder(
        showtimeId: showtimeId,
        selectedSeats: seats,
        action: OrderAction.book,
      ),
    );
  }

  @override
  Future<Either<Failure, String>> buySeats(
    String showtimeId,
    List<String> seats,
  ) async {
    return await on(
      () async => await datasource.createOrder(
        showtimeId: showtimeId,
        selectedSeats: seats,
        action: OrderAction.buy,
      ),
    );
  }

  @override
  Future<Either<Failure, List<OrderEntity>>> getUserOrders(
    String userId,
  ) async {
    return await on(() async => await datasource.fetchUserOrders(userId));
  }
}
