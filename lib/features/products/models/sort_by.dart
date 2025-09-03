import 'package:app_base/core/localization/app_locale.dart';

enum SortBy {
  name,
  price,
  salePrice,
  createdAt,
  updatedAt;

  String get params {
    switch (this) {
      case SortBy.name:
        return 'name';
      case SortBy.price:
        return 'price';
      case SortBy.salePrice:
        return 'sale_price';
      case SortBy.createdAt:
        return 'createdAt';
      case SortBy.updatedAt:
        return 'updatedAt';
    }
  }

  String get displayName {
    switch (this) {
      case SortBy.name:
        return AppLocale.name;
      case SortBy.price:
        return AppLocale.price;
      case SortBy.salePrice:
        return AppLocale.salePrice;
      case SortBy.createdAt:
        return AppLocale.createdAt;
      case SortBy.updatedAt:
        return AppLocale.updatedAt;
    }
  }
}
