import '../entities/claim_request.dart';
import '../entities/claim_submission_result.dart';
import '../repositories/dashboard_repository.dart';

class SubmitClaim {
  const SubmitClaim(this._repository);

  final DashboardRepository _repository;

  Future<ClaimSubmissionResult> call(ClaimRequest request) {
    return _repository.submitClaim(request);
  }
}
