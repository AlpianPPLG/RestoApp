import 'package:dartz/dartz.dart';
import 'package:restoapp/core/error/failures.dart';
import 'package:restoapp/domain/entities/user.dart';
import 'package:restoapp/domain/entities/enums.dart';

/// Authentication repository interface.
abstract class AuthRepository {
  /// Login with username and password.
  Future<Either<Failure, User>> login({
    required String username,
    required String password,
  });

  /// Register new user.
  Future<Either<Failure, User>> register({
    required String username,
    required String password,
    required String fullName,
    required UserRole role,
  });

  /// Logout current user.
  Future<Either<Failure, void>> logout();

  /// Get current authenticated user.
  Future<Either<Failure, User?>> getCurrentUser();

  /// Check if user is logged in.
  Future<bool> isLoggedIn();

  /// Get stored auth token.
  Future<String?> getToken();
}
