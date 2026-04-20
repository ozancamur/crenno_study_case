import '../entities/policy.dart';
import '../repositories/dashboard_repository.dart';

class GetPolicies {
  const GetPolicies(this._repository);

  final DashboardRepository _repository;

  Future<List<Policy>> call() {
    return _repository.getPolicies();
  }
}
