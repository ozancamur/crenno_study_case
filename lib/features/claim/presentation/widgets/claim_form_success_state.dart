import 'package:crenno_study_case/features/claim/presentation/bloc/claim_form_bloc.dart';
import 'package:crenno_study_case/features/claim/presentation/widgets/claim_form_body.dart';
import 'package:crenno_study_case/features/dashboard/domain/entities/policy.dart';
import 'package:flutter/material.dart';

class ClaimFormSuccessStateWidget extends StatelessWidget {
  const ClaimFormSuccessStateWidget({
    super.key,
    required this.policy,
    required this.state,
    required this.onPickDate,
    required this.onDescriptionChanged,
    required this.onSubmit,
  });

  final Policy policy;
  final ClaimFormState state;
  final Future<void> Function() onPickDate;
  final ValueChanged<String> onDescriptionChanged;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return ClaimFormBody(
      policy: policy,
      state: state,
      onPickDate: onPickDate,
      onDescriptionChanged: onDescriptionChanged,
      onSubmit: onSubmit,
      isLoading: false,
    );
  }
}
