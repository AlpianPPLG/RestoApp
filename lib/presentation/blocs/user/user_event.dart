part of 'user_bloc.dart';

/// Base class for all user events.
abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load all users.
class UserLoadAll extends UserEvent {
  const UserLoadAll();
}

/// Event to create a new user.
class UserCreate extends UserEvent {
  final String username;
  final String password;
  final String fullName;
  final UserRole role;

  const UserCreate({
    required this.username,
    required this.password,
    required this.fullName,
    required this.role,
  });

  @override
  List<Object?> get props => [username, password, fullName, role];
}

/// Event to update an existing user.
class UserUpdate extends UserEvent {
  final int id;
  final String? fullName;
  final UserRole? role;

  const UserUpdate({required this.id, this.fullName, this.role});

  @override
  List<Object?> get props => [id, fullName, role];
}

/// Event to update user password.
class UserUpdatePassword extends UserEvent {
  final int userId;
  final String newPassword;

  const UserUpdatePassword({required this.userId, required this.newPassword});

  @override
  List<Object?> get props => [userId, newPassword];
}

/// Event to delete a user.
class UserDelete extends UserEvent {
  final int userId;

  const UserDelete(this.userId);

  @override
  List<Object?> get props => [userId];
}
