import 'package:crenno_study_case/core/components/custom_text.dart';
import 'package:crenno_study_case/core/constants/string_constants.dart';
import 'package:crenno_study_case/core/utils/context_extension.dart';
import 'package:crenno_study_case/features/dashboard/domain/entities/policy.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PolicyDetailView extends StatelessWidget {
  const PolicyDetailView({super.key, required this.policy});

  final Policy policy;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final now = DateTime.now();
    final totalDays = policy.endDate.difference(policy.startDate).inDays.abs();
    final elapsedDays = now.difference(policy.startDate).inDays;
    final normalizedTotal = totalDays == 0 ? 1 : totalDays;
    final progress = (elapsedDays / normalizedTotal).clamp(0.0, 1.0);
    final remainingDays = policy.endDate.difference(now).inDays;
    final isActive = remainingDays >= 0;
    final statusLabel = isActive ? 'Active' : 'Expired';
    final periodLabel = isActive
        ? '$remainingDays day${remainingDays == 1 ? '' : 's'} left'
        : 'Policy period ended';

    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: '${StringConstants.policyTitle} ${policy.id}',
          tr: false,
          color: colorScheme.onPrimary,
          weight: FontWeight.w600,
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(context.width * 0.04),
        children: [
          _HeaderPanel(
            policy: policy,
            isActive: isActive,
            statusLabel: statusLabel,
            periodLabel: periodLabel,
            progress: progress,
          ),
          SizedBox(height: context.height * 0.02),
          Row(
            children: [
              Expanded(
                child: _InfoCard(
                  title: StringConstants.policyStartDate,
                  value: _formatDate(policy.startDate),
                  icon: Icons.event_available_rounded,
                ),
              ),
              SizedBox(width: context.width * 0.03),
              Expanded(
                child: _InfoCard(
                  title: StringConstants.policyEndDate,
                  value: _formatDate(policy.endDate),
                  icon: Icons.event_busy_rounded,
                ),
              ),
            ],
          ),
          SizedBox(height: context.height * 0.015),
          _OverviewCard(policy: policy),
          SizedBox(height: context.height * 0.015),
          _CoverageCard(amount: policy.coverageAmount),
          SizedBox(height: context.height * 0.14),
        ],
      ),
      bottomNavigationBar: SafeArea(
        minimum: EdgeInsets.fromLTRB(
          context.width * 0.04,
          context.height * 0.01,
          context.width * 0.04,
          context.height * 0.02,
        ),
        child: FilledButton.icon(
          onPressed: () {
            context.push('/policy/${policy.id}/claim', extra: policy);
          },
          icon: Icon(Icons.description_outlined, size: context.width * 0.05),
          label: CustomText(
            text: StringConstants.claimSubmitButton,
            color: colorScheme.onPrimary,
            weight: FontWeight.w600,
          ),
          style: FilledButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: context.height * 0.018),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(context.width * 0.04),
            ),
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '${date.year}-$month-$day';
  }
}

class _HeaderPanel extends StatelessWidget {
  const _HeaderPanel({
    required this.policy,
    required this.isActive,
    required this.statusLabel,
    required this.periodLabel,
    required this.progress,
  });

