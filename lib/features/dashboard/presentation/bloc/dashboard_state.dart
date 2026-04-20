part of 'dashboard_bloc.dart';

enum DashboardStatus { initial, loading, loaded, error }

final class DashboardState extends Equatable {
  const DashboardState({
    this.status = DashboardStatus.initial,
    this.policies = const <Policy>[],
    this.errorMessage,
  });

  final DashboardStatus status;
  final List<Policy> policies;
  final String? errorMessage;

  DashboardState copyWith({
    DashboardStatus? status,
    List<Policy>? policies,
    String? errorMessage,
  }) {
    return DashboardState(
      status: status ?? this.status,
      policies: policies ?? this.policies,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, policies, errorMessage];
}
