import 'package:crenno_study_case/core/config/router_paths.dart';
import 'package:crenno_study_case/core/di/app_dependencies.dart';
import 'package:crenno_study_case/features/claim/presentation/view/claim_form_view.dart';
import 'package:crenno_study_case/features/dashboard/domain/entities/policy.dart';
import 'package:crenno_study_case/features/dashboard/presentation/view/dashboard_view.dart';
import 'package:crenno_study_case/features/policy_detail/presentation/view/policy_detail_view.dart';
import 'package:go_router/go_router.dart';

GoRouter router(AppDependencies dependencies) {
  return GoRouter(
    initialLocation: RouterPaths.DASHBOARD,
    routes: [
      GoRoute(
        path: RouterPaths.DASHBOARD,
        builder: (context, state) =>
            DashboardView(getPolicies: dependencies.getPolicies),
      ),
      GoRoute(
        path: RouterPaths.POLICY,
        builder: (context, state) {
          final policy = state.extra! as Policy;
          return PolicyDetailView(policy: policy);
        },
      ),
      GoRoute(
        path: RouterPaths.CLAIM,
        builder: (context, state) {
          return ClaimFormView(
            policy: state.extra! as Policy,
            submitClaim: dependencies.submitClaim,
          );
        },
      ),
    ],
  );
}
