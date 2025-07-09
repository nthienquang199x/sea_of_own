import 'package:app_base/core/localization/app_locale.dart';

enum FilterList {
  newlyAdded,
  lowestPrice,
  highestPrice,
  nameAZ,
  nameZA;

  String get title {
    switch (this) {
      case FilterList.newlyAdded:
        return AppLocale.newly_added;
      case FilterList.lowestPrice:
        return AppLocale.lowest_price;
      case FilterList.highestPrice:
        return AppLocale.highest_price;
      case FilterList.nameAZ:
        return AppLocale.name_a_z;
      case FilterList.nameZA:
        return AppLocale.name_z_a;
    }
  }
}
