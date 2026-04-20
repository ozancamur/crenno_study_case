import '../entities/claim_request.dart';
import '../entities/claim_submission_result.dart';
import '../entities/policy.dart';

abstract class DashboardRepository {
  Future<List<Policy>> getPolicies();

  Future<ClaimSubmissionResult> submitClaim(ClaimRequest request);
}
