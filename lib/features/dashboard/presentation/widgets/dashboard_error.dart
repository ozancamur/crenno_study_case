import 'package:crenno_study_case/core/constants/string_constants.dart';
import 'package:crenno_study_case/core/components/state_card.dart';
import 'package:flutter/material.dart';

class DashboardErrorWidget extends StatelessWidget {
  const DashboardErrorWidget({
    super.key,
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        CustomStateCard(
          title: StringConstants.dashboardErrorTitle,
          description: message,
          actionLabel: StringConstants.commonTryAgain,
          onAction: onRetry,
        ),
      ],
    );
  }
}
