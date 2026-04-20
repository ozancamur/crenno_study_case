import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/config/router_paths.dart';
import '../../../../core/constants/string_constants.dart';
import '../bloc/dashboard_bloc.dart';
import '../widgets/dashboard_appbar.dart';
import '../widgets/dashboard_empty.dart';
import '../widgets/dashboard_error.dart';
import '../widgets/dashboard_loaded.dart';
import '../widgets/dashboard_loading.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DashboardBloc()
            ..add(const FetchPoliciesEvent()),
      child: Scaffold(
        appBar: DashboardAppbar(),
        body: RefreshIndicator(
          onRefresh: () async {
            context.read<DashboardBloc>().add(const FetchPoliciesEvent());
          },
          child: BlocBuilder<DashboardBloc, DashboardState>(
            builder: (context, state) {
              switch (state.status) {
                case DashboardStatus.initial:
                case DashboardStatus.loading:
                  return const DashboardLoadingWidget();

                case DashboardStatus.loaded:
                  if (state.policies.isEmpty) return _empty(context);
                  return _loaded(state, context);

                case DashboardStatus.error:
                  return _error(context);
              }
            },
          ),
        ),
      ),
    );
  }

  DashboardEmptyWidget _empty(BuildContext context) {
    return DashboardEmptyWidget(
      onRefresh: () {
        context.read<DashboardBloc>().add(const FetchPoliciesEvent());
      },
    );
  }

  DashboardLoadedWidget _loaded(DashboardState state, BuildContext context) {
    return DashboardLoadedWidget(
      policies: state.policies,
      onPolicyTap: (policy) {
        context.push(RouterPaths.TO_POLICY(policy.id), extra: policy);
      },
    );
  }

  DashboardErrorWidget _error(BuildContext context) {
    return DashboardErrorWidget(
      message: StringConstants.dashboardErrorDescription,
      onRetry: () {
        context.read<DashboardBloc>().add(const FetchPoliciesEvent());
      },
    );
  }
}
