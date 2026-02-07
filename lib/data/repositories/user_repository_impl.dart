import 'package:injectable/injectable.dart';

import 'package:restoapp/core/error/exceptions.dart';
import 'package:restoapp/domain/entities/user.dart';
import 'package:restoapp/domain/entities/enums.dart';
import 'package:restoapp/domain/repositories/user_repository.dart';
import 'package:restoapp/data/datasources/remote/user_remote_datasource.dart';

/// Concrete implementation of [UserRepository].
@Injectable(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource _remoteDataSource;

  UserRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<User>> getUsers() async {
    try {
      final data = await _remoteDataSource.getUsers();
      return data.map((e) => User.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      if (e is AppException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<User> getUserById(int id) async {
    try {
      final data = await _remoteDataSource.getUserById(id);
      return User.fromJson(data);
    } catch (e) {
      if (e is AppException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<User> createUser({
    required String username,
    required String password,
    required String fullName,
    required UserRole role,
  }) async {
    try {
      final data = await _remoteDataSource.createUser(
        username: username,
        password: password,
        fullName: fullName,
        role: role,
      );
      return User.fromJson(data);
    } catch (e) {
      if (e is AppException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<User> updateUser({
    required int id,
    String? fullName,
    UserRole? role,
  }) async {
    try {
      final data = await _remoteDataSource.updateUser(
        id: id,
        fullName: fullName,
        role: role,
      );
      return User.fromJson(data);
    } catch (e) {
      if (e is AppException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> updatePassword(int id, String newPassword) async {
    try {
      await _remoteDataSource.updatePassword(id, newPassword);
    } catch (e) {
      if (e is AppException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> deleteUser(int id) async {
    try {
      await _remoteDataSource.deleteUser(id);
    } catch (e) {
      if (e is AppException) rethrow;
      throw ServerException(message: e.toString());
    }
  }
}