  final Policy policy;
  final bool isActive;
  final String statusLabel;
  final String periodLabel;
  final double progress;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.all(context.width * 0.045),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(context.width * 0.05),
        gradient: LinearGradient(
          colors: [
            colorScheme.primary,
            colorScheme.primary.withValues(alpha: 0.78),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: context.width * 0.14,
                height: context.width * 0.14,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _policyIconStatic(policy.type),
                  color: Colors.white,
                  size: context.width * 0.07,
                ),
              ),
              SizedBox(width: context.width * 0.03),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: policy.type,
                      tr: false,
                      color: Colors.white,
                      weight: FontWeight.w700,
                    ),
                    SizedBox(height: context.height * 0.002),
                    CustomText(
                      text: policy.id,
                      tr: false,
                      color: Colors.white.withValues(alpha: 0.9),
                      weight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: context.width * 0.025,
                  vertical: context.height * 0.004,
                ),
                decoration: BoxDecoration(
                  color: isActive
                      ? Colors.green.withValues(alpha: 0.22)
                      : Colors.red.withValues(alpha: 0.22),
                  borderRadius: BorderRadius.circular(context.width * 0.08),
                ),
                child: CustomText(
                  text: statusLabel,
                  tr: false,
                  color: Colors.white,
                  weight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: context.height * 0.014),
          CustomText(
            text: policy.description,
            tr: false,
            color: Colors.white.withValues(alpha: 0.95),
          ),
          SizedBox(height: context.height * 0.016),
          CustomText(
            text: 'Validity Progress',
            tr: false,
            color: Colors.white.withValues(alpha: 0.9),
            weight: FontWeight.w600,
          ),
          SizedBox(height: context.height * 0.006),
          ClipRRect(
            borderRadius: BorderRadius.circular(context.width * 0.04),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: context.height * 0.01,
              backgroundColor: Colors.white.withValues(alpha: 0.26),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
          SizedBox(height: context.height * 0.006),
          CustomText(
            text: periodLabel,
            tr: false,
            color: Colors.white.withValues(alpha: 0.92),
          ),
        ],
      ),
    );
  }

  IconData _policyIconStatic(String type) {
    final normalized = type.toLowerCase();
    if (normalized.contains('vehicle') || normalized.contains('araç')) {
      return Icons.directions_car_filled_rounded;
    }
    if (normalized.contains('health') || normalized.contains('sağlık')) {
      return Icons.health_and_safety_rounded;
    }
    if (normalized.contains('home') || normalized.contains('konut')) {
      return Icons.home_rounded;
    }
    return Icons.shield_rounded;
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  final String title;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.all(context.width * 0.035),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(context.width * 0.04),
        border: Border.all(color: colorScheme.outline.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: context.width * 0.05, color: colorScheme.primary),
          SizedBox(height: context.height * 0.008),
          CustomText(
            text: title,
            tr: false,
            color: colorScheme.onSurface.withValues(alpha: 0.7),
          ),
          SizedBox(height: context.height * 0.003),
          CustomText(
            text: value,
            tr: false,
            color: colorScheme.onSurface,
            weight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}

class _OverviewCard extends StatelessWidget {
  const _OverviewCard({required this.policy});

  final Policy policy;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.all(context.width * 0.04),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(context.width * 0.04),
        border: Border.all(color: colorScheme.outline.withValues(alpha: 0.14)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: 'Policy Overview',
            tr: false,
            color: colorScheme.onSurface,
            weight: FontWeight.w700,
          ),
          SizedBox(height: context.height * 0.012),
          _OverviewRow(label: 'Policy ID', value: policy.id),
          SizedBox(height: context.height * 0.008),
          _OverviewRow(label: 'Category', value: policy.type),
          SizedBox(height: context.height * 0.008),
          _OverviewRow(label: 'Description', value: policy.description),
        ],
      ),
    );
  }
}

class _OverviewRow extends StatelessWidget {
  const _OverviewRow({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: context.width * 0.23,
          child: CustomText(
            text: label,
            tr: false,
            color: colorScheme.onSurface.withValues(alpha: 0.64),
          ),
        ),
        Expanded(
          child: CustomText(
            text: value,
            tr: false,
            color: colorScheme.onSurface,
            weight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _CoverageCard extends StatelessWidget {
  const _CoverageCard({required this.amount});

  final double amount;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.all(context.width * 0.04),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorScheme.primaryContainer.withValues(alpha: 0.8),
            colorScheme.secondaryContainer.withValues(alpha: 0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(context.width * 0.04),
      ),
      child: Row(
        children: [
          Container(
            width: context.width * 0.1,
            height: context.width * 0.1,
            decoration: BoxDecoration(
              color: colorScheme.primary.withValues(alpha: 0.14),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.payments_rounded,
              color: colorScheme.primary,
              size: context.width * 0.05,
            ),
          ),
          SizedBox(width: context.width * 0.03),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: StringConstants.policyCoverage,
                  color: colorScheme.onSurface.withValues(alpha: 0.78),
                ),
                SizedBox(height: context.height * 0.004),
                CustomText(
                  text: '₺${amount.toStringAsFixed(0)}',
                  tr: false,
                  color: colorScheme.onSurface,
                  weight: FontWeight.w700,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
