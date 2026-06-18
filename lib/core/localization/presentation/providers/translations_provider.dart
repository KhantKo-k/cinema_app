import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TranslationState {
  final int version;
  final Locale locale;

  const TranslationState({
    required this.version,
    required this.locale,
  });

  TranslationState copyWith({
    int? version,
    Locale? locale,
  }) {
    return TranslationState(
      version: version ?? this.version,
      locale: locale ?? this.locale,
    );
  }
}

class TranslationNotifier extends StateNotifier<TranslationState> {
  TranslationNotifier()
      : super(const TranslationState(
          version: 0,
          locale: Locale('en'),
        ));

  void increment() {
    state = state.copyWith(version: state.version + 1);
  }

  void setLocale(Locale locale) {
    state = state.copyWith(locale: locale);
  }
}

final translationProvider =
    StateNotifierProvider<TranslationNotifier, TranslationState>((ref) {
  return TranslationNotifier();
});