import 'package:flutter/material.dart';

import '../../../../core/components/custom_text.dart';
import '../../../../core/constants/string_constants.dart';
import '../../../../core/utils/context_extension.dart';

class PolicyDetailCoverageCard extends StatelessWidget {
  final double amount;
  const PolicyDetailCoverageCard({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.width * 0.04),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            context.colors.primaryContainer.withValues(alpha: 0.8),
            context.colors.secondaryContainer.withValues(alpha: 0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(context.width * 0.04),
      ),
      child: Row(
        children: [
          Container(
            width: context.width * 0.1,
            height: context.width * 0.1,
            decoration: BoxDecoration(
              color: context.colors.primary.withValues(alpha: 0.14),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.payments_rounded,
              color: context.colors.primary,
              size: context.width * 0.05,
            ),
          ),
          SizedBox(width: context.width * 0.03),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: StringConstants.policyCoverage,
                  color: context.colors.onSurface.withValues(alpha: 0.78),
                ),
                SizedBox(height: context.height * 0.004),
                CustomText(
                  text: '₺${amount.toStringAsFixed(0)}',
                  tr: false,
                  color: context.colors.onSurface,
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
