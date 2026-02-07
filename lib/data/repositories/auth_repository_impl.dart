import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

import 'package:restoapp/core/constants/app_constants.dart';
import 'package:restoapp/core/error/exceptions.dart';
import 'package:restoapp/core/error/failures.dart';
import 'package:restoapp/domain/entities/user.dart';
import 'package:restoapp/domain/entities/enums.dart';
import 'package:restoapp/domain/repositories/auth_repository.dart';
import 'package:restoapp/data/datasources/remote/auth_remote_datasource.dart';

/// Concrete implementation of [AuthRepository].
@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final FlutterSecureStorage _secureStorage;

  AuthRepositoryImpl(this._remoteDataSource, this._secureStorage);

  @override
  Future<Either<Failure, User>> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await _remoteDataSource.login(
        username: username,
        password: password,
      );

      // API returns: { data: { user: {...}, token: "..." } }
      final data = response['data'] as Map<String, dynamic>?;
      final userData = data?['user'] ?? response['user'] ?? response;
      final token = data?['token'] ?? response['token'] as String?;

      if (token != null) {
        await _secureStorage.write(
          key: AppConstants.authTokenKey,
          value: token,
        );
      }

      final user = User.fromJson(userData as Map<String, dynamic>);

      // Store user data
      await _secureStorage.write(
        key: AppConstants.userDataKey,
        value: jsonEncode(user.toJson()),
      );

      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on DioException catch (e) {
      final innerError = e.error;
      if (innerError is AppException) {
        return Left(NetworkFailure(message: innerError.message));
      }
      return const Left(
        NetworkFailure(
          message:
              'Tidak dapat terhubung ke server. Pastikan backend sudah berjalan.',
        ),
      );
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> register({
    required String username,
    required String password,
    required String fullName,
    required UserRole role,
  }) async {
    try {
      final response = await _remoteDataSource.register(
        username: username,
        password: password,
        fullName: fullName,
        role: role,
      );

      final userData = response['data'] ?? response;
      final user = User.fromJson(userData as Map<String, dynamic>);

      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on DioException catch (e) {
      final innerError = e.error;
      if (innerError is AppException) {
        return Left(NetworkFailure(message: innerError.message));
      }
      return const Left(
        NetworkFailure(
          message:
              'Tidak dapat terhubung ke server. Pastikan backend sudah berjalan.',
        ),
      );
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _remoteDataSource.logout();
      await _secureStorage.delete(key: AppConstants.authTokenKey);
      await _secureStorage.delete(key: AppConstants.userDataKey);
      return const Right(null);
    } catch (e) {
      // Logout locally even if API call fails
      await _secureStorage.delete(key: AppConstants.authTokenKey);
      await _secureStorage.delete(key: AppConstants.userDataKey);
      return const Right(null);
    }
  }

  @override
  Future<Either<Failure, User?>> getCurrentUser() async {
    try {
      final userData = await _secureStorage.read(key: AppConstants.userDataKey);
      if (userData == null) return const Right(null);
      final user = User.fromJson(jsonDecode(userData) as Map<String, dynamic>);
      return Right(user);
    } catch (e) {
      return const Left(CacheFailure(message: 'Failed to get current user'));
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    final token = await _secureStorage.read(key: AppConstants.authTokenKey);
    return token != null && token.isNotEmpty;
  }

  @override
  Future<String?> getToken() async {
    return _secureStorage.read(key: AppConstants.authTokenKey);
  }
}
