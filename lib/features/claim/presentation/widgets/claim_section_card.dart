import 'package:flutter/material.dart';

import '../../../../core/components/custom_text.dart';
import '../../../../core/utils/context_extension.dart';

class ClaimSectionCard extends StatelessWidget {
  final String title;
  final Widget child;
  const ClaimSectionCard({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.width * 0.04),
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
          CustomText(
            text: title,
            tr: true,
            weight: FontWeight.w700,
            color: context.colors.onSurface,
          ),
          SizedBox(height: context.height * 0.012),
          child,
        ],
      ),
    );
  }
}
