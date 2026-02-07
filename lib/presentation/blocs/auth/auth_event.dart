part of 'auth_bloc.dart';

/// Base class for all authentication events.
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

/// Event to check authentication status on app start.
class AuthCheckRequested extends AuthEvent {
  const AuthCheckRequested();
}

/// Event to request user login.
class AuthLoginRequested extends AuthEvent {
  final String username;
  final String password;

  const AuthLoginRequested({
    required this.username,
    required this.password,
  });

  @override
  List<Object?> get props => [username, password];
}

/// Event to request user registration.
class AuthRegisterRequested extends AuthEvent {
  final String username;
  final String password;
  final String fullName;
  final UserRole role;

  const AuthRegisterRequested({
    required this.username,
    required this.password,
    required this.fullName,
    required this.role,
  });

  @override
  List<Object?> get props => [username, password, fullName, role];
}

/// Event to request user logout.
class AuthLogoutRequested extends AuthEvent {
  const AuthLogoutRequested();
}
