import 'package:flutter/material.dart';

import '../../../../core/components/custom_text.dart';
import '../../../../core/constants/string_constants.dart';
import '../../../../core/utils/context_extension.dart';
import '../../../dashboard/domain/entities/policy.dart';
import 'policy_detail_overview_row.dart';

class PolicyDetailOverviewCard extends StatelessWidget {
  final Policy policy;
  const PolicyDetailOverviewCard({super.key, required this.policy});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.width * 0.04),
      decoration: BoxDecoration(
        color: context.colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(context.width * 0.04),
        border: Border.all(
          color: context.colors.outline.withValues(alpha: 0.14),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: StringConstants.policyOverviewTitle,
            color: context.colors.onSurface,
            weight: FontWeight.w700,
          ),
          SizedBox(height: context.height * 0.012),
          PolicyDetailOverviewRow(
            label: StringConstants.policyOverviewPolicyIdLabel,
            value: policy.id,
          ),
          SizedBox(height: context.height * 0.008),
          PolicyDetailOverviewRow(
            label: StringConstants.policyOverviewCategoryLabel,
            value: policy.type,
          ),
          SizedBox(height: context.height * 0.008),
          PolicyDetailOverviewRow(
            label: StringConstants.policyOverviewDescriptionLabel,
            value: policy.description,
          ),
        ],
      ),
    );
  }
}
