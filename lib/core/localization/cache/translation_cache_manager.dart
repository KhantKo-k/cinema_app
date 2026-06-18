import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TranslationCacheManager {
  static const String _lastFetchKey = 'translations_last_fetch';


  Future<File> _getFile(String lang) async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/translations_$lang.json');
  }

   Future<Map<String, dynamic>?> read(String lang) async {
    try {
      final file = await _getFile(lang);
      if (!await file.exists()) return null;

      final content = await file.readAsString();
      return json.decode(content);
    } catch (_) {
      return null;
    }
  }

  Future<void> write(String lang, Map<String, dynamic> data) async {
    final file = await _getFile(lang);
    await file.writeAsString(json.encode(data));
  }

  Future<void> saveLastFetch(String lang) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(
      _lastFetchKey + lang,
      DateTime.now().millisecondsSinceEpoch,
    );
  }

  Future<int?> getLastFetch(String lang) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_lastFetchKey + lang);
  }

  Future<bool> shouldRefresh(String lang, {int hours = 24}) async {
    final lastFetch = await getLastFetch(lang);
    if (lastFetch == null) return true;

    final last = DateTime.fromMillisecondsSinceEpoch(lastFetch);
    final now = DateTime.now();
    return now.difference(last).inHours >= hours;
  }
}
