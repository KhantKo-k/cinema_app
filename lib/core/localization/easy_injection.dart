

// import 'package:cinema_app/core/di/service_locator.dart';
// import 'package:cinema_app/core/localization/cache/translation_cache_manager.dart';
// import 'package:cinema_app/core/localization/data/datasources/local_translation_datasource.dart';
// import 'package:cinema_app/core/localization/data/datasources/remote_translation_datasource.dart';
// import 'package:cinema_app/core/localization/data/repositories/localization_repository_impl.dart';
// import 'package:cinema_app/core/localization/domain/repositories/localization_repository.dart';
// import 'package:cinema_app/core/localization/domain/usecase/get_translation_usecase.dart';
// import 'package:cinema_app/core/localization/presentation/fall_back_loader.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';


// void injectEasyInjectionDatasources() {
//   serviceLocator.registerLazySingleton<RemoteTranslationDatasource>(
//     RemoteTranslationDatasourceImpl.new,
//   );

//   serviceLocator.registerLazySingleton<LocalTranslationDatasource>(
//     LocalTranslationDatasourceImpl.new,
//   );

//   serviceLocator.registerLazySingleton(() => TranslationCacheManager());
// }

// void injectEasyRepository(Ref ref) {
//   serviceLocator.registerLazySingleton<LocalizationRepository>(
//     () => LocalizationRepositoryImpl(
//       remote: serviceLocator(),
//       local: serviceLocator(),
//       cacheManager: serviceLocator(),
//       ref: ref,
//     ),
//   );
// }
// void injectEasyUseCase(){
//   serviceLocator.registerLazySingleton<GetTranslationUsecase>(
//     () => GetTranslationUsecase(serviceLocator<LocalizationRepository>())
//   );
// }

// void injectEasyLoader() {
//   serviceLocator.registerLazySingleton<RemoteFallbackLoader>(
//     () => RemoteFallbackLoader(
//      // serviceLocator<LocalizationRepository>(), 
//       serviceLocator<GetTranslationUsecase>()),
//   );
// }

