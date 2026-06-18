import 'dart:async';

import 'package:cinema_app/core/error/failure.dart';
import 'package:cinema_app/core/localization/cache/translation_cache_manager.dart';
import 'package:cinema_app/core/localization/data/datasources/local_translation_datasource.dart';
import 'package:cinema_app/core/localization/data/datasources/remote_translation_datasource.dart';
import 'package:cinema_app/core/localization/domain/repositories/localization_repository.dart';
import 'package:cinema_app/core/localization/presentation/providers/translations_provider.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocalizationRepositoryImpl extends LocalizationRepository {
  final RemoteTranslationDatasource remote;
  final LocalTranslationDatasource local;
  final TranslationCacheManager cacheManager;
  final Ref ref;

  LocalizationRepositoryImpl({
    required this.remote,
    required this.local,
    required this.cacheManager,
    required this.ref,
  });
  @override
  Future<Either<Failure, Map<String, dynamic>>> getTranslations({
    required String path,
    required String langCode,
  }) async {
    return await on(() async {
      Map<String, dynamic>? diskCache = await cacheManager.read(langCode);

      if (diskCache != null) {
        _refreshInBackground(langCode);
        return diskCache;
      }

      final localJson = await local.loadLocal(path, langCode);

      _downloadAndCache(langCode);

      return localJson;
    });
  }

  Future<void> _refreshInBackground(String langCode) async {
    final shouldRefresh = await cacheManager.shouldRefresh(langCode, hours: 24);
    if (!shouldRefresh) return;

    await _fetchAndUpdate(langCode);
  }

  Future<void> _downloadAndCache(String langCode) async {
    await _fetchAndUpdate(langCode);
  }

  Future<void> _fetchAndUpdate(String langCode) async {
    try {
      final remoteJson = await remote.fetchTranslations(langCode);
      if (remoteJson == null) return;

      final oldCache = await cacheManager.read(langCode);
      await cacheManager.write(langCode, remoteJson);
      await cacheManager.saveLastFetch(langCode);

      if (oldCache == null || !mapEquals(oldCache, remoteJson)) {
        if (kDebugMode) debugPrint('Translation cache updated for $langCode');
        ref.read(translationProvider.notifier).increment();
        ref.read(translationProvider.notifier).setLocale( Locale(langCode));
      }
    } catch (e) {
      if (kDebugMode) debugPrint('Translation update failed: $e');
    }
  }
}

        // if (diskCache == null) {
      //   return await fetchTranslationFromRemote(langCode, diskCache, path);
      // }

      // final shouldRefresh = await cacheManager.shouldRefresh(
      //   langCode,
      //   hours: 24,
      // );
      // if (shouldRefresh) {
      //   return await fetchTranslationFromRemote(langCode, diskCache, path);
      // } else {
      //   return diskCache;
      // }
  // Future<Map<String, dynamic>> fetchTranslationFromRemote(
  //   String langCode,
  //   Map<String, dynamic>? diskCache,
  //   String path,
  // ) async {
  //   try {
  //     final remoteJson = await remote.fetchTranslations(langCode);
  //     await cacheManager.write(langCode, remoteJson!);
  //     await cacheManager.saveLastFetch(langCode);
  //     diskCache = await cacheManager.read(langCode);
  //     return diskCache!;
  //   } catch (_) {
  //     final localJson = await local.loadLocal(path, langCode);
  //     return localJson;
  //   }
  // }

  // final shouldRefresh = await cacheManager.shouldRefresh(
  //   langCode,
  //   hours: 24,
  // );
  // if (shouldRefresh) {
  //   _fetchTranslations(path, langCode);
  // }
  // Future<void> _fetchTranslations(String path, String lang) async {
  //   try {
  //     final remoteJson = await remote.fetchTranslations(lang);
  //     if (remoteJson == null) return;

  //     await cacheManager.write(lang, remoteJson);

  //     await cacheManager.saveLastFetch(lang);
  //   } catch (_) {}
  // }

  // Map<String, dynamic> _deepMerge(
  //   Map<String, dynamic> base,
  //   Map<String, dynamic> override,
  // ) {
  //   final result = Map<String, dynamic>.from(base);
  //   override.forEach((key, value) {
  //     if (value is Map && base[key] is Map) {
  //       result[key] = _deepMerge(
  //         Map<String, dynamic>.from(base[key]),
  //         Map<String, dynamic>.from(value),
  //       );
  //     } else {
  //       result[key] = value;
  //     }
  //   });

  //   return result;
  // }

    // final cache = await cacheManager.read(langCode);
    //   if(cache != null) {
    //     _refreshInBackground(langCode);
    //     return cache;
    //   }

    //   return await _fetchFromRemoteOrLocal(langCode, path);


 // Future<Map<String, dynamic>> _fetchFromRemoteOrLocal( 
  //   String langCode,
  //   String path,
  // ) async {
  //   final remoteData = await remote.fetchTranslations(langCode);

  //   if(remoteData != null) {
  //     await cacheManager.write(langCode, remoteData);
  //     await cacheManager.saveLastFetch(langCode);
  //     return remoteData;
  //   }

  //   return await local.loadLocal(path, langCode);
  // }

  // void _refreshInBackground(String langCode) async {
  //   final shouldRefresh = await cacheManager.shouldRefresh(
  //     langCode,
  //     hours: 24,
  //   );

  //   if(!shouldRefresh) return;

  //   final remoteData = await remote.fetchTranslations(langCode);

  //   if(remoteData!= null) {
  //     await cacheManager.write(langCode, remoteData);
  //     await cacheManager.saveLastFetch(langCode);
  //   }
  // }