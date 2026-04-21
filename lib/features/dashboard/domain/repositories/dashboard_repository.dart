import '../entities/policy.dart';

abstract class DashboardRepository {
  Future<List<Policy>> getPolicies();
}
