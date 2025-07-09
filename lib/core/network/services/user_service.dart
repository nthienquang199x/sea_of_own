import 'dart:developer';
import 'dart:io';

import 'package:app_base/core/network/base/base_api_service.dart';
import 'package:app_base/models/gallery.dart';
import 'package:app_base/models/user.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class UserService {
  final _api = BaseApiService();

  Future<User?> getProfile() async {
    try {
      final response = await _api.get(
        '/users/profile',
        parser: (data) => User.fromJson(data),
      );
      if (response.status == "success" && response.data != null) {
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
    String? avatarUrl,
    required String fullName,
    required String phone,
    required String birthday,
  }) async {
    try {
      final response = await _api.put(
        '/users/profile',
        data: {
          'full_name': fullName,
          'phone': phone,
          'avatar_url': avatarUrl,
          'birthday': birthday,
        },
        parser: (data) => User.fromJson(data),
      );
      if (response.status == "success" && response.data != null) {
        return response.data!;
      } else {
        throw Exception('Failed to update profile: ${response.message}');
      }
    } catch (e, s) {
      log('Error updating profile: $e', stackTrace: s);
    }
    return null;
  }

  Future<String?> updateAvatar(File file) async {
    try {
      final fileName = file.path.split('/').last;
      final mimeType = lookupMimeType(file.path);

      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          file.path,
          filename: fileName,
          contentType: mimeType != null ? MediaType.parse(mimeType) : null,
        ),
      });

      final response = await _api.post(
        '/users/profile/avatar',
        data: formData,
        options: Options(
          method: 'POST',
          headers: {
            'Accept': 'application/json',
          },
          contentType: 'multipart/form-data',
        ),
        parser: (data) => data,
      );

      final data = response.data;
      if (response.status == 'success') {
        return data['avatar_url'] as String?;
      } else {
        throw Exception('Failed: ${data['message']}');
      }
    } catch (e, s) {
      if (e is DioException && e.response != null) {
        log('[API ERROR] ${e.response?.data}');
      }
      log('Error updating avatar: $e', stackTrace: s);
      return null;
    }
  }

  Future<bool> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      final response = await _api.put(
        '/users/change-password',
        data: {
          'old_password': oldPassword,
          'new_password': newPassword,
        },
        parser: (data) => data,
      );
      if (response.status == "success") {
        return true;
      } else {
        throw Exception('Failed to change password: ${response.message}');
      }
    } catch (e, s) {
      log('Error changing password: $e', stackTrace: s);
    }
    return false;
  }

  Future<List<Gallery>> getGalleries() async {
    try {
      final response = await _api.get(
        '/users/profile/gallery',
        parser: (data) =>
            (data as List).map((item) => Gallery.fromJson(item)).toList(),
      );
      if (response.status == "success" && response.data != null) {
        return response.data!;
      } else {
        throw Exception('Failed to fetch galleries: ${response.message}');
      }
    } catch (e, s) {
      log('Error fetching galleries: $e', stackTrace: s);
    }
    return [];
  }

  Future<List<Gallery>> uploadPhotos(List<File> photos) async {
    try {
      final formData = FormData.fromMap({
        'files': await Future.wait(photos.map((file) async {
          final fileName = file.path.split('/').last;
          final mimeType = lookupMimeType(file.path);
          return await MultipartFile.fromFile(
            file.path,
            filename: fileName,
            contentType: mimeType != null ? MediaType.parse(mimeType) : null,
          );
        })),
      });

      final response = await _api.post(
        '/users/profile/gallery',
        data: formData,
        options: Options(
          method: 'POST',
          headers: {
            'Accept': 'application/json',
          },
          contentType: 'multipart/form-data',
        ),
        parser: (data) =>
            (data as List).map((item) => Gallery.fromJson(item)).toList(),
      );

      if (response.status == "success") {
        return response.data ?? [];
      } else {
        throw Exception('Failed to upload photo: ${response.message}');
      }
    } catch (e, s) {
      log('Error uploading photo: $e', stackTrace: s);
    }
    return [];
  }

  Future<bool> deleteGallery(List<String> ids) async {
    try {
      final response = await _api.delete(
        '/users/profile/gallery',
        data: {
          'photo_ids': ids,
        },
        parser: (data) => data,
      );
      if (response.status == "success") {
        return true;
      } else {
        throw Exception('Failed to delete gallery: ${response.message}');
      }
    } catch (e, s) {
      log('Error deleting gallery: $e', stackTrace: s);
      return false;
    }
  }
}
