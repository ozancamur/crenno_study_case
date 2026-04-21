import '../entities/claim_request.dart';
import '../entities/claim_submission_result.dart';

abstract class ClaimRepository {
  Future<ClaimSubmissionResult> submitClaim(ClaimRequest request);
}
