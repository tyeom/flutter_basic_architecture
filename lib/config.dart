import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// l10n\arb에서 문자열 지역화 를 정의.
/// Define string localization in l10n\arb.

enum Language { en, ko }

extension LanguageExtension on Language {
  String get code {
    switch (this) {
      case Language.en:
        return 'en';
      case Language.ko:
        return 'ko';
    }
  }

  Locale get locale => Locale(code);
}
