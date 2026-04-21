import 'package:flutter/material.dart';

class CustomFilledButton extends StatelessWidget {
  const CustomFilledButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.icon,
    this.style,
    this.padding,
    this.borderRadius,
    this.backgroundColor,
    this.foregroundColor,
    this.minimumSize,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final Widget? icon;
  final ButtonStyle? style;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Size? minimumSize;

  @override
  Widget build(BuildContext context) {
    final resolvedStyle = FilledButton.styleFrom(
      padding: padding,
      minimumSize: minimumSize,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      shape: borderRadius == null
          ? null
          : RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius!),
            ),
    ).merge(style);

    if (icon != null) {
      return FilledButton.icon(
        onPressed: onPressed,
        icon: icon!,
        style: resolvedStyle,
        label: child,
      );
    }

    return FilledButton(
      onPressed: onPressed,
      style: resolvedStyle,
      child: child,
    );
  }
}
