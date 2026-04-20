import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioService {
  late Dio _dio;
  static const String BASE_URL = '';

  static final DioService _instance = DioService._internal();
  factory DioService() => _instance;

  DioService._internal() {
    _initalize();
  }

  void _initalize() {
    _dio = Dio(
      BaseOptions(
        baseUrl: BASE_URL,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _initializeInterceptors();
  }

  void _initializeInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (kDebugMode) {
            debugPrint('=======================REQUEST=======================');
            debugPrint("[REQUEST] => [${options.method}]");
            debugPrint('-----------------------------------------------------');
            debugPrint("[PATH] => [${options.baseUrl}${options.path}]");
            debugPrint('-----------------------------------------------------');
            debugPrint("[DATA] => [${options.data}]");
            debugPrint('-----------------------------------------------------');
            debugPrint("[QUERY] => [${options.queryParameters}]");
            debugPrint('=======================REQUEST=======================');
          }
          handler.next(options);
        },
        onResponse: (response, handler) {
          if (kDebugMode) {
            debugPrint('======================RESPONSE======================');
            debugPrint("[STATUS CODE] => [${response.statusCode}]");
            debugPrint('----------------------------------------------------');
            debugPrint("[DATA] => [${response.data}]");
            debugPrint('======================RESPONSE======================');
          }
          handler.next(response);
        },
        onError: (error, handler) {
          if (kDebugMode) {
            debugPrint('=======================ERROR=======================');
            debugPrint("[STATUS CODE] => [${error.response?.statusCode}]");
            debugPrint('---------------------------------------------------');
            debugPrint("[MESSAGE] => [${error.response?.data}]");
            debugPrint('=======================ERROR=======================');
          }
          handler.next(error);
        },
      ),
    );
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.get(
      path,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.put(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.delete(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.patch(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response> uploadFile(
    String path, {
    required FormData formData,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.post(
      path,
      data: formData,
      queryParameters: queryParameters,
      options:
          options ?? Options(headers: {'Content-Type': 'multipart/form-data'}),
    );
  }

  void setHeader(String key, String value) {
    _dio.options.headers[key] = value;
  }

  void setToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  void removeToken() {
    _dio.options.headers.remove('Authorization');
  }
}
