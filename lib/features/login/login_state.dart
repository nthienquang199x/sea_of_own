import 'package:firebase_auth/firebase_auth.dart';

class LoginState {
  final bool isLoading;
  final bool isLoadingApple;
  final bool isSuccess;
  final bool isError;
  final String? errorMessage;
  final User? user;

  const LoginState({
    this.isLoading = false,
    this.isLoadingApple = false,
    this.isSuccess = false,
    this.isError = false,
    this.errorMessage,
    this.user,
  });

  LoginState copyWith({
    bool? isLoading,
    bool? isLoadingApple,
    bool? isSuccess,
    bool? isError,
    String? errorMessage,
    User? user,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      isLoadingApple: isLoadingApple ?? this.isLoadingApple,
      isSuccess: isSuccess ?? this.isSuccess,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
      user: user ?? this.user,
    );
  }
}
