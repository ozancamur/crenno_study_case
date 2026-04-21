part of 'claim_form_bloc.dart';

enum ClaimFormStatus { idle, loading, success, error }

class ClaimFormState extends Equatable {
  const ClaimFormState({
    this.incidentDate,
    this.description = '',
    this.status = ClaimFormStatus.idle,
    this.errorMessage,
    this.showValidationErrors = false,
    this.successMessage,
  });

  final DateTime? incidentDate;
  final String description;
  final ClaimFormStatus status;
  final String? errorMessage;
  final bool showValidationErrors;
  final String? successMessage;

  bool get isDateInvalid => showValidationErrors && incidentDate == null;
  bool get isDescriptionInvalid =>
      showValidationErrors && description.trim().isEmpty;

  ClaimFormState copyWith({
    DateTime? incidentDate,
    bool clearDate = false,
    String? description,
    ClaimFormStatus? status,
    String? errorMessage,
    bool clearError = false,
    bool? showValidationErrors,
    String? successMessage,
    bool clearSuccess = false,
  }) {
    return ClaimFormState(
      incidentDate: clearDate ? null : (incidentDate ?? this.incidentDate),
      description: description ?? this.description,
      status: status ?? this.status,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      showValidationErrors: showValidationErrors ?? this.showValidationErrors,
      successMessage: clearSuccess
          ? null
          : (successMessage ?? this.successMessage),
    );
  }

  @override
  List<Object?> get props => [
    incidentDate,
    description,
    status,
    errorMessage,
    showValidationErrors,
    successMessage,
  ];
}
