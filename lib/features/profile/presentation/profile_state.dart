import 'package:app_base/features/profile/models/app_theme.dart';
import 'package:app_base/models/user.dart';

class ProfileState {
  final AppTheme selectedTheme;
  final User? user;

  ProfileState({this.selectedTheme = AppTheme.system, this.user});
  ProfileState copyWith({AppTheme? selectedTheme, User? user}) {
    return ProfileState(
      selectedTheme: selectedTheme ?? this.selectedTheme,
      user: user ?? this.user,
    );
  }
}
