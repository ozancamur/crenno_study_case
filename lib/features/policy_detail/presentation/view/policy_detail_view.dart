import 'package:crenno_study_case/core/components/custom_text.dart';
import 'package:crenno_study_case/core/constants/string_constants.dart';
import 'package:crenno_study_case/core/utils/string_extension.dart';
import 'package:crenno_study_case/features/dashboard/domain/entities/policy.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PolicyDetailView extends StatelessWidget {
  const PolicyDetailView({super.key, required this.policy});

  final Policy policy;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: '${StringConstants.policyTitle.translate} ${policy.id}',
          tr: false,
          color: Theme.of(context).colorScheme.onPrimary,
          weight: FontWeight.w600,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(text: policy.type, tr: false, weight: FontWeight.w700),
            const SizedBox(height: 8),
            CustomText(text: policy.description, tr: false),
            const SizedBox(height: 16),
            CustomText(
              text:
                  '${StringConstants.policyStartDate.translate}: ${_formatDate(policy.startDate)}',
              tr: false,
            ),
            CustomText(
              text:
                  '${StringConstants.policyEndDate.translate}: ${_formatDate(policy.endDate)}',
              tr: false,
            ),
            CustomText(
              text:
                  '${StringConstants.policyCoverage.translate}: ₺${policy.coverageAmount.toStringAsFixed(0)}',
              tr: false,
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  context.push('/policy/${policy.id}/claim', extra: policy);
                },
                child: CustomText(
                  text: StringConstants.claimSubmitButton,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '${date.year}-$month-$day';
  }
}
