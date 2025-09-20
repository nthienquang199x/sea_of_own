import 'package:app_base/core/network/base/api_client.dart';
import 'package:app_base/core/network/base/base_api_service.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

@injectable
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _api = BaseApiService();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  User? get currentUser => _auth.currentUser;
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        return null;
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCredential = await _auth.signInWithCredential(credential);
      return userCredential;
    } catch (e) {
      return null;
    }
  }

  Future<UserCredential?> signInWithApple() async {
    try {
      final isAvailable = await SignInWithApple.isAvailable();
      if (!isAvailable) {
        return null;
      }

      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );
      final userCredential = await _auth.signInWithCredential(oauthCredential);

      return userCredential;
    } catch (e) {
      return null;
    }
  }

  Future<Map<String, dynamic>?> loginAppWithApple({
    required String email,
    required String name,
    required String appleId,
    String? avatar,
  }) async {
    try {
      final response = await _api.post(
        '/v1/app/login',
        data: {
          'appleId': appleId,
          'email': email,
          'name': name,
          'avatar': avatar,
        },
        options: Options(
          headers: {
            'Accept': 'application/json',
          },
        ),
        parser: (data) => data,
      );

      if (response.data != null) {
        await ApiClient.storage
            .write(key: "access_token", value: response.data!['accessToken']);
        return response.data!['user'] ??
            {'accessToken': response.data!['accessToken']};
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  Future<Map<String, dynamic>?> loginApp({
    required String email,
    required String name,
    required String googleId,
    String? avatar,
  }) async {
    try {
      final response = await _api.post(
        '/v1/app/login',
        data: {
          'googleId': googleId,
          'email': email,
          'name': name,
          'avatar': avatar,
        },
        options: Options(
          headers: {
            'Accept': 'application/json',
          },
        ),
        parser: (data) => data,
      );

      if (response.data != null) {
        await ApiClient.storage
            .write(key: "access_token", value: response.data!['accessToken']);
        return response.data!['user'] ??
            {'accessToken': response.data!['accessToken']};
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  bool get isSignedIn => _auth.currentUser != null;

  Future<String?> getGoogleAccessToken() async {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser != null && !currentUser.isAnonymous) {
        final GoogleSignInAccount? googleUser = _googleSignIn.currentUser;
        if (googleUser != null) {
          final GoogleSignInAuthentication googleAuth =
              await googleUser.authentication;
          return googleAuth.accessToken;
        }
      }
      return null;
    } catch (e) {
      print('Error getting Google access token: $e');
      return null;
    }
  }

  Future<String?> getGoogleIdToken() async {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser != null && !currentUser.isAnonymous) {
        final GoogleSignInAccount? googleUser = _googleSignIn.currentUser;
        if (googleUser != null) {
          final GoogleSignInAuthentication googleAuth =
              await googleUser.authentication;
          return googleAuth.idToken;
        }
      }
      return null;
    } catch (e) {
      print('Error getting Google ID token: $e');
      return null;
    }
  }

  Future<String?> getFirebaseIdToken() async {
    try {
      final User? user = _auth.currentUser;
      if (user != null && !user.isAnonymous) {
        final idToken = await user.getIdToken();
        return idToken;
      }
      return null;
    } catch (e) {
      print('Error getting Firebase ID token: $e');
      return null;
    }
  }

  Future<Map<String, String?>> getAllTokens() async {
    try {
      final Map<String, String?> tokens = {};
      final currentUser = _auth.currentUser;
      if (currentUser != null && !currentUser.isAnonymous) {
        final GoogleSignInAccount? googleUser = _googleSignIn.currentUser;
        if (googleUser != null) {
          final GoogleSignInAuthentication googleAuth =
              await googleUser.authentication;
          tokens['google_access_token'] = googleAuth.accessToken;
          tokens['google_id_token'] = googleAuth.idToken;
        }
        final firebaseIdToken = await currentUser.getIdToken();
        tokens['firebase_id_token'] = firebaseIdToken;
      }

      return tokens;
    } catch (e) {
      print('Error getting all tokens: $e');
      return {};
    }
  }
}
