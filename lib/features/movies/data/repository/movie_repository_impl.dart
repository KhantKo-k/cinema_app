import 'package:cinema_app/core/error/failure.dart';
import 'package:cinema_app/features/movies/data/datasources/movie_remote_datasource.dart';
import 'package:cinema_app/features/movies/domain/entities/movie_entity.dart';
import 'package:cinema_app/features/movies/domain/repository/movie_repository.dart';
import 'package:dartz/dartz.dart';

class MovieRepositoryImpl extends MovieRepository{
  final MovieRemoteDatasource datasource;

  MovieRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure,List<MovieEntity>>> getMovies() async {
    return await on(() async => datasource.getMovies());
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> getUpcomingMovies() async {
    return await on(() async => datasource.getUpcomingMovies());
  }
}