import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AppTr {
  static String tr(
    String key, {
    List<String>? args,
    Map<String, String>? namedArgs,
  }) {
    final value = key.tr(
      args: args,
      namedArgs: namedArgs,
    );

    /// If translation missing
    if (value == key) {
      debugPrint("Missing translation: $key");
      return ".....";
    }

    return value;
  }
}