import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/network/errors/app_exception.dart';
import '../../domain/entities/policy.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(const DashboardState()) {
    on<FetchPoliciesEvent>(_onPoliciesRequested);
  }

  Future<void> _onPoliciesRequested(
    FetchPoliciesEvent event,
    Emitter<DashboardState> emit,
  ) async {
    emit(
      state.copyWith(
        status: DashboardStatus.loading,
        policies: <Policy>[],
        errorMessage: null,
      ),
    );

    try {
      //final policies = await GetPolicies().call();
      emit(
        state.copyWith(
          status: DashboardStatus.loaded,
          policies: [],
          errorMessage: null,
        ),
      );
    } on AppException catch (error) {
      emit(
        state.copyWith(
          status: DashboardStatus.error,
          errorMessage: error.message,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: DashboardStatus.error,
          errorMessage: 'Policies could not be loaded.',
        ),
      );
    }
  }
}
