import 'package:flutter/material.dart';

import '../../../../core/components/custom_text.dart';
import '../../../../core/constants/string_constants.dart';
import '../../../../core/utils/context_extension.dart';
import '../../../../core/utils/string_extension.dart';

class PolicyDetailAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  final String pId;
  const PolicyDetailAppbar({super.key, required this.pId});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: CustomText(
        text: '${StringConstants.policyTitle.translate} $pId',
        tr: false,
        color: context.colors.onPrimary,
        weight: FontWeight.w600,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
