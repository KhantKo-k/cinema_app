import 'package:cinema_app/core/error/failure.dart';
import 'package:cinema_app/core/localization/domain/repositories/localization_repository.dart';
import 'package:dartz/dartz.dart';

class GetTranslationUsecase {
  final LocalizationRepository repository;
  const GetTranslationUsecase(this.repository);

  
   Future<Either<Failure, Map<String, dynamic>>> call({
    required String path,
    required String langCode,
  }) async {
    return await repository.getTranslations(path: path, langCode: langCode);
  }
}