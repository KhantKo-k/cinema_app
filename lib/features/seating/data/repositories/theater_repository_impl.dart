import 'package:cinema_app/core/error/failure.dart';
import 'package:cinema_app/features/seating/data/datasources/theater_remote_datasource.dart';
import 'package:cinema_app/features/seating/domain/entities/seat_entity.dart';
import 'package:cinema_app/features/seating/domain/entities/seat_type_entity.dart';
import 'package:cinema_app/features/seating/domain/entities/theater_entity.dart';
import 'package:cinema_app/features/seating/domain/repositories/theater_repository.dart';
import 'package:dartz/dartz.dart';

class TheaterRepositoryImpl extends TheaterRepository {
  final TheaterRemoteDatasource datasource;

  TheaterRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, TheaterEntity>> getTheater(String theaterId) async {
    return await on(() async => datasource.getTheater(theaterId));
  }

  @override
  Future<Either<Failure, List<SeatTypeEntity>>> getSeatTypes() async {
    return await on(() async => datasource.getSeatTypes());
  }

 @override
  Stream<Either<Failure, List<SeatEntity>>> watchSeats(String showtimeId) {
    return onStream(() => datasource.watchSeats(showtimeId));
  }
}