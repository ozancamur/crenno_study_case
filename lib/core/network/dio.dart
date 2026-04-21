import 'package:crenno_study_case/core/constants/api.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioService {
  DioService._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.BASE_URL,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: const {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(
          request: true,
          requestHeader: true,
          requestBody: true,
          responseHeader: false,
          responseBody: true,
          error: true,
          logPrint: (object) => debugPrint(object.toString()),
        ),
      );
    }
  }

  late final Dio _dio;

  static final DioService _instance = DioService._internal();
  factory DioService() => _instance;

  Dio get dio => _dio;
}
