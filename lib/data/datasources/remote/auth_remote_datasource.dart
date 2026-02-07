import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:restoapp/core/constants/api_endpoints.dart';
import 'package:restoapp/domain/entities/enums.dart';

/// Remote data source for authentication.
@injectable
class AuthRemoteDataSource {
  final Dio _dio;

  AuthRemoteDataSource(this._dio);

  Future<Map<String, dynamic>> login({
    required String username,
    required String password,
  }) async {
    final response = await _dio.post(
      ApiEndpoints.login,
      data: {'username': username, 'password': password},
    );
    return response.data as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> register({
    required String username,
    required String password,
    required String fullName,
    required UserRole role,
  }) async {
    final response = await _dio.post(
      ApiEndpoints.register,
      data: {
        'username': username,
        'password': password,
        'full_name': fullName,
        'role': role.name,
      },
    );
    return response.data as Map<String, dynamic>;
  }

  Future<void> logout() async {
    await _dio.post(ApiEndpoints.logout);
  }
}
