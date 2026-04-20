import 'package:dio/dio.dart';

import '../../../../core/network/errors/app_exception.dart';
import '../../../../core/network/errors/dio_error_handler.dart';
import '../../domain/entities/claim_request.dart';
import '../../domain/entities/claim_submission_result.dart';
import '../../domain/entities/policy.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../datasources/dashboard_remote_data_source.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  const DashboardRepositoryImpl(this._remoteDataSource);

  final DashboardRemoteDataSource _remoteDataSource;

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

  @override
  Future<ClaimSubmissionResult> submitClaim(ClaimRequest request) async {
    try {
      return await _remoteDataSource.submitClaim(request);
    } on DioException catch (error) {
      final appException = DioErrorHandler.toAppException(error);
      return ClaimSubmissionResult(
        success: false,
        message: appException.message,
      );
    } catch (_) {
      return const ClaimSubmissionResult(
        success: false,
        message: 'Claim submission failed.',
      );
    }
  }
}
