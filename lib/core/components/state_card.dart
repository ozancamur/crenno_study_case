import 'package:crenno_study_case/core/components/custom_text.dart';
import 'package:crenno_study_case/core/utils/context_extension.dart';
import 'package:flutter/material.dart';

class CustomStateCard extends StatelessWidget {
  const CustomStateCard({
    super.key,
    required this.title,
    required this.description,
    this.actionLabel,
    this.onAction,
    this.translateDescription = true,
  });

  final String title;
  final String description;
  final String? actionLabel;
  final VoidCallback? onAction;
  final bool translateDescription;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(context.width * 0.05),
        child: Padding(
          padding: EdgeInsets.all(context.width * 0.04),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                text: title,
                weight: FontWeight.w600,
                align: TextAlign.center,
              ),
              SizedBox(height: context.height * 0.01),
              CustomText(
                text: description,
                tr: translateDescription,
                align: TextAlign.center,
              ),
              if (actionLabel != null && onAction != null) ...[
                SizedBox(height: context.height * 0.015),
                FilledButton(
                  onPressed: onAction,
                  child: CustomText(
                    text: actionLabel!,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
