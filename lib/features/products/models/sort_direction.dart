import 'package:app_base/app/theme/icons.dart';

enum SortDirection {
  asc,
  desc;

  String get icon {
    switch (this) {
      case SortDirection.asc:
        return AppIcons.ic_arrow_up;
      case SortDirection.desc:
        return AppIcons.ic_arrow_down;
    }
  }
}
