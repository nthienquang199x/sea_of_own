import 'package:app_base/models/user.dart';

import '../theme/themes.dart';

enum PageStatus { loading, idle, error }

class AppState {
  final AppThemeData appTheme;
  final PageStatus status;
  final User? user;
  AppState({required this.appTheme, required this.status, this.user});

  AppState copyWith({
    AppThemeData? appTheme,
    PageStatus? status,
    User? user,
  }) {
    return AppState(
      appTheme: appTheme ?? this.appTheme,
      status: status ?? this.status,
      user: user ?? this.user,
    );
  }
}
