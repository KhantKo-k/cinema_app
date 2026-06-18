import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Centralized app configuration loaded from `.env` at startup.
///
/// Copy `.env.example` to `.env` and adjust values for your environment.
/// The `.env` file is gitignored and must not be committed.
class AppConfig {
  AppConfig._();

  static const _defaultTranslationsBaseUrl =
      'https://movie-ticket-app-5123f.web.app/translations';

  static Future<void> load() async {
    try {
      await dotenv.load(fileName: '.env');
    } catch (_) {
      // Falls back to defaults when `.env` is missing (copy from `.env.example`).
    }
  }

  static String get translationsBaseUrl =>
      dotenv.env['TRANSLATIONS_BASE_URL'] ?? _defaultTranslationsBaseUrl;
}
