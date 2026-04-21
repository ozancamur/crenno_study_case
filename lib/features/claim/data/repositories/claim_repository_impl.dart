import 'package:dio/dio.dart';

import '../../../../core/network/errors/dio_error_handler.dart';
import '../../domain/entities/claim_request.dart';
import '../../domain/entities/claim_submission_result.dart';
import '../../domain/repositories/claim_repository.dart';
import '../datasources/claim_remote_data_source.dart';
import '../models/claim_request_model.dart';

class ClaimRepositoryImpl implements ClaimRepository {
  const ClaimRepositoryImpl(this._remoteDataSource);

  final ClaimRemoteDataSource _remoteDataSource;

  @override
  Future<ClaimSubmissionResult> submitClaim(ClaimRequest request) async {
    try {
      final requestModel = ClaimRequestModel.fromEntity(request);
      final responseModel = await _remoteDataSource.submitClaim(requestModel);
      return responseModel.toEntity();
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
