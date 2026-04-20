import '../../features/dashboard/data/datasources/dashboard_remote_data_source.dart';
import '../../features/dashboard/data/repositories/dashboard_repository_impl.dart';
import '../../features/dashboard/domain/usecases/get_policies.dart';
import '../../features/dashboard/domain/usecases/submit_claim.dart';
import '../network/dio.dart';

class AppDependencies {
  AppDependencies._({required this.getPolicies, required this.submitClaim});

  final GetPolicies getPolicies;
  final SubmitClaim submitClaim;

  factory AppDependencies.create() {
    final dio = DioService().dio;
    final remoteDataSource = DashboardRemoteDataSourceImpl(dio);
    final repository = DashboardRepositoryImpl(remoteDataSource);

    return AppDependencies._(
      getPolicies: GetPolicies(repository),
      submitClaim: SubmitClaim(repository),
    );
  }
}
