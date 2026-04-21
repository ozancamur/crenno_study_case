import '../entities/claim_request.dart';
import '../entities/claim_submission_result.dart';
import '../repositories/claim_repository.dart';

class SubmitClaim {
  const SubmitClaim(this._repository);

  final ClaimRepository _repository;

  Future<ClaimSubmissionResult> call(ClaimRequest request) {
    return _repository.submitClaim(request);
  }
}
