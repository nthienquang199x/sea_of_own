import 'package:app_base/base/base_cubit.dart';
import 'package:app_base/core/network/services/auth_service.dart';
import 'package:app_base/core/network/services/user_service.dart';
import 'package:app_base/features/login/login_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginCubit extends BaseCubit<LoginState> {
  final AuthService _authService;
  final userService = UserService();

  LoginCubit(this._authService) : super(const LoginState());

  Future<void> loginWithApple() async {
    try {
      emit(state.copyWith(isLoadingApple: true));

      final userCredential = await _authService.signInWithApple();

      if (userCredential != null) {
        final appleId = userCredential.user?.uid;
        if (appleId == null) {
          emit(state.copyWith(
            isLoadingApple: false,
            isError: true,
            errorMessage: 'Cannot retrieve Apple ID',
          ));
          return;
        }
        final loginResult = await _authService.loginAppWithApple(
          email: userCredential.user?.email ?? '',
          name: userCredential.user?.displayName ?? '',
          appleId: appleId,
          avatar: userCredential.user?.photoURL,
        );

        if (loginResult != null) {
          final user = await userService.getProfile();
          emit(state.copyWith(
            isLoadingApple: false,
            isSuccess: true,
            user: userCredential.user,
          ));
          if (user != null) {
            appCubit.changeUser(user);
          }
        }
      } else {
        emit(state.copyWith(
          isLoadingApple: false,
          isError: true,
          errorMessage: 'Apple sign-in was cancelled or failed',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        isLoadingApple: false,
        isError: true,
        errorMessage: 'Apple sign-in error',
      ));
    }
  }

  Future<void> loginWithGoogle() async {
    try {
      emit(state.copyWith(isLoading: true));

      final userCredential = await _authService.signInWithGoogle();

      if (userCredential != null) {
        final googleId = userCredential.user?.uid;
        if (googleId == null) {
          emit(state.copyWith(
            isLoading: false,
            isError: true,
            errorMessage: 'Cannot retrieve Google ID',
          ));
          return;
        }
        final loginResult = await _authService.loginApp(
          email: userCredential.user?.email ?? '',
          name: userCredential.user?.displayName ?? '',
          googleId: googleId,
          avatar: userCredential.user?.photoURL,
        );

        if (loginResult != null) {
          final user = await userService.getProfile();
          emit(state.copyWith(
            isLoading: false,
            isSuccess: true,
            user: userCredential.user,
          ));
          if (user != null) {
            appCubit.changeUser(user);
            //   emit(state.copyWith(
            //     isLoading: false,
            //     isSuccess: true,
            //     user: userCredential.user,
            //   ));
          }
        }
      } else {
        emit(state.copyWith(
          isLoading: false,
          isError: true,
          errorMessage: 'Google sign-in was cancelled or failed',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        isError: true,
        errorMessage: 'Something went wrong',
      ));
    }
  }

  // Lấy Google Access Token
  Future<String?> getGoogleAccessToken() async {
    return await _authService.getGoogleAccessToken();
  }

  // Lấy Google ID Token
  Future<String?> getGoogleIdToken() async {
    return await _authService.getGoogleIdToken();
  }

  // Lấy Firebase ID Token
  Future<String?> getFirebaseIdToken() async {
    return await _authService.getFirebaseIdToken();
  }

  // Lấy tất cả tokens
  Future<Map<String, String?>> getAllTokens() async {
    return await _authService.getAllTokens();
  }

  void loginWithEmail(String email, String password) {
    // Implement email login logic
  }
}
