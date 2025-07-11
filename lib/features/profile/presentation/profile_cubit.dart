import 'package:app_base/app/theme/themes.dart';
import 'package:app_base/base/base_cubit.dart';
import 'package:app_base/core/storage/local_storage.dart';
import 'package:app_base/features/profile/models/app_theme.dart';
import 'package:app_base/features/profile/presentation/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProfileCubit extends BaseCubit<ProfileState> {
  ProfileCubit() : super(ProfileState());

  void init() {
    final themeName = LocalStorage().theme;
    AppTheme selectedTheme;
    switch (themeName) {
      case 'light':
        selectedTheme = AppTheme.light;
        break;
      case 'dark':
        selectedTheme = AppTheme.dark;
        break;
      case 'system':
        selectedTheme = AppTheme.system;
        break;
      default:
        selectedTheme = AppTheme.dark;
    }
    emit(state.copyWith(selectedTheme: selectedTheme));
  }

  void onChangeTheme(AppTheme theme) {
    switch (theme) {
      case AppTheme.system:
        final brightness =
            WidgetsBinding.instance.platformDispatcher.platformBrightness;
        if (brightness == Brightness.dark) {
          appCubit.changeTheme(AppThemeData.dark(), themeName: 'system');
        } else {
          appCubit.changeTheme(AppThemeData.light(), themeName: 'system');
        }
        break;
      case AppTheme.light:
        appCubit.changeTheme(AppThemeData.light(), themeName: 'light');
        break;
      case AppTheme.dark:
        appCubit.changeTheme(AppThemeData.dark(), themeName: 'dark');
    }
  }

  void onSavedTheme(AppTheme theme) {
    emit(state.copyWith(selectedTheme: theme));
    onChangeTheme(theme);
  }
}
