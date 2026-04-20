import 'package:bloc_test/bloc_test.dart';
import 'package:crenno_study_case/features/claim/presentation/bloc/claim_form_bloc.dart';
import 'package:crenno_study_case/features/dashboard/domain/entities/claim_request.dart';
import 'package:crenno_study_case/features/dashboard/domain/entities/claim_submission_result.dart';
import 'package:crenno_study_case/features/dashboard/domain/entities/policy.dart';
import 'package:crenno_study_case/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:crenno_study_case/features/dashboard/domain/usecases/submit_claim.dart';
import 'package:flutter_test/flutter_test.dart';

class _ClaimRepositorySuccess implements DashboardRepository {
  @override
  Future<List<Policy>> getPolicies() {
    throw UnimplementedError();
  }

  @override
  Future<ClaimSubmissionResult> submitClaim(ClaimRequest request) async {
    return const ClaimSubmissionResult(success: true, message: 'submitted');
  }
}

class _ClaimRepositoryError implements DashboardRepository {
  @override
  Future<List<Policy>> getPolicies() {
    throw UnimplementedError();
  }

  @override
  Future<ClaimSubmissionResult> submitClaim(ClaimRequest request) async {
    return const ClaimSubmissionResult(success: false, message: 'failed');
  }
}

void main() {
  blocTest<ClaimFormBloc, ClaimFormState>(
    'emits validation error when submitting empty form',
    build: () => ClaimFormBloc(
      policyId: 'POL-1',
      submitClaim: SubmitClaim(_ClaimRepositorySuccess()),
    ),
    act: (bloc) => bloc.add(const ClaimSubmitted()),
    expect: () => [
      const ClaimFormState(showValidationErrors: true),
    ],
  );

  blocTest<ClaimFormBloc, ClaimFormState>(
    'emits loading then success when submit succeeds',
    build: () => ClaimFormBloc(
      policyId: 'POL-1',
      submitClaim: SubmitClaim(_ClaimRepositorySuccess()),
    ),
    act: (bloc) {
      bloc
        ..add(ClaimDateChanged(DateTime(2026, 1, 1)))
        ..add(const ClaimDescriptionChanged('incident'))
        ..add(const ClaimSubmitted());
    },
    expect: () => [
      ClaimFormState(
        incidentDate: DateTime(2026, 1, 1),
      ),
      ClaimFormState(
        incidentDate: DateTime(2026, 1, 1),
        description: 'incident',
      ),
      ClaimFormState(
        incidentDate: DateTime(2026, 1, 1),
        description: 'incident',
        status: ClaimFormStatus.loading,
      ),
      ClaimFormState(
        incidentDate: DateTime(2026, 1, 1),
        description: 'incident',
        status: ClaimFormStatus.success,
        successMessage: 'submitted',
      ),
    ],
  );

  blocTest<ClaimFormBloc, ClaimFormState>(
    'emits loading then error when submit fails',
    build: () => ClaimFormBloc(
      policyId: 'POL-1',
      submitClaim: SubmitClaim(_ClaimRepositoryError()),
    ),
    act: (bloc) {
      bloc
        ..add(ClaimDateChanged(DateTime(2026, 1, 1)))
        ..add(const ClaimDescriptionChanged('incident'))
        ..add(const ClaimSubmitted());
    },
    expect: () => [
      ClaimFormState(
        incidentDate: DateTime(2026, 1, 1),
      ),
      ClaimFormState(
        incidentDate: DateTime(2026, 1, 1),
        description: 'incident',
      ),
      ClaimFormState(
        incidentDate: DateTime(2026, 1, 1),
        description: 'incident',
        status: ClaimFormStatus.loading,
      ),
      ClaimFormState(
        incidentDate: DateTime(2026, 1, 1),
        description: 'incident',
        status: ClaimFormStatus.error,
        errorMessage: 'failed',
      ),
    ],
  );
}
