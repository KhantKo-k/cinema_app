import 'package:flutter/foundation.dart';

/// Notifies [GoRouter] to refresh when the app locale changes so route widgets
/// rebuild and [easy_localization] `.tr()` picks up the new language.
class LocaleRefreshNotifier extends ChangeNotifier {
  void notifyLocaleChanged() => notifyListeners();
}
