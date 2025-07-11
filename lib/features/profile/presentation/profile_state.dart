import 'package:app_base/features/profile/models/app_theme.dart';

class ProfileState {
  final AppTheme selectedTheme;

  ProfileState({this.selectedTheme = AppTheme.system});
  ProfileState copyWith({AppTheme? selectedTheme}) {
    return ProfileState(
      selectedTheme: selectedTheme ?? this.selectedTheme,
    );
  }
}
