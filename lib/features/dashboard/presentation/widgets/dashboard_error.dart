import 'package:crenno_study_case/core/constants/string_constants.dart';
import 'package:crenno_study_case/core/widgets/state_card.dart';
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
        StateCard(
          title: StringConstants.dashboardErrorTitle,
          description: message,
          actionLabel: StringConstants.commonTryAgain,
          onAction: onRetry,
        ),
      ],
    );
  }
}
