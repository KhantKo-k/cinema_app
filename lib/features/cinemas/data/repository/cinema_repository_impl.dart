import 'package:cinema_app/core/error/failure.dart';
import 'package:cinema_app/features/cinemas/data/datasources/cinema_remote_datasource.dart';
import 'package:cinema_app/features/cinemas/domain/entities/cinema_entity.dart';
import 'package:cinema_app/features/cinemas/domain/repository/cinema_repository.dart';
import 'package:dartz/dartz.dart';

class CinemaRepositoryImpl extends CinemaRepository{
  final CinemaRemoteDatasource datasource;

  CinemaRepositoryImpl({required this.datasource});


  @override
  Future<Either<Failure, List<CinemaEntity>>> getCinemaByMovie(String id) async {
    return await on(() async => datasource.getCinemaByMovie(id));
  }
}
