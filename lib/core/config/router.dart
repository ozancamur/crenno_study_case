import 'package:go_router/go_router.dart';

import '../../features/claim/presentation/view/claim_form_view.dart';
import '../../features/dashboard/domain/entities/policy.dart';
import '../../features/dashboard/presentation/view/dashboard_view.dart';
import '../../features/policy_detail/presentation/view/policy_detail_view.dart';
import 'router_paths.dart';

GoRouter router() {
  return GoRouter(
    initialLocation: RouterPaths.DASHBOARD,
    routes: [
      GoRoute(
        path: RouterPaths.DASHBOARD,
        builder: (context, state) => DashboardView(),
      ),
      GoRoute(
        path: RouterPaths.POLICY,
        builder: (context, state) {
          final policy = state.extra as Policy;
          return PolicyDetailView(policy: policy);
        },
      ),
      GoRoute(
        path: RouterPaths.CLAIM,
        builder: (context, state) {
          return ClaimFormView(policy: state.extra as Policy);
        },
      ),
    ],
  );
}
