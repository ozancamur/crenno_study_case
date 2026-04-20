import 'package:dio/dio.dart';

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
    final response = await _dio.get<List<dynamic>>('/policies');
    final data = response.data;

    if (data == null) {
      throw const FormatException('Policies payload is empty.');
    }

    return data
        .map((item) => PolicyModel.fromMap(item as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<ClaimSubmissionResult> submitClaim(ClaimRequest request) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/claims',
      data: {
        'policyId': request.policyId,
        'incidentDate': request.incidentDate.toIso8601String(),
        'description': request.description,
      },
    );

    final payload = response.data;
    final message = payload?['message']?.toString() ?? 'Claim submitted.';

    return ClaimSubmissionResult(success: true, message: message);
  }
}
