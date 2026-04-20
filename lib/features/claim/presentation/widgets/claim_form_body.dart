import 'package:crenno_study_case/core/components/custom_text.dart';
import 'package:crenno_study_case/core/constants/string_constants.dart';
import 'package:crenno_study_case/core/utils/context_extension.dart';
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
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.all(context.width * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(context.width * 0.04),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  colorScheme.primary,
                  colorScheme.primary.withValues(alpha: 0.78),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(context.width * 0.05),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: context.width * 0.12,
                  height: context.width * 0.12,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.assignment_outlined,
                    color: Colors.white,
                    size: context.width * 0.06,
                  ),
                ),
                SizedBox(width: context.width * 0.03),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: StringConstants.claimPolicyLabel,
                        color: Colors.white.withValues(alpha: 0.9),
                        weight: FontWeight.w500,
                      ),
                      SizedBox(height: context.height * 0.003),
                      CustomText(
                        text: '${policy.id} (${policy.type})',
                        tr: false,
                        color: Colors.white,
                        weight: FontWeight.w700,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: context.height * 0.02),
          Expanded(
            child: ListView(
              children: [
                _SectionCard(
                  title: 'Incident Date',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(
                          context.width * 0.03,
                        ),
                        onTap: onPickDate,
                        child: Ink(
                          padding: EdgeInsets.symmetric(
                            horizontal: context.width * 0.035,
                            vertical: context.height * 0.015,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              context.width * 0.03,
                            ),
                            border: Border.all(
                              color: state.isDateInvalid
                                  ? colorScheme.error
                                  : colorScheme.outline.withValues(alpha: 0.4),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_month_rounded,
                                color: colorScheme.primary,
                                size: context.width * 0.05,
                              ),
                              SizedBox(width: context.width * 0.025),
                              Expanded(
                                child: CustomText(
                                  text: state.incidentDate == null
                                      ? StringConstants.claimSelectIncidentDate
                                      : _formatDate(state.incidentDate!),
                                  tr: state.incidentDate == null,
                                  color: state.incidentDate == null
                                      ? colorScheme.onSurface.withValues(
                                          alpha: 0.65,
                                        )
                                      : colorScheme.onSurface,
                                ),
                              ),
                              Icon(
                                Icons.chevron_right_rounded,
                                color: colorScheme.onSurface.withValues(
                                  alpha: 0.45,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (state.isDateInvalid)
                        Padding(
                          padding: EdgeInsets.only(top: context.height * 0.01),
                          child: CustomText(
                            text: StringConstants.claimIncidentDateRequired,
                            color: colorScheme.error,
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: context.height * 0.015),
                _SectionCard(
                  title: 'Incident Details',
                  child: Column(
                    children: [
                      CustomTextField(
                        label: StringConstants.claimIncidentDescriptionLabel,
                        maxLines: 6,
                        errorText: state.isDescriptionInvalid
                            ? StringConstants.claimIncidentDescriptionRequired
                            : null,
                        onChanged: onDescriptionChanged,
                      ),
                      SizedBox(height: context.height * 0.01),
                      Align(
                        alignment: Alignment.centerRight,
                        child: CustomText(
                          text: 'Provide brief and clear incident summary',
                          tr: false,
                          color: colorScheme.onSurface.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: context.height * 0.01),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: isLoading ? null : onSubmit,
              style: FilledButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: context.height * 0.018),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(context.width * 0.04),
                ),
              ),
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
                      color: colorScheme.onPrimary,
                      weight: FontWeight.w600,
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

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.all(context.width * 0.04),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(context.width * 0.04),
        border: Border.all(color: colorScheme.outline.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: title,
            tr: false,
            weight: FontWeight.w700,
            color: colorScheme.onSurface,
          ),
          SizedBox(height: context.height * 0.012),
          child,
        ],
      ),
    );
  }
}
