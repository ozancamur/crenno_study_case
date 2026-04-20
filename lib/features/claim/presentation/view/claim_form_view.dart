import 'package:crenno_study_case/core/components/custom_text.dart';
import 'package:crenno_study_case/core/constants/string_constants.dart';
import 'package:crenno_study_case/features/claim/presentation/bloc/claim_form_bloc.dart';
import 'package:crenno_study_case/features/claim/presentation/widgets/claim_form_error_state.dart';
import 'package:crenno_study_case/features/claim/presentation/widgets/claim_form_idle_state.dart';
import 'package:crenno_study_case/features/claim/presentation/widgets/claim_form_loading_state.dart';
import 'package:crenno_study_case/features/claim/presentation/widgets/claim_form_success_state.dart';
import 'package:crenno_study_case/features/dashboard/domain/entities/policy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ClaimFormView extends StatelessWidget {
  const ClaimFormView({
    super.key,
    required this.policy,
  });

  final Policy policy;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          ClaimFormBloc(policyId: policy.id),
      child: Scaffold(
        appBar: AppBar(
          title: CustomText(
            text: StringConstants.claimFormTitle,
            color: Theme.of(context).colorScheme.onPrimary,
            weight: FontWeight.w600,
          ),
        ),
        body: BlocConsumer<ClaimFormBloc, ClaimFormState>(
          listener: (context, state) {
            if (state.status == ClaimFormStatus.success &&
                state.successMessage != null) {
              context.go('/');
            }

            if (state.status == ClaimFormStatus.error &&
                state.errorMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: CustomText(text: state.errorMessage!, tr: false),
                ),
              );
            }
          },
          builder: (context, state) {
            Future<void> onPickDate() async {
              final now = DateTime.now();
              final picked = await showDatePicker(
                context: context,
                initialDate: state.incidentDate ?? now,
                firstDate: DateTime(now.year - 5),
                lastDate: now,
              );

              if (picked != null && context.mounted) {
                context.read<ClaimFormBloc>().add(ClaimDateChanged(picked));
              }
            }

            void onDescriptionChanged(String value) {
              context.read<ClaimFormBloc>().add(ClaimDescriptionChanged(value));
            }

            void onSubmit() {
              context.read<ClaimFormBloc>().add(const ClaimSubmitted());
            }

            switch (state.status) {
              case ClaimFormStatus.idle:
                return ClaimFormIdleStateWidget(
                  policy: policy,
                  state: state,
                  onPickDate: onPickDate,
                  onDescriptionChanged: onDescriptionChanged,
                  onSubmit: onSubmit,
                );
              case ClaimFormStatus.loading:
                return ClaimFormLoadingStateWidget(
                  policy: policy,
                  state: state,
                  onPickDate: onPickDate,
                  onDescriptionChanged: onDescriptionChanged,
                  onSubmit: onSubmit,
                );
              case ClaimFormStatus.success:
                return ClaimFormSuccessStateWidget(
                  policy: policy,
                  state: state,
                  onPickDate: onPickDate,
                  onDescriptionChanged: onDescriptionChanged,
                  onSubmit: onSubmit,
                );
              case ClaimFormStatus.error:
                return ClaimFormErrorStateWidget(
                  policy: policy,
                  state: state,
                  onPickDate: onPickDate,
                  onDescriptionChanged: onDescriptionChanged,
                  onSubmit: onSubmit,
                );
            }
          },
        ),
      ),
    );
  }
}
