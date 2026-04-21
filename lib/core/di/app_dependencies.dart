import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/claim/data/datasources/claim_remote_data_source.dart';
import '../../features/claim/data/repositories/claim_repository_impl.dart';
import '../../features/claim/domain/repositories/claim_repository.dart';
import '../../features/claim/domain/usecases/submit_claim.dart';
import '../../features/claim/presentation/bloc/claim_form_bloc.dart';
import '../../features/dashboard/data/datasources/dashboard_remote_data_source.dart';
import '../../features/dashboard/data/repositories/dashboard_repository_impl.dart';
import '../../features/dashboard/domain/repositories/dashboard_repository.dart';
import '../../features/dashboard/domain/usecases/get_policies.dart';
import '../../features/dashboard/presentation/bloc/dashboard_bloc.dart';
import '../network/dio.dart';

final GetIt sl = GetIt.instance;

Future<void> initializeAppDependencies() async {
  if (sl.isRegistered<GetPolicies>()) return;

  sl.registerLazySingleton<Dio>(() => DioService().dio);

  sl.registerLazySingleton<DashboardRemoteDataSource>(
    () => DashboardRemoteDataSourceImpl(sl<Dio>()),
  );

  sl.registerLazySingleton<DashboardRepository>(
    () => DashboardRepositoryImpl(sl<DashboardRemoteDataSource>()),
  );

  sl.registerLazySingleton<ClaimRemoteDataSource>(
    () => ClaimRemoteDataSourceImpl(sl<Dio>()),
  );

  sl.registerLazySingleton<ClaimRepository>(
    () => ClaimRepositoryImpl(sl<ClaimRemoteDataSource>()),
  );

  sl.registerLazySingleton<GetPolicies>(
    () => GetPolicies(sl<DashboardRepository>()),
  );

  sl.registerLazySingleton<SubmitClaim>(
    () => SubmitClaim(sl<ClaimRepository>()),
  );

  sl.registerFactory<DashboardBloc>(
    () => DashboardBloc(getPolicies: sl<GetPolicies>()),
  );

  sl.registerFactoryParam<ClaimFormBloc, String, void>(
    (policyId, _) =>
        ClaimFormBloc(policyId: policyId, submitClaim: sl<SubmitClaim>()),
  );
}
