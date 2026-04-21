import 'package:flutter/material.dart';

import '../../../../core/constants/string_constants.dart';
import '../../../../core/utils/context_extension.dart';
import '../../../../core/utils/date_time_extension.dart';
import '../../../../core/utils/string_extension.dart';
import 'policy_detail_info_card.dart';

class PolicyDetailDateRow extends StatelessWidget {
  final DateTime startDate;
  final DateTime endDate;
  const PolicyDetailDateRow({
    super.key,
    required this.startDate,
    required this.endDate,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: PolicyDetailInfoCard(
            title: StringConstants.policyStartDate.translate,
            value: startDate.asIsoDate,
            icon: Icons.event_available_rounded,
          ),
        ),
        SizedBox(width: context.width * 0.03),
        Expanded(
          child: PolicyDetailInfoCard(
            title: StringConstants.policyEndDate.translate,
            value: endDate.asIsoDate,
            icon: Icons.event_busy_rounded,
          ),
        ),
      ],
    );
  }
}
