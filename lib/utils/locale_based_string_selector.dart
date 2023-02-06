import 'package:flutter/material.dart';

// select between 2 strings based on locale

class LocaleBasedStringSelector {
  static String select(BuildContext context, String arString, String enString) {
    Locale myLocale = Localizations.localeOf(context);
    String languageCode = myLocale.languageCode;
    bool isArabic = languageCode == "ar";
    if (isArabic) {
      return arString;
    } else {
      return enString;
    }
  }
}
