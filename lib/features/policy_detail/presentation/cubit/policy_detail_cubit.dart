import 'package:bloc/bloc.dart';

import '../../../dashboard/domain/entities/policy.dart';
import 'policy_detail_state.dart';

class PolicyDetailCubit extends Cubit<PolicyDetailState> {
  PolicyDetailCubit({required Policy policy})
    : super(PolicyDetailState.fromPolicy(policy));
}
