import 'package:flutter/material.dart';

import '../../../../core/components/custom_text.dart';
import '../../../../core/constants/string_constants.dart';
import '../../../../core/utils/context_extension.dart';
import '../../../dashboard/domain/entities/policy.dart';

class ClaimPolicySummaryCard extends StatelessWidget {
  final Policy policy;
  const ClaimPolicySummaryCard({super.key, required this.policy});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.width * 0.04),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            context.colors.primary,
            context.colors.primary.withValues(alpha: 0.78),
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
    );
  }
}
