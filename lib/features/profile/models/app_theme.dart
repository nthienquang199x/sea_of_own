import 'package:app_base/core/localization/app_locale.dart';

enum AppTheme {
  system,
  dark,
  light;

  String get name {
    switch (this) {
      case AppTheme.system:
        return AppLocale.system;
      case AppTheme.dark:
        return AppLocale.always_dark;
      case AppTheme.light:
        return AppLocale.always_light;
    }
  }
}
