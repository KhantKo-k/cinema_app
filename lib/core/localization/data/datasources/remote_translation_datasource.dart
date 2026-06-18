import 'dart:convert';
import 'package:cinema_app/core/config/app_config.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

abstract class RemoteTranslationDatasource {
  Future<Map<String, dynamic>?> fetchTranslations(String lang);
}

class RemoteTranslationDatasourceImpl implements RemoteTranslationDatasource {
  const RemoteTranslationDatasourceImpl();

  @override
  Future<Map<String, dynamic>?> fetchTranslations(String lang) async {
    try {
      if (kDebugMode) {
        debugPrint('Fetching translations for $lang');
      }

      await Future.delayed(const Duration(milliseconds: 10000));

      final response = await http
          .get(Uri.parse('${AppConfig.translationsBaseUrl}/$lang.json'))
          .timeout(const Duration(seconds: 3));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
    } catch (_) {}
    return null;
  }
}
