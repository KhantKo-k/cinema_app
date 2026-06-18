import 'package:cinema_app/core/error/failure.dart';
import 'package:cinema_app/features/cinemas/data/datasources/showtime_remote_datasource.dart';
import 'package:cinema_app/features/cinemas/domain/entities/showtime_entity.dart';
import 'package:cinema_app/features/cinemas/domain/repository/showtime_repository.dart';
import 'package:dartz/dartz.dart';

class ShowtimeRepositoryImpl extends ShowtimeRepository{
  final ShowtimeRemoteDatasource datasource;

  ShowtimeRepositoryImpl({required this.datasource});


  @override
  Future<Either<Failure, List<ShowtimeEntity>>> getShowtimes(String movieId, String cinemaId) async {
    return await on(() async => datasource.getShowtimes(movieId, cinemaId));
  }
}

