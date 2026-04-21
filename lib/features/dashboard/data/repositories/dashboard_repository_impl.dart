import 'package:dio/dio.dart';

import '../../../../core/network/errors/app_exception.dart';
import '../../../../core/network/errors/dio_error_handler.dart';
import '../../domain/entities/policy.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../datasources/dashboard_remote_data_source.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource _remoteDataSource;
  const DashboardRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<Policy>> getPolicies() async {
    try {
      final models = await _remoteDataSource.fetchPolicies();
      return models.map((model) => model.toEntity()).toList();
    } on DioException catch (error) {
      throw DioErrorHandler.toAppException(error);
    } on FormatException catch (error) {
      throw AppException(error.message);
    } catch (_) {
      throw const AppException('Policies could not be loaded.');
    }
  }
}
