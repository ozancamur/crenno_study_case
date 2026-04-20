import 'package:crenno_study_case/core/utils/string_extension.dart';
import 'package:flutter/material.dart';

import '../constants/font_size_enum.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
    this.color,
    this.size,
    this.weight = FontWeight.w400,
    this.align,
    this.maxLine,
    this.decoration = TextDecoration.none,
    this.overflow,
    this.family,
    this.height,
    this.tr = true,
    this.spacing = 0,
  });

  final String text;
  final Color? color;
  final FontSizeEnum? size;
  final FontWeight? weight;
  final TextAlign? align;
  final int? maxLine;
  final TextDecoration decoration;
  final TextOverflow? overflow;
  final String? family;
  final double? height;
  final bool tr;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final fontSize = size?.value.first;

    return Text(
      tr ? text.translate : text,
      maxLines: maxLine,
      textAlign: align,
      overflow: overflow,
      style: TextStyle(
        fontSize: fontSize,
        decoration: decoration,
        color: color,
        fontWeight: weight,
        height: height,
        letterSpacing: spacing,
        fontFamily: family,
      ),
    );
  }
}
