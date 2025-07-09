import 'package:app_base/core/network/base/api_client.dart';
import 'package:app_base/core/network/services/user_service.dart';
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
      : super(AppState(
            status: PageStatus.loading, appTheme: AppThemeData.dark()));

  final AppRouter appRouter = AppRouter();
  final UserService _userService = UserService();

  changeTheme(AppThemeData appTheme) {
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
    if (user.isVerified == true) {}
  }

  void changeUser(User user) {
    _delegate(user: user);
    emit(state.copyWith(user: user));
  }

  void logout() {
    emit(state.copyWith(user: null));
    ApiClient.clearToken();
    // appRouter.pushAndPopUntil(
    //   const SignInRoute(),
    //   predicate: (route) => false,
    // );
  }
}
