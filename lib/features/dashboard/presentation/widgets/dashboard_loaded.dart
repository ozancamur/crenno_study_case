import 'package:crenno_study_case/core/components/custom_text.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/policy.dart';

class DashboardLoadedWidget extends StatelessWidget {
  const DashboardLoadedWidget({
    super.key,
    required this.policies,
    required this.onPolicyTap,
  });

  final List<Policy> policies;
  final ValueChanged<Policy> onPolicyTap;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: policies.length,
      separatorBuilder: (_, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final policy = policies[index];
        return Card(
          child: ListTile(
            onTap: () => onPolicyTap(policy),
            title: CustomText(text: '${policy.type} - ${policy.id}', tr: false),
            subtitle: CustomText(
              text: policy.description,
              tr: false,
              maxLine: 2,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: CustomText(
              text: '₺${policy.coverageAmount.toStringAsFixed(0)}',
              tr: false,
              weight: FontWeight.w600,
            ),
          ),
        );
      },
    );
  }
}
