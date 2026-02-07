import 'package:restoapp/domain/entities/user.dart';
import 'package:restoapp/domain/entities/enums.dart';

/// User repository interface for user management.
abstract class UserRepository {
  /// Get all users.
  Future<List<User>> getUsers();

  /// Get a single user by ID.
  Future<User> getUserById(int id);

  /// Create a new user.
  Future<User> createUser({
    required String username,
    required String password,
    required String fullName,
    required UserRole role,
  });

  /// Update an existing user.
  Future<User> updateUser({required int id, String? fullName, UserRole? role});

  /// Update user password.
  Future<void> updatePassword(int id, String newPassword);

  /// Delete a user.
  Future<void> deleteUser(int id);
}
