import 'package:flutter/material.dart';

import '../../../../core/components/custom_text.dart';
import '../../../../core/utils/context_extension.dart';

class PolicyDetailInfoCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  const PolicyDetailInfoCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.width * 0.035),
      decoration: BoxDecoration(
        color: context.colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(context.width * 0.04),
        border: Border.all(
          color: context.colors.outline.withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: context.width * 0.05, color: context.colors.primary),
          SizedBox(height: context.height * 0.008),
          CustomText(
            text: title,
            tr: false,
            color: context.colors.onSurface.withValues(alpha: 0.7),
          ),
          SizedBox(height: context.height * 0.003),
          CustomText(
            text: value,
            tr: false,
            color: context.colors.onSurface,
            weight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}
