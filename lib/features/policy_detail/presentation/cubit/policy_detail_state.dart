import 'package:equatable/equatable.dart';

import '../../../dashboard/domain/entities/policy.dart';
import '../models/policy_detail_status.dart';

class PolicyDetailState extends Equatable {
  const PolicyDetailState({required this.policy, required this.status});

  factory PolicyDetailState.fromPolicy(Policy policy) {
    return PolicyDetailState(
      policy: policy,
      status: PolicyDetailStatus.fromPolicy(policy),
    );
  }

  final Policy policy;
  final PolicyDetailStatus status;

  @override
  List<Object?> get props => [policy, status];
}
