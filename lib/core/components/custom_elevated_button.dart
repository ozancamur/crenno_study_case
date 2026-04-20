import 'package:flutter/material.dart';

import '../utils/context_extension.dart';

class CustomElevatedButton extends StatelessWidget {
  final Function()? onPressed;
  final Widget child;
  final Color? borderColor;
  final Color? color;
  final double? borderWidth;
  final double? height;
  final double? width;
  final double? radius;
  const CustomElevatedButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.height,
    this.width,
    this.borderColor,
    this.borderWidth,
    this.radius,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        fixedSize: Size(width ?? context.width, height ?? context.height * .1),
        elevation: 0,
        backgroundColor: color,
        overlayColor: Colors.white,
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: borderWidth ?? 0,
            color: borderColor ?? Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(radius ?? 100),
        ),
      ),
      child: child,
    );
  }
}
