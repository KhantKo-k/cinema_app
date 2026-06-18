
import 'package:cinema_app/core/error/failure.dart';
import 'package:cinema_app/features/booking/domain/entity/order_entity.dart';
import 'package:cinema_app/features/booking/domain/repository/booking_repository.dart';
import 'package:dartz/dartz.dart';

class GetOrdersUseCase {
  final BookingRepository repository;

  const GetOrdersUseCase({required this.repository});

  Future<Either<Failure, List<OrderEntity>>> call(String userId) async {
    return await repository.getUserOrders(userId);
  }
}