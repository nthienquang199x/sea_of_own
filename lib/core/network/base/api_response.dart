class ApiResponse<T> {
  final String status;
  final String message;
  final T? data;

  ApiResponse({required this.status, required this.message, this.data});

  factory ApiResponse.fromJson(
      Map<String, dynamic> json, T Function(dynamic) parse) {
    return ApiResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? parse(json['data']) : null,
    );
  }
}
