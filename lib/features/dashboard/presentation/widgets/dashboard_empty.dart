import 'package:crenno_study_case/core/constants/string_constants.dart';
import 'package:crenno_study_case/core/components/custom_state_card.dart';
import 'package:flutter/material.dart';

class DashboardEmptyWidget extends StatelessWidget {
  const DashboardEmptyWidget({super.key, required this.onRefresh});

  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        CustomStateCard(
          title: StringConstants.dashboardEmptyTitle,
          description: StringConstants.dashboardEmptyDescription,
          actionLabel: StringConstants.commonRefresh,
          onAction: onRefresh,
        ),
      ],
    );
  }
}
