import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:restoapp/core/constants/api_endpoints.dart';

/// Remote data source for restaurant tables.
@injectable
class TableRemoteDataSource {
  final Dio _dio;

  TableRemoteDataSource(this._dio);

  Future<List<dynamic>> getTables() async {
    final response = await _dio.get(ApiEndpoints.tables);
    return response.data['data'] as List<dynamic>;
  }

  Future<Map<String, dynamic>> getTableById(int id) async {
    final response = await _dio.get(ApiEndpoints.tableById(id));
    return response.data['data'] as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> createTable(Map<String, dynamic> data) async {
    final response = await _dio.post(ApiEndpoints.tables, data: data);
    return response.data['data'] as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> updateTable(
    int id,
    Map<String, dynamic> data,
  ) async {
    final response = await _dio.put(ApiEndpoints.tableById(id), data: data);
    return response.data['data'] as Map<String, dynamic>;
  }

  Future<void> updateTableStatus(int id, String status) async {
    await _dio.patch(ApiEndpoints.tableStatus(id), data: {'status': status});
  }

  Future<void> deleteTable(int id) async {
    await _dio.delete(ApiEndpoints.tableById(id));
  }
}
