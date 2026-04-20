import 'package:crenno_study_case/core/components/custom_text.dart';
import 'package:crenno_study_case/core/constants/string_constants.dart';
import 'package:crenno_study_case/core/utils/context_extension.dart';
import 'package:crenno_study_case/core/utils/string_extension.dart';
import 'package:crenno_study_case/core/components/custom_text_field.dart';
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
      padding: EdgeInsets.all(context.width * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text:
                '${StringConstants.claimPolicyLabel.translate}: ${policy.id} (${policy.type})',
            tr: false,
          ),
          SizedBox(height: context.height * 0.02),
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
              padding: EdgeInsets.only(top: context.height * 0.01),
              child: CustomText(
                text: StringConstants.claimIncidentDateRequired,
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          SizedBox(height: context.height * 0.02),
          CustomTextField(
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
                  ? SizedBox(
                      width: context.width * 0.05,
                      height: context.width * 0.05,
                      child: CircularProgressIndicator(
                        strokeWidth: context.width * 0.005,
                      ),
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
