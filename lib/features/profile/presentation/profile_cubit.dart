import 'package:app_base/app/theme/themes.dart';
import 'package:app_base/base/base_cubit.dart';
import 'package:app_base/core/network/services/user_service.dart';
import 'package:app_base/core/storage/local_storage.dart';
import 'package:app_base/features/profile/models/app_theme.dart';
import 'package:app_base/features/profile/models/feedback_reason.dart';
import 'package:app_base/features/profile/presentation/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:url_launcher/url_launcher.dart';

@injectable
class ProfileCubit extends BaseCubit<ProfileState> {
  ProfileCubit() : super(ProfileState());
  TextEditingController textEditingController = TextEditingController();
  TextEditingController feedbackEditingController = TextEditingController();
  TextEditingController nameEditingController = TextEditingController();
  final _userService = UserService();

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
    getUser();
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

  void getUser() async {
    if (appCubit.state.user != null) {
      emit(state.copyWith(user: appCubit.state.user));
    }
  }

  Future<bool> updateProfile(String name) async {
    try {
      showLoading();
      final updatedUser = await _userService.updateProfile(
        name: name,
      );
      if (updatedUser != null) {
        appCubit.changeUser(updatedUser);
        emit(state.copyWith(user: updatedUser));
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    } finally {
      hideLoading();
    }
  }

  void logout() {
    appCubit.logout();
    if (appCubit.state.user == null) {
      emit(state.copyWith(user: null));
    } else {
      emit(state.copyWith(user: appCubit.state.user));
    }
  }

  Future<bool> deleteAccount() async {
    try {
      showLoading();
      final isSuccess = await _userService.deleteAccount();
      if (isSuccess) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    } finally {
      hideLoading();
    }
  }

  void sendFeedbackEmail(
      {required String body, required BuildContext context}) async {
    const email = 'hello@seaofown.com';
    const subject = 'Feedback';
    final encodedSubject = Uri.encodeComponent(subject);
    final encodedBody = Uri.encodeComponent(body);
    final Uri emailUri = Uri.parse(
      'mailto:$email?subject=$encodedSubject&body=$encodedBody',
    );
    Navigator.pop(context);
    await launchUrl(emailUri, mode: LaunchMode.externalApplication);
  }

  Future<bool> sendFeedback(String feedback) async {
    try {
      if (state.user == null) return false;
      showLoading();
      final isSuccess = await _userService.sendFeedback(
          userId: state.user!.id, message: feedback);
      return isSuccess;
    } catch (e) {
      return false;
    } finally {
      hideLoading();
    }
  }

  void onSavedTheme(AppTheme theme) {
    emit(state.copyWith(selectedTheme: theme));
    onChangeTheme(theme);
  }

  void onChangeFeedbackReason(FeedbackReason? reason) {
    emit(state.copyWith(selectedReason: reason));
  }
}
