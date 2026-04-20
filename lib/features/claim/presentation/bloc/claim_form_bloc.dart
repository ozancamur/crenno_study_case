import 'package:bloc/bloc.dart';
import 'package:crenno_study_case/features/dashboard/data/datasources/dashboard_remote_data_source.dart';
import 'package:crenno_study_case/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../dashboard/domain/entities/claim_request.dart';
import '../../../dashboard/domain/usecases/submit_claim.dart';

part 'claim_form_event.dart';
part 'claim_form_state.dart';

class ClaimFormBloc extends Bloc<ClaimFormEvent, ClaimFormState> {
  final String _policyId;
  ClaimFormBloc({required String policyId})
    : _policyId = policyId,
      super(const ClaimFormState()) {
    on<ClaimDateChanged>(_onDateChanged);
    on<ClaimDescriptionChanged>(_onDescriptionChanged);
    on<ClaimSubmitted>(_onSubmitted);
  }

  void _onDateChanged(ClaimDateChanged event, Emitter<ClaimFormState> emit) {
    emit(
      state.copyWith(
        incidentDate: event.date,
        status: ClaimFormStatus.idle,
        clearError: true,
        clearSuccess: true,
      ),
    );
  }

  void _onDescriptionChanged(
    ClaimDescriptionChanged event,
    Emitter<ClaimFormState> emit,
  ) {
    emit(
      state.copyWith(
        description: event.description,
        status: ClaimFormStatus.idle,
        clearError: true,
        clearSuccess: true,
      ),
    );
  }

  Future<void> _onSubmitted(
    ClaimSubmitted event,
    Emitter<ClaimFormState> emit,
  ) async {
    if (state.incidentDate == null || state.description.trim().isEmpty) {
      emit(
        state.copyWith(
          showValidationErrors: true,
          status: ClaimFormStatus.idle,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: ClaimFormStatus.loading,
        clearError: true,
        clearSuccess: true,
        showValidationErrors: false,
      ),
    );

    final result =
        await SubmitClaim(
          DashboardRepositoryImpl(DashboardRemoteDataSourceImpl(Dio())),
        ).call(
          ClaimRequest(
            policyId: _policyId,
            incidentDate: state.incidentDate!,
            description: state.description.trim(),
          ),
        );

    if (result.success) {
      emit(
        state.copyWith(
          status: ClaimFormStatus.success,
          successMessage: result.message,
          clearError: true,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: ClaimFormStatus.error,
        errorMessage: result.message,
        clearSuccess: true,
      ),
    );
  }
}
