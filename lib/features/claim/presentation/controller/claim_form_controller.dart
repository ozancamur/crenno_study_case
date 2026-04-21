import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/claim_form_bloc.dart';

class ClaimFormController {
  const ClaimFormController();

  Future<void> pickIncidentDate(
    BuildContext context,
    ClaimFormState state,
  ) async {
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

  void onDescriptionChanged(BuildContext context, String value) {
    context.read<ClaimFormBloc>().add(ClaimDescriptionChanged(value));
  }

  void submit(BuildContext context) {
    context.read<ClaimFormBloc>().add(const ClaimSubmitted());
  }
}
