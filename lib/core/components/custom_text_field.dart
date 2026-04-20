import 'package:flutter/material.dart';

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
    return TextField(
      onChanged: onChanged,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        errorText: errorText,
      ),
    );
  }
}
