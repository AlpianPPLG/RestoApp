import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:restoapp/core/constants/api_endpoints.dart';
import 'package:restoapp/domain/entities/enums.dart';

/// Remote data source for user management.
@injectable
class UserRemoteDataSource {
  final Dio _dio;

  UserRemoteDataSource(this._dio);

  Future<List<dynamic>> getUsers() async {
    final response = await _dio.get(ApiEndpoints.users);
    return response.data['data'] as List<dynamic>;
  }

  Future<Map<String, dynamic>> getUserById(int id) async {
    final response = await _dio.get(ApiEndpoints.userById(id));
    return response.data['data'] as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> createUser({
    required String username,
    required String password,
    required String fullName,
    required UserRole role,
  }) async {
    final response = await _dio.post(
      ApiEndpoints.users,
      data: {
        'username': username,
        'password': password,
        'full_name': fullName,
        'role': role.name,
      },
    );
    return response.data['data'] as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> updateUser({
    required int id,
    String? fullName,
    UserRole? role,
  }) async {
    final data = <String, dynamic>{};
    if (fullName != null) data['full_name'] = fullName;
    if (role != null) data['role'] = role.name;

    final response = await _dio.put(ApiEndpoints.userById(id), data: data);
    return response.data['data'] as Map<String, dynamic>;
  }

  Future<void> updatePassword(int id, String newPassword) async {
    await _dio.patch(
      ApiEndpoints.userPassword(id),
      data: {'password': newPassword},
    );
  }

  Future<void> deleteUser(int id) async {
    await _dio.delete(ApiEndpoints.userById(id));
  }
}
