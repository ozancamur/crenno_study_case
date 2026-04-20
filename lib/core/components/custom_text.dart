import 'package:auto_size_text/auto_size_text.dart';
import 'package:crenno_study_case/core/utils/string_extension.dart';
import 'package:flutter/material.dart';

import '../constants/font_size_enum.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color color;
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
  const CustomText({
    super.key,
    required this.text,
    this.color = Colors.white,
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

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      tr ? text.translate : text,
      presetFontSizes: size?.value ?? FontSizeEnum.medium.value,
      maxLines: maxLine,
      textAlign: align,
      style: TextStyle(
        decoration: decoration,
        color: color,
        fontWeight: weight,
        overflow: overflow,
        height: height,
        letterSpacing: spacing,
        fontFamily: family,
      ),
    );
  }
}
