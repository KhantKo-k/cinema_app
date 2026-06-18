import 'package:cinema_app/core/base/repository.dart';
import 'package:cinema_app/core/error/failure.dart';
import 'package:cinema_app/features/movies/domain/entities/movie_entity.dart';
import 'package:dartz/dartz.dart';

abstract class MovieRepository extends Repository{
  Future<Either<Failure, List<MovieEntity>>> getMovies();
  Future<Either<Failure, List<MovieEntity>>> getUpcomingMovies();
}