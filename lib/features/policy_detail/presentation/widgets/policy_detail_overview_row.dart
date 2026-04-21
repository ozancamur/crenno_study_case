import 'package:flutter/material.dart';

import '../../../../core/components/custom_text.dart';
import '../../../../core/utils/context_extension.dart';

class PolicyDetailOverviewRow extends StatelessWidget {
  final String label;
  final String value;
  const PolicyDetailOverviewRow({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: context.width * 0.23,
          child: CustomText(
            text: label,
            color: context.colors.onSurface.withValues(alpha: 0.64),
          ),
        ),
        Expanded(
          child: CustomText(
            text: value,
            tr: false,
            color: context.colors.onSurface,
            weight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
