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
    "is_required": "This field is required",
    "must_be_at_least": "Must be at least",
    "characters": "characters",
    "theme": "Theme",
    "send_us_your_feedback": "Send us your feedback",
    "privacy_policy": "Privacy Policy",
    "terms_of_service": "Terms of Service",
    "logout": "Logout",
    "delete_account": "Delete Account",
    "system": "System",
    "edit_profile": "Edit Profile",
    "save_changes": "Save Changes",
    "change_password": "Change Password",
    "change_password_description":
        "Provide the following credentials to change the password. New password must be min 8 character long mixed with letters, numbers, and special characters.",
    "old_password": "Old Password",
    "new_password": "New Password",
    "create": "Create",
    "delete_account_description":
        "This will permanently remove your curated lists, profile, and all account data. This action cannot be undone. ",
    "app_theme": "App Theme",
    "always_dark": "Always Dark",
    "always_light": "Always Light",
    "logout_description":
        "Are you sure you would like to logout of the account?",
    "tell_us_why_you_decided_to_leave": "Tell us why you decided to leave",
    "confirm_delete": "Confirm Delete",
    "send_us_your_feedback_description":
        "We're building this for people like you. So share your honest thoughts, what's working, what isn't, or what you'd love to see.",
    "send_feedback": "Send Feedback",
    "please_explain_a_little_more": "Please explain a little more",
    "write_to_us": "Write to us",
    "not_enough_products": "Not enough products.",
    "no_products_found": "No products found.",
    "app_is_too_slow_or_has_bugs": "App is too slow or has bugs.",
    "found_a_better_alternative": "Found a better alternative.",
    "dont_use_discovery_apps_anymore": "Don't use discovery apps anymore.",
    "app_is_confusing_or_hard_to_use": "App is confusing or hard to use.",
    "other": "Other",
    "create_new_list": "Create new list",
    "add_a_name": "Add a name",
    "lowest_price": "Lowest Price",
    "highest_price": "Highest Price",
    "name_a_z": "Name A-Z",
    "name_z_a": "Name Z-A",
    "sort_by": "Sort by",
    "sort": "Sort",
    "rename": "Rename",
    "delete_this_list": "Delete this list",
    "continue_with_google": "Continue with Google",
    "continue_with_apple": "Continue with Apple",
    "sea_of_own": "SeaOfOwn",
    "choose_a_collection": "Choose a collection",
    "default_title": "Default",
    "add_to_collection": "Add to Collection",
    "name": "Name",
    "price": "Price",
    "salePrice": "Sale Price",
    "createdAt": "Created At",
    "updatedAt": "Updated At",
    "created_collection_successfully": "Created collection successfully.",
    "renamed_collection_successfully": "Renamed collection successfully.",
    "deleted_collection_successfully": "Deleted collection successfully.",
    "created_collection_failed": "Created collection failed.",
    "renamed_collection_failed": "Renamed collection failed.",
    "deleted_collection_failed": "Deleted collection failed.",
    "no_specifications_available": "No specifications available.",
    "saved_list": "Saved List",
    "specs": "Specs",
    "buy_here": "Buy Here",
    "what_we_like": "What we like",
    "what_we_dont_like": "What we don't like",
    "send_feedback_successfully": "Send feedback successfully.",
    "send_feedback_failed": "Send feedback failed. Please try again.",
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
  static const String is_required = "is_required";
  static const String must_be_at_least = "must_be_at_least";
  static const String characters = "characters";
  static const String theme = "theme";
  static const String send_us_your_feedback = "send_us_your_feedback";
  static const String privacy_policy = "privacy_policy";
  static const String terms_of_service = "terms_of_service";
  static const String logout = "logout";
  static const String delete_account = "delete_account";
  static const String system = "system";
  static const String edit_profile = "edit_profile";
  static const String save_changes = "save_changes";
  static const String change_password = "change_password";
  static const String change_password_description =
      "change_password_description";
  static const String old_password = "old_password";
  static const String new_password = "new_password";
  static const String create = "create";
  static const String delete_account_description = "delete_account_description";
  static const String app_theme = "app_theme";
  static const String always_dark = "always_dark";
  static const String always_light = "always_light";
  static const String logout_description = "logout_description";
  static const String tell_us_why_you_decided_to_leave =
      "tell_us_why_you_decided_to_leave";
  static const String confirm_delete = "confirm_delete";
  static const String send_us_your_feedback_description =
      "send_us_your_feedback_description";
  static const String send_feedback = "send_feedback";
  static const String please_explain_a_little_more =
      "please_explain_a_little_more";
  static const String write_to_us = "write_to_us";
  static const String not_enough_products = "not_enough_products";
  static const String no_products_found = "no_products_found";
  static const String app_is_too_slow_or_has_bugs =
      "app_is_too_slow_or_has_bugs";
  static const String found_a_better_alternative = "found_a_better_alternative";
  static const String dont_use_discovery_apps_anymore =
      "dont_use_discovery_apps_anymore";
  static const String app_is_confusing_or_hard_to_use =
      "app_is_confusing_or_hard_to_use";
  static const String other = "other";
  static const String create_new_list = "create_new_list";
  static const String add_a_name = "add_a_name";
  static const String lowest_price = "lowest_price";
  static const String highest_price = "highest_price";
  static const String name_a_z = "name_a_z";
  static const String name_z_a = "name_z_a";
  static const String sort_by = "sort_by";
  static const String sort = "sort";
  static const String rename = "rename";
  static const String delete_this_list = "delete_this_list";
  static const String continue_with_google = "continue_with_google";
  static const String continue_with_apple = "continue_with_apple";
  static const String sea_of_own = "sea_of_own";
  static const String choose_a_collection = "choose_a_collection";
  static const String default_title = "default_title";
  static const String add_to_collection = "add_to_collection";
  static const String name = "name";
  static const String price = "price";
  static const String salePrice = "salePrice";
  static const String createdAt = "createdAt";
  static const String updatedAt = "updatedAt";
  static const String created_collection_successfully =
      "created_collection_successfully";
  static const String renamed_collection_successfully =
      "renamed_collection_successfully";
  static const String deleted_collection_successfully =
      "deleted_collection_successfully";
  static const String created_collection_failed = "created_collection_failed";
  static const String renamed_collection_failed = "renamed_collection_failed";
  static const String deleted_collection_failed = "deleted_collection_failed";
  static const String no_specifications_available =
      "no_specifications_available";
  static const String saved_list = "saved_list";
  static const String specs = "specs";
  static const String buy_here = "buy_here";
  static const String what_we_like = "what_we_like";
  static const String what_we_dont_like = "what_we_dont_like";
  static const String send_feedback_successfully = "send_feedback_successfully";
  static const String send_feedback_failed = "send_feedback_failed";

  void init(
      {required List<MapLocale> mapLocales,
      AppLanguage initLanguage = AppLanguage.en}) {
    localization.onTranslatedLanguage = onTranslatedLanguage;
    localization.init(
        mapLocales: mapLocales, initLanguageCode: initLanguage.languageCode);
  }

  void onTranslatedLanguage(Locale? locale) {}
}
