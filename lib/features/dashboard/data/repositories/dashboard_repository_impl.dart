import 'package:dio/dio.dart';

import '../../domain/entities/claim_request.dart';
import '../../domain/entities/claim_submission_result.dart';
import '../../domain/entities/policy.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../datasources/dashboard_remote_data_source.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  const DashboardRepositoryImpl(this._remoteDataSource);

  final DashboardRemoteDataSource _remoteDataSource;

  @override
  Future<List<Policy>> getPolicies() async {
    final models = await _remoteDataSource.fetchPolicies();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<ClaimSubmissionResult> submitClaim(ClaimRequest request) async {
    try {
      return await _remoteDataSource.submitClaim(request);
    } on DioException catch (error) {
      final message = error.response?.data is Map<String, dynamic>
          ? (error.response?.data['message']?.toString() ??
              'Claim submission failed.')
          : 'Claim submission failed.';

      return ClaimSubmissionResult(success: false, message: message);
    }
  }
}
