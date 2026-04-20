import 'package:crenno_study_case/features/dashboard/data/datasources/dashboard_remote_data_source.dart';
import 'package:crenno_study_case/features/dashboard/data/models/policy_model.dart';
import 'package:crenno_study_case/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:crenno_study_case/features/dashboard/domain/entities/claim_request.dart';
import 'package:crenno_study_case/features/dashboard/domain/entities/claim_submission_result.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeDashboardRemoteDataSource implements DashboardRemoteDataSource {
  _FakeDashboardRemoteDataSource({
    this.policies = const <PolicyModel>[],
    this.fetchError,
    this.claimResult =
        const ClaimSubmissionResult(success: true, message: 'ok'),
    this.claimError,
  });

  final List<PolicyModel> policies;
  final Object? fetchError;
  final ClaimSubmissionResult claimResult;
  final DioException? claimError;

  @override
  Future<List<PolicyModel>> fetchPolicies() async {
    if (fetchError != null) {
      throw fetchError!;
    }
    return policies;
  }

  @override
  Future<ClaimSubmissionResult> submitClaim(ClaimRequest request) async {
    if (claimError != null) {
      throw claimError!;
    }
    return claimResult;
  }
}

void main() {
  group('DashboardRepositoryImpl.getPolicies', () {
    test('returns policies on success', () async {
      final repository = DashboardRepositoryImpl(
        _FakeDashboardRemoteDataSource(
          policies: [
            PolicyModel(
              id: 'POL-1',
              type: 'Vehicle',
              startDate: DateTime(2025, 1, 1),
              endDate: DateTime(2026, 1, 1),
              coverageAmount: 100000,
              description: 'Policy description',
            ),
          ],
        ),
      );

      final result = await repository.getPolicies();

      expect(result, hasLength(1));
      expect(result.first.id, 'POL-1');
    });

    test('throws format exception when parse fails', () async {
      final repository = DashboardRepositoryImpl(
        _FakeDashboardRemoteDataSource(fetchError: const FormatException('bad')),
      );

      expect(repository.getPolicies, throwsFormatException);
    });

    test('throws network exception', () async {
      final repository = DashboardRepositoryImpl(
        _FakeDashboardRemoteDataSource(fetchError: Exception('network')),
      );

      expect(repository.getPolicies, throwsException);
    });
  });

  group('DashboardRepositoryImpl.submitClaim', () {
    test('returns success result', () async {
      final repository = DashboardRepositoryImpl(
        _FakeDashboardRemoteDataSource(
          claimResult:
              const ClaimSubmissionResult(success: true, message: 'submitted'),
        ),
      );

      final result = await repository.submitClaim(
        ClaimRequest(
          policyId: 'POL-1',
          incidentDate: DateTime(2026, 1, 1),
          description: 'incident',
        ),
      );

      expect(result.success, isTrue);
      expect(result.message, 'submitted');
    });

    test('maps Dio error to failed result', () async {
      final exception = DioException(
        requestOptions: RequestOptions(path: '/claims'),
        response: Response<dynamic>(
          requestOptions: RequestOptions(path: '/claims'),
          statusCode: 422,
          data: const {'message': 'invalid claim'},
        ),
      );

      final repository = DashboardRepositoryImpl(
        _FakeDashboardRemoteDataSource(claimError: exception),
      );

      final result = await repository.submitClaim(
        ClaimRequest(
          policyId: 'POL-1',
          incidentDate: DateTime(2026, 1, 1),
          description: 'incident',
        ),
      );

      expect(result.success, isFalse);
      expect(result.message, 'invalid claim');
    });
  });
}
