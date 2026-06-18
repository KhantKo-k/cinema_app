import 'package:cinema_app/core/base/repository.dart';
import 'package:cinema_app/core/error/failure.dart';
import 'package:cinema_app/features/cinemas/domain/entities/cinema_entity.dart';
import 'package:dartz/dartz.dart';

abstract class CinemaRepository extends Repository{
  Future<Either<Failure, List<CinemaEntity>>> getCinemaByMovie(String id);
}