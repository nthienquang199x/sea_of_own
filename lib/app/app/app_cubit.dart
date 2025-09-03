import 'package:app_base/core/network/base/api_client.dart';
import 'package:app_base/core/network/services/user_service.dart';
import 'package:app_base/core/storage/local_storage.dart';
import 'package:app_base/models/user.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../base/base_cubit.dart';
import '../config/app_router.dart';
import '../theme/themes.dart';
import 'app_state.dart';

@singleton
class AppCubit extends BaseCubit<AppState> {
  AppCubit()
      : super(
            AppState(status: PageStatus.loading, appTheme: _getInitialTheme()));

  final AppRouter appRouter = AppRouter();
  final UserService _userService = UserService();

  static AppThemeData _getInitialTheme() {
    final themeString = LocalStorage().theme;
    switch (themeString) {
      case 'light':
        return AppThemeData.light();
      case 'dark':
        return AppThemeData.dark();
      case 'system':
        final brightness =
            WidgetsBinding.instance.platformDispatcher.platformBrightness;
        if (brightness == Brightness.dark) {
          return AppThemeData.dark();
        } else {
          return AppThemeData.light();
        }
      default:
        return AppThemeData.dark();
    }
  }

  void changeTheme(AppThemeData appTheme, {String? themeName}) {
    if (themeName != null) {
      LocalStorage().saveTheme(themeName);
    } else if (appTheme == AppThemeData.light()) {
      LocalStorage().saveTheme('light');
    } else if (appTheme == AppThemeData.dark()) {
      LocalStorage().saveTheme('dark');
    }
    emit(state.copyWith(appTheme: appTheme));
  }

  void init({required BuildContext context}) async {
    await ApiClient.checkAuthentication();
    final user = ApiClient.isAuthenticated.value
        ? await _userService.getProfile()
        : null;
    if (user != null) {
      _delegate(user: user);
    }
    emit(state.copyWith(status: PageStatus.idle, user: user));
  }

  void _delegate({required User user}) {
    if (user.bio == true) {}
  }

  void changeUser(User user) {
    _delegate(user: user);
    emit(state.copyWith(user: user));
  }

  void logout() {
    emit(state.copyWith(user: null));
    ApiClient.clearToken();
    appRouter.pushAndPopUntil(
      const LoginRoute(),
      predicate: (route) => false,
    );
  }
}
