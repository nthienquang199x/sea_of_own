import 'package:app_base/core/localization/app_locale.dart';

enum SettingsType {
  editProfile,
  theme,
  logout,
  deleteAccount,
  privacyPolicy,
  termsOfService,
  sendUsYourFeedback;

  String get title {
    switch (this) {
      case SettingsType.editProfile:
        return AppLocale.edit_profile;
      case SettingsType.theme:
        return AppLocale.theme;
      case SettingsType.logout:
        return AppLocale.logout;
      case SettingsType.deleteAccount:
        return AppLocale.delete_account;
      case SettingsType.privacyPolicy:
        return AppLocale.privacy_policy;
      case SettingsType.termsOfService:
        return AppLocale.terms_of_service;
      case SettingsType.sendUsYourFeedback:
        return AppLocale.send_us_your_feedback;
    }
  }

  String? get subtitle {
    switch (this) {
      case SettingsType.editProfile:
        return null;
      case SettingsType.theme:
        return AppLocale.system;
      case SettingsType.logout:
      case SettingsType.deleteAccount:
      case SettingsType.privacyPolicy:
      case SettingsType.termsOfService:
      case SettingsType.sendUsYourFeedback:
        return null;
    }
  }
}
