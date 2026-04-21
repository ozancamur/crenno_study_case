import 'package:crenno_study_case/core/components/custom_text.dart';
import 'package:crenno_study_case/core/components/custom_filled_button.dart';
import 'package:crenno_study_case/core/utils/context_extension.dart';
import 'package:flutter/material.dart';

class CustomStateCard extends StatelessWidget {
  const CustomStateCard({
    super.key,
    required this.title,
    required this.description,
    this.actionLabel,
    this.onAction,
  });

  final String title;
  final String description;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(context.width * 0.05),
      child: Padding(
        padding: EdgeInsets.all(context.width * 0.04),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: context.height * 0.01,
          children: [
            CustomText(
              text: title,
              weight: FontWeight.w600,
              align: TextAlign.center,
            ),
            CustomText(text: description, align: TextAlign.center),
            if (actionLabel != null && onAction != null) ...[
              CustomFilledButton(
                onPressed: onAction,
                child: CustomText(
                  text: actionLabel!,
                  color: context.colors.inversePrimary,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
