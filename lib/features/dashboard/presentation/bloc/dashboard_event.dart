part of 'dashboard_bloc.dart';

sealed class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object?> get props => [];
}

final class FetchPoliciesEvent extends DashboardEvent {
  const FetchPoliciesEvent();
}

final class RefreshPoliciesEvent extends DashboardEvent {
  const RefreshPoliciesEvent();
}
