import 'package:cinema_app/core/base/repository.dart';
import 'package:cinema_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class LocalizationRepository extends Repository{

  Future<Either<Failure, Map<String, dynamic>>> getTranslations({
    required String path,
    required String langCode,
  });
}