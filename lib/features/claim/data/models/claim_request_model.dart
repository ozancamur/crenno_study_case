import '../../domain/entities/claim_request.dart';

class ClaimRequestModel {
  const ClaimRequestModel({
    required this.policyId,
    required this.incidentDate,
    required this.description,
  });

  factory ClaimRequestModel.fromEntity(ClaimRequest request) {
    return ClaimRequestModel(
      policyId: request.policyId,
      incidentDate: request.incidentDate,
      description: request.description,
    );
  }

  final String policyId;
  final DateTime incidentDate;
  final String description;

  Map<String, dynamic> toMap() {
    return {
      'policyId': policyId,
      'incidentDate': incidentDate.toIso8601String(),
      'description': description,
    };
  }
}
