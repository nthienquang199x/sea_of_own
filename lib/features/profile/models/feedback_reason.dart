import 'package:app_base/core/localization/app_locale.dart';

enum FeedbackReason {
  notEnoughProducts,
  appSlowOrBugs,
  foundBetterAlternative,
  dontUseDiscoveryApps,
  appConfusingOrHardToUse,
  other;

  String get title {
    switch (this) {
      case FeedbackReason.notEnoughProducts:
        return AppLocale.not_enough_products;
      case FeedbackReason.appSlowOrBugs:
        return AppLocale.app_is_too_slow_or_has_bugs;
      case FeedbackReason.foundBetterAlternative:
        return AppLocale.found_a_better_alternative;
      case FeedbackReason.dontUseDiscoveryApps:
        return AppLocale.dont_use_discovery_apps_anymore;
      case FeedbackReason.appConfusingOrHardToUse:
        return AppLocale.app_is_confusing_or_hard_to_use;
      case FeedbackReason.other:
        return AppLocale.other;
    }
  }
}
