import 'package:flutter/material.dart';

import '../../../../core/components/custom_state_card.dart';
import '../../../../core/constants/string_constants.dart';

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
