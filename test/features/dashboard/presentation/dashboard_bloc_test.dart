import 'package:bloc_test/bloc_test.dart';
import 'package:crenno_study_case/features/dashboard/domain/entities/claim_request.dart';
import 'package:crenno_study_case/features/dashboard/domain/entities/claim_submission_result.dart';
import 'package:crenno_study_case/features/dashboard/domain/entities/policy.dart';
import 'package:crenno_study_case/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:crenno_study_case/features/dashboard/domain/usecases/get_policies.dart';
import 'package:crenno_study_case/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

class _DashboardRepositorySuccess implements DashboardRepository {
  @override
  Future<List<Policy>> getPolicies() async {
    return [
      Policy(
        id: 'POL-1',
        type: 'Vehicle',
        startDate: DateTime(2025, 1, 1),
        endDate: DateTime(2026, 1, 1),
        coverageAmount: 100000,
        description: 'desc',
      ),
    ];
  }

  @override
  Future<ClaimSubmissionResult> submitClaim(ClaimRequest request) {
    throw UnimplementedError();
  }
}

class _DashboardRepositoryError implements DashboardRepository {
  @override
  Future<List<Policy>> getPolicies() async {
    throw Exception('error');
  }

  @override
  Future<ClaimSubmissionResult> submitClaim(ClaimRequest request) {
    throw UnimplementedError();
  }
}

void main() {
  blocTest<DashboardBloc, DashboardState>(
    'emits loading then loaded when policies load succeeds',
    build: () => DashboardBloc(
      getPolicies: GetPolicies(_DashboardRepositorySuccess()),
    ),
    act: (bloc) => bloc.add(const DashboardPoliciesRequested()),
    expect: () => [
      DashboardState(
        status: DashboardStatus.loading,
        policies: <Policy>[],
      ),
      DashboardState(
        status: DashboardStatus.loaded,
        policies: <Policy>[
          Policy(
            id: 'POL-1',
            type: 'Vehicle',
            startDate: DateTime(2025, 1, 1),
            endDate: DateTime(2026, 1, 1),
            coverageAmount: 100000,
            description: 'desc',
          ),
        ],
      ),
    ],
  );

  blocTest<DashboardBloc, DashboardState>(
    'emits loading then error when policies load fails',
    build: () => DashboardBloc(
      getPolicies: GetPolicies(_DashboardRepositoryError()),
    ),
    act: (bloc) => bloc.add(const DashboardPoliciesRequested()),
    expect: () => [
      DashboardState(
        status: DashboardStatus.loading,
        policies: <Policy>[],
      ),
      DashboardState(
        status: DashboardStatus.error,
        policies: <Policy>[],
        errorMessage: 'Policies could not be loaded.',
      ),
    ],
  );
}
