import 'package:flutter/material.dart';

import '../../../../core/components/custom_text.dart';
import '../../../../core/constants/string_constants.dart';
import '../../../../core/utils/context_extension.dart';
import '../../../../core/utils/date_time_extension.dart';
import 'claim_section_card.dart';

class ClaimIncidentDateSection extends StatelessWidget {
  final DateTime? incidentDate;
  final bool isDateInvalid;
  final Future<void> Function() onPickDate;
  const ClaimIncidentDateSection({
    super.key,
    required this.incidentDate,
    required this.isDateInvalid,
    required this.onPickDate,
  });

  @override
  Widget build(BuildContext context) {
    return ClaimSectionCard(
      title: StringConstants.claimIncidentDateSectionTitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(context.width * 0.03),
            onTap: onPickDate,
            child: Ink(
              padding: EdgeInsets.symmetric(
                horizontal: context.width * 0.035,
                vertical: context.height * 0.015,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(context.width * 0.03),
                border: Border.all(
                  color: isDateInvalid
                      ? context.colors.error
                      : context.colors.outline.withValues(alpha: 0.4),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_month_rounded,
                    color: context.colors.primary,
                    size: context.width * 0.05,
                  ),
                  SizedBox(width: context.width * 0.025),
                  Expanded(
                    child: CustomText(
                      text: incidentDate == null
                          ? StringConstants.claimSelectIncidentDate
                          : incidentDate!.asIsoDate,
                      tr: incidentDate == null,
                      color: incidentDate == null
                          ? context.colors.onSurface.withValues(alpha: 0.65)
                          : context.colors.onSurface,
                    ),
                  ),
                  Icon(
                    Icons.chevron_right_rounded,
                    color: context.colors.onSurface.withValues(alpha: 0.45),
                  ),
                ],
              ),
            ),
          ),
          if (isDateInvalid)
            Padding(
              padding: EdgeInsets.only(top: context.height * 0.01),
              child: CustomText(
                text: StringConstants.claimIncidentDateRequired,
                color: context.colors.error,
              ),
            ),
        ],
      ),
    );
  }
}
