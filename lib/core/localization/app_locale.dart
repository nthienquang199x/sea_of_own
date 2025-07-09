// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

final FlutterLocalization localization = FlutterLocalization.instance;

enum AppLanguage {
  en;

  String get languageCode {
    switch (this) {
      case AppLanguage.en:
        return "en";
    }
  }

  MapLocale get defaultLocale {
    switch (this) {
      case AppLanguage.en:
        return MapLocale(languageCode, AppLocale.EN, countryCode: "US");
    }
  }
}

extension StringExt on String {
  String tr(BuildContext context) {
    return getString(context);
  }
}

mixin class AppLocale {
  static const Map<String, dynamic> EN = {
    "curated_objects_worth_keeping":
        "Curated objects worth keeping,\nfor those who seek better.",
    "newly_added": "Newly Added",
    "tech_audio": "Tech & Audio",
    "tools": "Tools",
    "work": "Work",
    "home": "Home",
    "personal": "Personal",
    "craft": "Craft",
    "browse_by_categories": "Browse by Categories",
    "browse_by_spaces": "Browse by Spaces",
  };

  static const String curated_objects_worth_keeping =
      "curated_objects_worth_keeping";
  static const String newly_added = "newly_added";
  static const String tech_audio = "tech_audio";
  static const String tools = "tools";
  static const String work = "work";
  static const String home = "home";
  static const String personal = "personal";
  static const String craft = "craft";
  static const String browse_by_categories = "browse_by_categories";
  static const String browse_by_spaces = "browse_by_spaces";

  void init(
      {required List<MapLocale> mapLocales,
      AppLanguage initLanguage = AppLanguage.en}) {
    localization.onTranslatedLanguage = onTranslatedLanguage;
    localization.init(
        mapLocales: mapLocales, initLanguageCode: initLanguage.languageCode);
  }

  void onTranslatedLanguage(Locale? locale) {}
}
