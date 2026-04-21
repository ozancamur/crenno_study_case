import 'package:flutter/material.dart';

import '../../../../core/utils/context_extension.dart';
import '../../../dashboard/domain/entities/policy.dart';
import '../bloc/claim_form_bloc.dart';
import 'claim_incident_date_section.dart';
import 'claim_incident_details_section.dart';
import 'claim_policy_summary_card.dart';

class ClaimFormBody extends StatelessWidget {
  final Policy policy;
  final ClaimFormState state;
  final Future<void> Function() onPickDate;
  final ValueChanged<String> onDescriptionChanged;
  const ClaimFormBody({
    super.key,
    required this.policy,
    required this.state,
    required this.onPickDate,
    required this.onDescriptionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(context.width * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClaimPolicySummaryCard(policy: policy),
          SizedBox(height: context.height * 0.02),
          Expanded(
            child: ListView(
              children: [
                ClaimIncidentDateSection(
                  incidentDate: state.incidentDate,
                  isDateInvalid: state.isDateInvalid,
                  onPickDate: onPickDate,
                ),
                SizedBox(height: context.height * 0.015),
                ClaimIncidentDetailsSection(
                  isDescriptionInvalid: state.isDescriptionInvalid,
                  onDescriptionChanged: onDescriptionChanged,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
