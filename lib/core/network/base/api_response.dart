import 'package:app_base/core/network/models/meta.dart';

class ApiResponse<T> {
  // final String status;
  final String message;
  final T? data;
  final Meta? meta;

  ApiResponse({this.meta, required this.message, this.data});

  factory ApiResponse.fromJson(
      Map<String, dynamic> json, T Function(dynamic) parse) {
    return ApiResponse(
      // status: json['status'],
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
      message: json['message'],
      data: json['data'] != null ? parse(json['data']) : null,
    );
  }
}
