import 'package:crenno_study_case/core/components/custom_text.dart';
import 'package:crenno_study_case/core/constants/string_constants.dart';
import 'package:crenno_study_case/features/dashboard/domain/usecases/get_policies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/dashboard_bloc.dart';
import '../widgets/dashboard_empty.dart';
import '../widgets/dashboard_error.dart';
import '../widgets/dashboard_loaded.dart';
import '../widgets/dashboard_loading.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key, required this.getPolicies});

  final GetPolicies getPolicies;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DashboardBloc(getPolicies: getPolicies)
            ..add(const DashboardPoliciesRequested()),
      child: Builder(
        builder: (context) {
          Future<void> onRefresh() async {
            final bloc = context.read<DashboardBloc>();
            bloc.add(const DashboardPoliciesRequested());
            await bloc.stream.firstWhere(
              (state) => state.status != DashboardStatus.loading,
            );
          }

          return Scaffold(
            appBar: AppBar(
              title: CustomText(
                text: StringConstants.dashboardTitle,
                color: Theme.of(context).colorScheme.onPrimary,
                weight: FontWeight.w600,
              ),
            ),
            body: RefreshIndicator(
              onRefresh: onRefresh,
              child: BlocBuilder<DashboardBloc, DashboardState>(
                builder: (context, state) {
                  switch (state.status) {
                    case DashboardStatus.initial:
                    case DashboardStatus.loading:
                      return const DashboardLoadingWidget();
                    case DashboardStatus.loaded:
                      if (state.policies.isEmpty) {
                        return DashboardEmptyWidget(
                          onRefresh: () {
                            context.read<DashboardBloc>().add(
                              const DashboardPoliciesRequested(),
                            );
                          },
                        );
                      }

                      return DashboardLoadedWidget(
                        policies: state.policies,
                        onPolicyTap: (policy) {
                          context.push('/policy/${policy.id}', extra: policy);
                        },
                      );
                    case DashboardStatus.error:
                      return DashboardErrorWidget(
                        message: StringConstants.dashboardErrorDescription,
                        onRetry: () {
                          context.read<DashboardBloc>().add(
                            const DashboardPoliciesRequested(),
                          );
                        },
                      );
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
