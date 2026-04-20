class ApiResponse<T> {
  const ApiResponse({this.success, this.message, this.data});

  final bool? success;
  final String? message;
  final T? data;

  factory ApiResponse.fromMap(
    Map<String, dynamic> map, {
    required T? Function(dynamic rawData) dataParser,
  }) {
    return ApiResponse<T>(
      success: map['success'] is bool ? map['success'] as bool : null,
      message: map['message']?.toString(),
      data: dataParser(map['data']),
    );
  }

  factory ApiResponse.fromDynamic(
    dynamic payload, {
    required T? Function(dynamic rawData) dataParser,
  }) {
    if (payload is Map<String, dynamic>) {
      return ApiResponse<T>.fromMap(payload, dataParser: dataParser);
    }

    return ApiResponse<T>(data: dataParser(payload));
  }
}
