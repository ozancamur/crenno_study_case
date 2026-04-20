import 'package:crenno_study_case/core/di/app_dependencies.dart';
import 'package:crenno_study_case/features/claim/presentation/view/claim_form_view.dart';
import 'package:crenno_study_case/features/dashboard/domain/entities/policy.dart';
import 'package:crenno_study_case/features/dashboard/presentation/view/dashboard_view.dart';
import 'package:crenno_study_case/features/policy_detail/presentation/view/policy_detail_view.dart';
import 'package:go_router/go_router.dart';

GoRouter buildRouter(AppDependencies dependencies) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => DashboardView(
          getPolicies: dependencies.getPolicies,
        ),
      ),
      GoRoute(
        path: '/policy/:id',
        builder: (context, state) {
          final policy = state.extra! as Policy;
          return PolicyDetailView(policy: policy);
        },
      ),
      GoRoute(
        path: '/policy/:id/claim',
        builder: (context, state) {
          final policy = state.extra! as Policy;
          return ClaimFormView(
            policy: policy,
            submitClaim: dependencies.submitClaim,
          );
        },
      ),
    ],
  );
}
