import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/network/errors/app_exception.dart';
import '../../domain/entities/policy.dart';
import '../../domain/usecases/get_policies.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc({required GetPolicies getPolicies})
    : _getPolicies = getPolicies,
      super(const DashboardState()) {
    on<FetchPoliciesEvent>(_onPoliciesRequested);
    on<RefreshPoliciesEvent>(_onPoliciesRequested);
  }

  final GetPolicies _getPolicies;

  Future<void> _onPoliciesRequested(
    DashboardEvent event,
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
      final policies = await _getPolicies.call();
      emit(
        state.copyWith(
          status: DashboardStatus.loaded,
          policies: policies,
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
