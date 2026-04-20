import 'package:dio/dio.dart';

import '../../../../core/network/models/api_response.dart';
import '../../domain/entities/claim_request.dart';
import '../../domain/entities/claim_submission_result.dart';
import '../models/policy_model.dart';

abstract class DashboardRemoteDataSource {
  Future<List<PolicyModel>> fetchPolicies();

  Future<ClaimSubmissionResult> submitClaim(ClaimRequest request);
}

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  const DashboardRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<List<PolicyModel>> fetchPolicies() async {
    final response = await _dio.get<dynamic>('/policies');
    final apiResponse = ApiResponse<List<PolicyModel>>.fromDynamic(
      response.data,
      dataParser: _parsePolicyList,
    );
    final data = apiResponse.data;

    if (data == null) {
      throw const FormatException('Policies payload is empty.');
    }

    return data;
  }

  @override
  Future<ClaimSubmissionResult> submitClaim(ClaimRequest request) async {
    final response = await _dio.post<dynamic>(
      '/claim',
      data: {
        'policyId': request.policyId,
        'incidentDate': request.incidentDate.toIso8601String(),
        'description': request.description,
      },
    );

    final apiResponse = ApiResponse<Object?>.fromDynamic(
      response.data,
      dataParser: (rawData) => rawData,
    );
    final isHttpSuccess =
        (response.statusCode ?? 500) >= 200 &&
        (response.statusCode ?? 500) < 300;
    final success = apiResponse.success ?? isHttpSuccess;
    final message = apiResponse.message ?? 'Claim submitted.';

    return ClaimSubmissionResult(success: success, message: message);
  }

  List<PolicyModel>? _parsePolicyList(dynamic rawData) {
    if (rawData is List) {
      return rawData
          .whereType<Map<String, dynamic>>()
          .map((item) => PolicyModel.fromMap(Map<String, dynamic>.from(item)))
          .toList();
    }
    return null;
  }
}
