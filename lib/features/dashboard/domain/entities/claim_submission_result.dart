import 'package:equatable/equatable.dart';

class ClaimSubmissionResult extends Equatable {
  const ClaimSubmissionResult({
    required this.success,
    required this.message,
  });

  final bool success;
  final String message;

  @override
  List<Object?> get props => [success, message];
}
