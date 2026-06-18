import 'package:cinema_app/core/localization/domain/usecase/get_translation_usecase.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class RemoteFallbackLoader extends AssetLoader {
  final GetTranslationUsecase getTranslationUsecase;

  RemoteFallbackLoader(this.getTranslationUsecase);

  @override
  Future<Map<String, dynamic>> load(String path, Locale locale) async {

    final result = await getTranslationUsecase(
      path: path,
      langCode: locale.languageCode,
    );

    return result.fold((failure) => {}, (data) => data);
  }
}
