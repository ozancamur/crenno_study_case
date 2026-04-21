import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/components/custom_text.dart';
import '../../../../core/di/app_dependencies.dart';
import '../../../../core/utils/context_extension.dart';
import '../../../dashboard/domain/entities/policy.dart';
import '../bloc/claim_form_bloc.dart';
import '../controller/claim_form_controller.dart';
import '../widgets/claim_appbar.dart';
import '../widgets/claim_form_body.dart';
import '../widgets/claim_submit_button.dart';

class ClaimFormView extends StatelessWidget {
  final Policy policy;
  final ClaimFormController _controller = const ClaimFormController();
  const ClaimFormView({super.key, required this.policy});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ClaimFormBloc>(param1: policy.id),
      child: BlocConsumer<ClaimFormBloc, ClaimFormState>(
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
          return Scaffold(
            appBar: const ClaimAppbar(),
            body: ClaimFormBody(
              policy: policy,
              state: state,
              onPickDate: () => _controller.pickIncidentDate(context, state),
              onDescriptionChanged: (value) =>
                  _controller.onDescriptionChanged(context, value),
            ),
            bottomNavigationBar: SafeArea(
              minimum: EdgeInsets.fromLTRB(
                context.width * 0.04,
                context.height * 0.01,
                context.width * 0.04,
                context.height * 0.02,
              ),
              child: ClaimSubmitButton(
                isLoading: state.status == ClaimFormStatus.loading,
                onSubmit: () => _controller.submit(context),
              ),
            ),
          );
        },
      ),
    );
  }
}
