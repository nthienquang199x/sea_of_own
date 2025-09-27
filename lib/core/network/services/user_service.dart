import 'dart:developer';

import 'package:app_base/core/network/base/base_api_service.dart';
import 'package:app_base/models/user.dart';

class UserService {
  final _api = BaseApiService();

  Future<User?> getProfile() async {
    try {
      final response = await _api.get(
        '/v1/profiles',
        parser: (data) => User.fromJson(data),
      );
      if (response.message == "Success" && response.data != null) {
        return response.data!;
      } else {
        throw Exception('Failed to fetch profile: ${response.message}');
      }
    } catch (e, s) {
      log('Error fetching profile: $e', stackTrace: s);
    }
    return null;
  }

  Future<User?> updateProfile({
    String? name,
  }) async {
    try {
      final response = await _api.patch(
        '/v1/profiles',
        data: {
          'name': name,
        },
        parser: (data) => User.fromJson(data),
      );
      if (response.message == "Update profile successfully" &&
          response.data != null) {
        return response.data!;
      } else {
        throw Exception('Failed to update profile: ${response.message}');
      }
    } catch (e, s) {
      log('Error updating profile: $e', stackTrace: s);
    }
    return null;
  }

  Future<bool> deleteAccount() async {
    try {
      final response = await _api.delete(
        '/v1/delete-account',
        parser: (data) => data as Map<String, dynamic>,
      );
      // API may return 204 No Content → message: "Success with no content"
      if (response.message == "Delete account successfully" ||
          response.message == 'Success with no content' ||
          response.data == null) {
        return true;
      } else {
        throw Exception('Failed to delete account: ${response.message}');
      }
    } catch (e, s) {
      log('Error deleting account: $e', stackTrace: s);
    }
    return false;
  }

  Future<bool> sendFeedback(
      {required String message, required int userId}) async {
    try {
      final response = await _api.post(
        '/v1/feedbacks',
        data: {
          'message': message,
          'userId': userId,
        },
        parser: (data) => data as Map<String, dynamic>,
      );
      if (response.message == "Feedback submitted successfully") {
        return true;
      } else {
        throw Exception('Failed to send feedback: ${response.message}');
      }
    } catch (e, s) {
      log('Error sending feedback: $e', stackTrace: s);
    }
    return false;
  }
}
