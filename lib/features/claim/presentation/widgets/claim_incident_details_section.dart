import 'package:flutter/material.dart';

import '../../../../core/components/custom_text.dart';
import '../../../../core/components/custom_text_field.dart';
import '../../../../core/constants/string_constants.dart';
import '../../../../core/utils/context_extension.dart';
import 'claim_section_card.dart';

class ClaimIncidentDetailsSection extends StatelessWidget {
  final bool isDescriptionInvalid;
  final ValueChanged<String> onDescriptionChanged;
  const ClaimIncidentDetailsSection({
    super.key,
    required this.isDescriptionInvalid,
    required this.onDescriptionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ClaimSectionCard(
      title: StringConstants.claimIncidentDetailsSectionTitle,
      child: Column(
        children: [
          CustomTextField(
            label: StringConstants.claimIncidentDescriptionLabel,
            maxLines: 6,
            errorText: isDescriptionInvalid
                ? StringConstants.claimIncidentDescriptionRequired
                : null,
            onChanged: onDescriptionChanged,
          ),
          SizedBox(height: context.height * 0.01),
          Align(
            alignment: Alignment.centerRight,
            child: CustomText(
              text: StringConstants.claimIncidentDetailsHint,
              color: context.colors.onSurface.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }
}
