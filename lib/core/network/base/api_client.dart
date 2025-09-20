import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'api_constants.dart';

class ApiClient {
  static final Dio _dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));
  static const storage = FlutterSecureStorage();
  static ValueNotifier<bool> isAuthenticated = ValueNotifier(false);

  static Future<String> getToken() async =>
      (await storage.read(key: 'access_token')) ??
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyIiwiZXhwIjoxNzU2NjEyNzI4LCJpYXQiOjE3NTYwMDc5MjgsImp0aSI6IjAxOThkYTNhLTkxMWUtNzkzNC1iMjIwLTAyZjAwNThjN2UzZiJ9.NKS0wJvDscBnk9ZKvND3QPXeVqbiH6msZC3ZLAiqIEk';

  static Future<void> checkAuthentication() async {
    final token = await storage.read(key: 'access_token');
    // const token =
    //     'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyIiwiZXhwIjoxNzU2NjEyNzI4LCJpYXQiOjE3NTYwMDc5MjgsImp0aSI6IjAxOThkYTNhLTkxMWUtNzkzNC1iMjIwLTAyZjAwNThjN2UzZiJ9.NKS0wJvDscBnk9ZKvND3QPXeVqbiH6msZC3ZLAiqIEk';
    if (token == null || token.isEmpty == true) {
      isAuthenticated.value = false;
    } else {
      isAuthenticated.value = !JwtDecoder.isExpired(token);
    }
  }

  static Future<void> clearToken() async {
    await storage.delete(key: 'access_token');
    isAuthenticated.value = false;
  }

  static Dio get dio {
    _dio.interceptors.clear();
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await storage.read(key: 'access_token');
        // const token =
        //     'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIzIiwiZXhwIjoxNzU4NDQ3MjY5LCJpYXQiOjE3NTc4NDI0NzAsImp0aSI6IjAxOTk0NzkzLTc0NDUtNzg5NC04YTIyLWI3MjQ2YTA0ODlhZiJ9.5JGd3FCvIJ1olIgg-tgJyM9eb8VsZrT_cLn0Fl-tr40';
        options.headers['Authorization'] = 'Bearer $token';
        return handler.next(options);
      },
      onError: (error, handler) {
        if (error.response?.statusCode == 401) {
          isAuthenticated.value = false;
        }
        return handler.next(error);
      },
    ));
    return _dio;
  }
}
