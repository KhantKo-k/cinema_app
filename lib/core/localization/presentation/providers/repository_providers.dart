import 'package:cinema_app/core/localization/cache/translation_cache_manager.dart';
import 'package:cinema_app/core/localization/data/datasources/local_translation_datasource.dart';
import 'package:cinema_app/core/localization/data/datasources/remote_translation_datasource.dart';
import 'package:cinema_app/core/localization/data/repositories/localization_repository_impl.dart';
import 'package:cinema_app/core/localization/domain/repositories/localization_repository.dart';
import 'package:cinema_app/core/localization/domain/usecase/get_translation_usecase.dart';
import 'package:cinema_app/core/localization/presentation/fall_back_loader.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'repository_providers.g.dart';

@riverpod
RemoteTranslationDatasource remoteTranslationDatasource(RemoteTranslationDatasourceRef ref) {
  return RemoteTranslationDatasourceImpl();
}

@riverpod
LocalTranslationDatasource localTranslationDatasource(LocalTranslationDatasourceRef ref) {
  return LocalTranslationDatasourceImpl();
}

@riverpod
TranslationCacheManager translationCacheManager(TranslationCacheManagerRef ref) {
  return TranslationCacheManager();
}

@riverpod
LocalizationRepository localizationRepository(LocalizationRepositoryRef ref) {
  return LocalizationRepositoryImpl(
    remote: ref.watch(remoteTranslationDatasourceProvider),
    local: ref.watch(localTranslationDatasourceProvider),
    cacheManager: ref.watch(translationCacheManagerProvider),
    ref: ref, // For triggering translation refresh
  );
}

@riverpod
GetTranslationUsecase getTranslationUsecase(GetTranslationUsecaseRef ref) {
  return GetTranslationUsecase(ref.watch(localizationRepositoryProvider));
}

@riverpod
RemoteFallbackLoader remoteFallbackLoader(RemoteFallbackLoaderRef ref) {
  return RemoteFallbackLoader(ref.watch(getTranslationUsecaseProvider));
}