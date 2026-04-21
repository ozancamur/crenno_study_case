import 'package:flutter/material.dart';

import '../../../../core/components/custom_text.dart';
import '../../../../core/constants/string_constants.dart';
import '../../../../core/utils/context_extension.dart';
import '../../../dashboard/domain/entities/policy.dart';

class PolicyDetailHeaderPanel extends StatelessWidget {
  final Policy policy;
  final bool isActive;
  final String statusLabel;
  final String periodLabel;
  final double progress;
  const PolicyDetailHeaderPanel({
    super.key,
    required this.policy,
    required this.isActive,
    required this.statusLabel,
    required this.periodLabel,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.width * 0.045),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(context.width * 0.05),
        gradient: LinearGradient(
          colors: [
            context.colors.primary,
            context.colors.primary.withValues(alpha: 0.78),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: context.width * 0.14,
                height: context.width * 0.14,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _policyIconStatic(policy.type),
                  color: Colors.white,
                  size: context.width * 0.07,
                ),
              ),
              SizedBox(width: context.width * 0.03),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: policy.type,
                      tr: false,
                      color: Colors.white,
                      weight: FontWeight.w700,
                    ),
                    SizedBox(height: context.height * 0.002),
                    CustomText(
                      text: policy.id,
                      tr: false,
                      color: Colors.white.withValues(alpha: 0.9),
                      weight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: context.width * 0.025,
                  vertical: context.height * 0.004,
                ),
                decoration: BoxDecoration(
                  color: isActive
                      ? Colors.green.withValues(alpha: 0.22)
                      : Colors.red.withValues(alpha: 0.22),
                  borderRadius: BorderRadius.circular(context.width * 0.08),
                ),
                child: CustomText(
                  text: statusLabel,
                  tr: false,
                  color: Colors.white,
                  weight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: context.height * 0.014),
          CustomText(
            text: policy.description,
            tr: false,
            color: Colors.white.withValues(alpha: 0.95),
          ),
          SizedBox(height: context.height * 0.016),
          CustomText(
            text: StringConstants.policyValidityProgress,
            color: Colors.white.withValues(alpha: 0.9),
            weight: FontWeight.w600,
          ),
          SizedBox(height: context.height * 0.006),
          ClipRRect(
            borderRadius: BorderRadius.circular(context.width * 0.04),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: context.height * 0.01,
              backgroundColor: Colors.white.withValues(alpha: 0.26),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
          SizedBox(height: context.height * 0.006),
          CustomText(
            text: periodLabel,
            tr: false,
            color: Colors.white.withValues(alpha: 0.92),
          ),
        ],
      ),
    );
  }

  IconData _policyIconStatic(String type) {
    final normalized = type.toLowerCase();
    if (normalized.contains('vehicle') || normalized.contains('araç')) {
      return Icons.directions_car_filled_rounded;
    }
    if (normalized.contains('health') || normalized.contains('sağlık')) {
      return Icons.health_and_safety_rounded;
    }
    if (normalized.contains('home') || normalized.contains('konut')) {
      return Icons.home_rounded;
    }
    return Icons.shield_rounded;
  }
}
