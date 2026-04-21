import '../../../../core/network/models/api_response.dart';
import '../../domain/entities/claim_submission_result.dart';

class ClaimSubmissionResponseModel {
  const ClaimSubmissionResponseModel({
    required this.success,
    required this.message,
  });

  factory ClaimSubmissionResponseModel.fromApiResponse(
    ApiResponse<Object?> apiResponse, {
    required int statusCode,
  }) {
    final isHttpSuccess = statusCode >= 200 && statusCode < 300;

    return ClaimSubmissionResponseModel(
      success: apiResponse.success ?? isHttpSuccess,
      message: apiResponse.message ?? 'Claim submitted.',
    );
  }

  final bool success;
  final String message;

  ClaimSubmissionResult toEntity() {
    return ClaimSubmissionResult(success: success, message: message);
  }
}
