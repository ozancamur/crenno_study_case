import 'package:flutter/material.dart';

import '../../../../core/components/custom_text.dart';
import '../../../../core/constants/string_constants.dart';
import '../../../../core/utils/context_extension.dart';

class ClaimAppbar extends StatelessWidget implements PreferredSizeWidget {
  const ClaimAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: CustomText(
        text: StringConstants.claimFormTitle,
        color: context.colors.onPrimary,
        weight: FontWeight.w600,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
