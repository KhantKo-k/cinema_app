import 'dart:convert';

import 'package:flutter/services.dart';

abstract class LocalTranslationDatasource {
  Future<Map<String, dynamic>> loadLocal(String path, String lang);
}

class LocalTranslationDatasourceImpl implements LocalTranslationDatasource{
  const LocalTranslationDatasourceImpl();

  @override
  Future<Map<String, dynamic>> loadLocal(String path, String lang) async {
    final jsonStr = await rootBundle.loadString('$path/$lang.json');
    return json.decode(jsonStr);
  }
}

