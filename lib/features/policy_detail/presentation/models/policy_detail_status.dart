import 'package:crenno_study_case/core/constants/string_constants.dart';
import 'package:equatable/equatable.dart';
import 'package:crenno_study_case/features/dashboard/domain/entities/policy.dart';
import 'package:easy_localization/easy_localization.dart';

class PolicyDetailStatus extends Equatable {
  const PolicyDetailStatus({
    required this.progress,
    required this.isActive,
    required this.statusLabel,
    required this.periodLabel,
  });

  factory PolicyDetailStatus.fromPolicy(Policy policy, {DateTime? now}) {
    final currentTime = now ?? DateTime.now();
    final remainingDays = policy.remainingDaysAt(currentTime);
    final isActive = policy.isActiveAt(currentTime);

    return PolicyDetailStatus(
      progress: policy.progressAt(currentTime),
      isActive: isActive,
      statusLabel:
          (isActive
                  ? StringConstants.policyStatusActive
                  : StringConstants.policyStatusExpired)
              .tr(),
      periodLabel: isActive
          ? (remainingDays == 1
                    ? StringConstants.policyDaysLeftSingle
                    : StringConstants.policyDaysLeftMultiple)
                .tr(namedArgs: {'count': '$remainingDays'})
          : StringConstants.policyPeriodEnded.tr(),
    );
  }

  final double progress;
  final bool isActive;
  final String statusLabel;
  final String periodLabel;

  @override
  List<Object?> get props => [progress, isActive, statusLabel, periodLabel];
}
