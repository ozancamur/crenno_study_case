import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

class DioService {
  DioService._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://mock.insurance.app',
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: const {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    _dio.interceptors.add(_MockInsuranceApiInterceptor());
  }

  late final Dio _dio;

  static final DioService _instance = DioService._internal();
  factory DioService() => _instance;

  Dio get dio => _dio;

  void setAcceptLanguage(String languageCode) {
    _dio.options.headers['Accept-Language'] = languageCode;
  }
}

class _MockInsuranceApiInterceptor extends Interceptor {
  static const _networkDelay = Duration(seconds: 2);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    await Future<void>.delayed(_networkDelay);

    if (options.path == '/policies' && options.method == 'GET') {
      try {
        final jsonString = await rootBundle.loadString(
          'assets/mocks/policies.json',
        );
        final decoded = jsonDecode(jsonString) as Map<String, dynamic>;
        final languageHeader =
            options.headers['Accept-Language']?.toString().toLowerCase() ??
            'en';
        final languageCode = languageHeader.startsWith('tr') ? 'tr' : 'en';

        final localizedRoot = decoded[languageCode] as Map<String, dynamic>?;
        final policiesNode = localizedRoot?['policies'];
        final policies = _extractPolicies(policiesNode);

        handler.resolve(
          Response<dynamic>(
            requestOptions: options,
            data: policies,
            statusCode: 200,
          ),
        );
        return;
      } catch (_) {
        handler.reject(
          DioException(
            requestOptions: options,
            type: DioExceptionType.badResponse,
            response: Response<dynamic>(
              requestOptions: options,
              statusCode: 500,
              data: const {'message': 'Failed to parse policies payload.'},
            ),
          ),
        );
        return;
      }
    }

    if (options.path == '/claims' && options.method == 'POST') {
      final payload = options.data;
      final description = payload is Map<String, dynamic>
          ? (payload['description']?.toString() ?? '')
          : '';

      if (description.toLowerCase().contains('error')) {
        handler.reject(
          DioException(
            requestOptions: options,
            type: DioExceptionType.badResponse,
            response: Response<dynamic>(
              requestOptions: options,
              statusCode: 422,
              data: const {
                'message':
                    'Claim could not be submitted. Please review details.',
              },
            ),
          ),
        );
        return;
      }

      handler.resolve(
        Response<dynamic>(
          requestOptions: options,
          statusCode: 201,
          data: const {'message': 'Claim submitted successfully.'},
        ),
      );
      return;
    }

    handler.next(options);
  }

  List<Map<String, dynamic>> _extractPolicies(dynamic policiesNode) {
    if (policiesNode is! List) {
      return <Map<String, dynamic>>[];
    }

    if (policiesNode.isNotEmpty && policiesNode.first is List) {
      final nested = policiesNode.first as List<dynamic>;
      return nested
          .whereType<Map<String, dynamic>>()
          .map((item) => Map<String, dynamic>.from(item))
          .toList();
    }

    return policiesNode
        .whereType<Map<String, dynamic>>()
        .map((item) => Map<String, dynamic>.from(item))
        .toList();
  }
}
