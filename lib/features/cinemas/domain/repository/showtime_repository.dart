import 'package:cinema_app/core/base/repository.dart';
import 'package:cinema_app/core/error/failure.dart';
import 'package:cinema_app/features/cinemas/domain/entities/showtime_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ShowtimeRepository extends Repository{
  Future<Either<Failure, List<ShowtimeEntity>>> getShowtimes(String movieId, String cinemaId);
}
