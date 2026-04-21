import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.label,
    required this.onChanged,
    this.maxLines = 1,
    this.errorText,
    this.translateLabel = true,
    this.translateErrorText = true,
  });

  final String label;
  final ValueChanged<String> onChanged;
  final int maxLines;
  final String? errorText;
  final bool translateLabel;
  final bool translateErrorText;

  @override
  Widget build(BuildContext context) {
    final resolvedLabel = translateLabel ? label.tr() : label;
    final resolvedErrorText = errorText == null
        ? null
        : (translateErrorText ? errorText!.tr() : errorText);

    return TextField(
      onChanged: onChanged,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: resolvedLabel,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        errorText: resolvedErrorText,
      ),
    );
  }
}
