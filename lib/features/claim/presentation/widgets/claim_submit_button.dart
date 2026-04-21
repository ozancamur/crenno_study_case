import 'package:flutter/material.dart';

import '../../../../core/components/custom_filled_button.dart';
import '../../../../core/components/custom_text.dart';
import '../../../../core/constants/string_constants.dart';
import '../../../../core/utils/context_extension.dart';

class ClaimSubmitButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onSubmit;
  const ClaimSubmitButton({
    super.key,
    required this.isLoading,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CustomFilledButton(
        onPressed: isLoading ? null : onSubmit,
        borderRadius: context.width * 0.04,
        padding: EdgeInsets.symmetric(vertical: context.height * 0.018),
        child: isLoading
            ? SizedBox(
                width: context.width * 0.05,
                height: context.width * 0.05,
                child: CircularProgressIndicator(
                  strokeWidth: context.width * 0.005,
                ),
              )
            : CustomText(
                text: StringConstants.claimSubmitButton,
                color: context.colors.onPrimary,
                weight: FontWeight.w600,
              ),
      ),
    );
  }
}
