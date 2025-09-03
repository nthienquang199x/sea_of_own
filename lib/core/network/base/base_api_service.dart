import 'package:app_base/utils/extension/font_extension.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

import 'api_client.dart';
import 'api_response.dart';

class BaseApiService {
  Future<ApiResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParams,
    required T Function(dynamic data) parser,
    Options? options,
    bool showErrorToast = true,
  }) async {
    return _wrap(
        () => ApiClient.dio
            .get(path, queryParameters: queryParams, options: options),
        parser,
        showErrorToast);
  }

  Future<ApiResponse<T>> post<T>(
    String path, {
    dynamic data,
    required T Function(dynamic data) parser,
    Options? options,
    bool showErrorToast = true,
  }) async {
    return _wrap(
      () => ApiClient.dio.post(path, data: data, options: options),
      parser,
      showErrorToast,
    );
  }

  Future<ApiResponse<T>> put<T>(
    String path, {
    dynamic data,
    required T Function(dynamic data) parser,
    bool showErrorToast = true,
  }) async {
    return _wrap(
        () => ApiClient.dio.put(path, data: data), parser, showErrorToast);
  }

  Future<ApiResponse<T>> patch<T>(
    String path, {
    dynamic data,
    required T Function(dynamic data) parser,
    bool showErrorToast = true,
  }) async {
    return _wrap(
        () => ApiClient.dio.patch(path, data: data), parser, showErrorToast);
  }

  Future<ApiResponse<T>> delete<T>(
    String path, {
    dynamic data,
    required T Function(dynamic data) parser,
    bool showErrorToast = true,
  }) async {
    return _wrap(
        () => ApiClient.dio.delete(path, data: data), parser, showErrorToast);
  }

  Future<ApiResponse<T>> _wrap<T>(
    Future<Response> Function() request,
    T Function(dynamic data) parser,
    bool showErrorToast,
  ) async {
    try {
      final response = await request();
      return ApiResponse.fromJson(response.data, parser);
    } on DioException catch (e) {
      final msg = e.response?.data['message'] ?? 'Something went wrong';
      if (showErrorToast) {
        toastification.show(
          style: ToastificationStyle.flat,
          autoCloseDuration: const Duration(seconds: 3),
          icon: const Icon(Icons.error_outline_rounded, color: Colors.yellow),
          title: Text(
            msg,
            style: TextStyle(
              fontFamily: FontFamily.SpaceGrotesk.name,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        );
      }
      rethrow;
    } catch (e) {
      if (showErrorToast) {
        toastification.show(
          style: ToastificationStyle.flat,
          autoCloseDuration: const Duration(seconds: 3),
          title: Text(
            'Something went wrong',
            style: TextStyle(
              fontFamily: FontFamily.SpaceGrotesk.name,
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }
      rethrow;
    }
  }
}
