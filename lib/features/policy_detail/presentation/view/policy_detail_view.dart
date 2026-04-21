import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/config/router_paths.dart';
import '../../../../core/utils/context_extension.dart';
import '../../../dashboard/domain/entities/policy.dart';
import '../cubit/policy_detail_cubit.dart';
import '../cubit/policy_detail_state.dart';
import '../widgets/policy_detail_appbar.dart';
import '../widgets/policy_detail_claim_button.dart';
import '../widgets/policy_detail_coverage_card.dart';
import '../widgets/policy_detail_date_row.dart';
import '../widgets/policy_detail_header_panel.dart';
import '../widgets/policy_detail_overview_card.dart';

class PolicyDetailView extends StatelessWidget {
  final Policy policy;
  const PolicyDetailView({super.key, required this.policy});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PolicyDetailCubit(policy: policy),
      child: BlocBuilder<PolicyDetailCubit, PolicyDetailState>(
        builder: (context, state) {
          return Scaffold(
            appBar: PolicyDetailAppbar(pId: state.policy.id),
            body: ListView(
              padding: EdgeInsets.all(context.width * 0.04),
              children: [
                PolicyDetailHeaderPanel(
                  policy: state.policy,
                  isActive: state.status.isActive,
                  statusLabel: state.status.statusLabel,
                  periodLabel: state.status.periodLabel,
                  progress: state.status.progress,
                ),
                SizedBox(height: context.height * 0.02),
                PolicyDetailDateRow(
                  startDate: state.policy.startDate,
                  endDate: state.policy.endDate,
                ),
                SizedBox(height: context.height * 0.015),
                PolicyDetailOverviewCard(policy: state.policy),
                SizedBox(height: context.height * 0.015),
                PolicyDetailCoverageCard(amount: state.policy.coverageAmount),
              ],
            ),
            bottomNavigationBar: PolicyDetailClaimButton(
              onPressed: () => _navigateToClaim(context, state.policy),
              foregroundColor: context.colors.onPrimary,
            ),
          );
        },
      ),
    );
  }

  void _navigateToClaim(BuildContext context, Policy policy) {
    context.push(RouterPaths.TO_CLAIM(policy.id), extra: policy);
  }
}
