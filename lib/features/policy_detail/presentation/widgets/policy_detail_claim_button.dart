import 'package:flutter/material.dart';

import '../../../../core/components/custom_filled_button.dart';
import '../../../../core/components/custom_text.dart';
import '../../../../core/constants/string_constants.dart';
import '../../../../core/utils/context_extension.dart';

class PolicyDetailClaimButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color foregroundColor;
  const PolicyDetailClaimButton({
    super.key,
    required this.onPressed,
    required this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.fromLTRB(
        context.width * 0.04,
        context.height * 0.01,
        context.width * 0.04,
        context.height * 0.02,
      ),
      child: CustomFilledButton(
        onPressed: onPressed,
        icon: Icon(Icons.description_outlined, size: context.width * 0.05),
        borderRadius: context.width * 0.04,
        padding: EdgeInsets.symmetric(vertical: context.height * 0.018),
        child: CustomText(
          text: StringConstants.claimSubmitButton,
          color: foregroundColor,
          weight: FontWeight.w600,
        ),
      ),
    );
  }
}
