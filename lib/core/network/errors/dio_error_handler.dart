import 'package:dio/dio.dart';

import 'app_exception.dart';

final class DioErrorHandler {
  const DioErrorHandler._();

  static AppException toAppException(DioException error) {
    final statusCode = error.response?.statusCode;
    final serverMessage = _extractServerMessage(error.response?.data);

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return AppException(
          serverMessage ?? 'Request timed out. Please try again.',
          statusCode: statusCode,
        );
      case DioExceptionType.connectionError:
        return AppException(
          serverMessage ?? 'No internet connection. Please check your network.',
          statusCode: statusCode,
        );
      case DioExceptionType.cancel:
        return AppException(
          serverMessage ?? 'Request was cancelled.',
          statusCode: statusCode,
        );
      case DioExceptionType.badCertificate:
        return AppException(
          serverMessage ?? 'Certificate validation failed.',
          statusCode: statusCode,
        );
      case DioExceptionType.badResponse:
        return AppException(
          serverMessage ?? 'Server error occurred. Please try again.',
          statusCode: statusCode,
        );
      case DioExceptionType.unknown:
        return AppException(
          serverMessage ?? 'Unexpected network error occurred.',
          statusCode: statusCode,
        );
    }
  }

  static String? _extractServerMessage(dynamic payload) {
    if (payload is Map<String, dynamic>) {
      final message = payload['message']?.toString();
      if (message != null && message.trim().isNotEmpty) {
        return message;
      }
    }

    if (payload is String && payload.trim().isNotEmpty) {
      return payload;
    }

    return null;
  }
}
