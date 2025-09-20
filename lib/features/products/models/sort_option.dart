import 'package:app_base/core/localization/app_locale.dart';
import 'package:app_base/features/products/models/sort_by.dart';
import 'package:app_base/features/products/models/sort_direction.dart';

enum SortOption {
  newlyAdded,
  lowestPrice,
  highestPrice,
  nameAZ,
  nameZA;

  String get displayName {
    switch (this) {
      case SortOption.newlyAdded:
        return AppLocale.newly_added;
      case SortOption.lowestPrice:
        return AppLocale.lowest_price;
      case SortOption.highestPrice:
        return AppLocale.highest_price;
      case SortOption.nameAZ:
        return AppLocale.name_a_z;
      case SortOption.nameZA:
        return AppLocale.name_z_a;
    }
  }

  SortBy get sortBy {
    switch (this) {
      case SortOption.newlyAdded:
        return SortBy.createdAt;
      case SortOption.lowestPrice:
        return SortBy.price;
      case SortOption.highestPrice:
        return SortBy.price;
      case SortOption.nameAZ:
        return SortBy.name;
      case SortOption.nameZA:
        return SortBy.name;
    }
  }

  SortDirection get sortDirection {
    switch (this) {
      case SortOption.newlyAdded:
        return SortDirection.desc;
      case SortOption.lowestPrice:
        return SortDirection.asc;
      case SortOption.highestPrice:
        return SortDirection.desc;
      case SortOption.nameAZ:
        return SortDirection.asc;
      case SortOption.nameZA:
        return SortDirection.desc;
    }
  }
}
