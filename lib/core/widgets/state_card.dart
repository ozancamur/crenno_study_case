import 'package:crenno_study_case/core/components/custom_text.dart';
import 'package:flutter/material.dart';

class StateCard extends StatelessWidget {
  const StateCard({
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
        margin: const EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                text: title,
                weight: FontWeight.w600,
                align: TextAlign.center,
              ),
              const SizedBox(height: 8),
              CustomText(
                text: description,
                tr: translateDescription,
                align: TextAlign.center,
              ),
              if (actionLabel != null && onAction != null) ...[
                const SizedBox(height: 12),
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
