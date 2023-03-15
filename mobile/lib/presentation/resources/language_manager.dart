// ignore_for_file: constant_identifier_names

import 'package:flutter/widgets.dart';

enum LanguageType { ENGLISH, ARABIC }

const String arabic = "ar";
const String english = "en";
const String assetPathLocalization = "assets/translation";

const Locale arabicLocal = Locale("ar", "EG");
const Locale englishLocal = Locale("en", "US");

extension LanguageTypeExtension on LanguageType {
  String getValue() {
    switch (this) {
      case LanguageType.ENGLISH:
        return english;

      case LanguageType.ARABIC:
        return arabic;
    }
  }
}
