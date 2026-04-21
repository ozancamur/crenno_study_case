import 'package:dio/dio.dart';

import '../../../../core/constants/api.dart';
import '../../../../core/network/models/api_response.dart';
import '../models/claim_request_model.dart';
import '../models/claim_submission_response_model.dart';

abstract class ClaimRemoteDataSource {
  Future<ClaimSubmissionResponseModel> submitClaim(ClaimRequestModel request);
}

class ClaimRemoteDataSourceImpl implements ClaimRemoteDataSource {
  const ClaimRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<ClaimSubmissionResponseModel> submitClaim(
    ClaimRequestModel request,
  ) async {
    final response = await _dio.post(ApiConstants.CLAIM, data: request.toMap());

    final apiResponse = ApiResponse<Object?>.fromDynamic(
      response.data,
      dataParser: (rawData) => rawData,
    );

    return ClaimSubmissionResponseModel.fromApiResponse(
      apiResponse,
      statusCode: response.statusCode ?? 500,
    );
  }
}
