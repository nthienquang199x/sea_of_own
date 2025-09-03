import 'package:firebase_auth/firebase_auth.dart';

class LoginState {
  final bool isLoading;
  final bool isSuccess;
  final bool isError;
  final String? errorMessage;
  final User? user;

  const LoginState({
    this.isLoading = false,
    this.isSuccess = false,
    this.isError = false,
    this.errorMessage,
    this.user,
  });

  LoginState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isError,
    String? errorMessage,
    User? user,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
      user: user ?? this.user,
    );
  }
}
