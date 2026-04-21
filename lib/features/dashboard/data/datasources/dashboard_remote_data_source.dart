import 'package:crenno_study_case/core/constants/api.dart';
import 'package:dio/dio.dart';

import '../../../../core/network/models/api_response.dart';
import '../models/policy_model.dart';

abstract class DashboardRemoteDataSource {
  Future<List<PolicyModel>> fetchPolicies();
}

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  const DashboardRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<List<PolicyModel>> fetchPolicies() async {
    final response = await _dio.get(ApiConstants.POLICIES);
    final apiResponse = ApiResponse<List<PolicyModel>>.fromDynamic(
      response.data,
      dataParser: _parsePolicyList,
    );
    final data = apiResponse.data;

    if (data == null) {
      throw const FormatException('Policies payload is empty.');
    }

    return data;
  }

  List<PolicyModel>? _parsePolicyList(dynamic rawData) {
    if (rawData is List) {
      return rawData
          .whereType<Map<String, dynamic>>()
          .map((item) => PolicyModel.fromMap(Map<String, dynamic>.from(item)))
          .toList();
    }
    return null;
  }
}
