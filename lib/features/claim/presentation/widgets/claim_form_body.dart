import 'package:crenno_study_case/core/components/custom_text.dart';
import 'package:crenno_study_case/core/constants/string_constants.dart';
import 'package:crenno_study_case/core/utils/string_extension.dart';
import 'package:crenno_study_case/core/widgets/app_text_field.dart';
import 'package:crenno_study_case/features/claim/presentation/bloc/claim_form_bloc.dart';
import 'package:crenno_study_case/features/dashboard/domain/entities/policy.dart';
import 'package:flutter/material.dart';

class ClaimFormBody extends StatelessWidget {
  const ClaimFormBody({
    super.key,
    required this.policy,
    required this.state,
    required this.onPickDate,
    required this.onDescriptionChanged,
    required this.onSubmit,
    required this.isLoading,
  });

  final Policy policy;
  final ClaimFormState state;
  final Future<void> Function() onPickDate;
  final ValueChanged<String> onDescriptionChanged;
  final VoidCallback onSubmit;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text:
                '${StringConstants.claimPolicyLabel.translate}: ${policy.id} (${policy.type})',
            tr: false,
          ),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: onPickDate,
            icon: const Icon(Icons.calendar_month),
            label: CustomText(
              text: state.incidentDate == null
                  ? StringConstants.claimSelectIncidentDate
                  : _formatDate(state.incidentDate!),
              tr: state.incidentDate == null,
            ),
          ),
          if (state.isDateInvalid)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: CustomText(
                text: StringConstants.claimIncidentDateRequired,
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          const SizedBox(height: 16),
          AppTextField(
            label: StringConstants.claimIncidentDescriptionLabel,
            maxLines: 4,
            errorText: state.isDescriptionInvalid
                ? StringConstants.claimIncidentDescriptionRequired
                : null,
            onChanged: onDescriptionChanged,
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: isLoading ? null : onSubmit,
              child: isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : CustomText(
                      text: StringConstants.claimSubmitButton,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '${date.year}-$month-$day';
  }
}
