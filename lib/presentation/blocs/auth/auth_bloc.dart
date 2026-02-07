import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:restoapp/core/utils/logger/app_logger.dart';
import 'package:restoapp/domain/entities/user.dart';
import 'package:restoapp/domain/entities/enums.dart';
import 'package:restoapp/domain/usecases/auth/login_usecase.dart';
import 'package:restoapp/domain/usecases/auth/logout_usecase.dart';
import 'package:restoapp/domain/usecases/auth/register_usecase.dart';
import 'package:restoapp/domain/usecases/auth/get_current_user_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

/// BLoC for managing authentication state.
@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;
  final RegisterUseCase _registerUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;

  AuthBloc(
    this._loginUseCase,
    this._logoutUseCase,
    this._registerUseCase,
    this._getCurrentUserUseCase,
  ) : super(const AuthInitial()) {
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<AuthLoginRequested>(_onAuthLoginRequested);
    on<AuthRegisterRequested>(_onAuthRegisterRequested);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);

    AppLogger.info('AuthBloc initialized', tag: 'AUTH');
  }

  /// Handle authentication check on app start.
  Future<void> _onAuthCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    AppLogger.blocEvent('AuthBloc', 'AuthCheckRequested');
    emit(const AuthLoading());

    final result = await _getCurrentUserUseCase();

    result.fold(
      (failure) {
        AppLogger.warning('Auth check failed: ${failure.message}', tag: 'AUTH');
        emit(const AuthUnauthenticated());
      },
      (user) {
        if (user != null) {
          AppLogger.auth(
            'Auto-login successful',
            username: user.username,
            data: {'role': user.role.name},
          );
          emit(AuthAuthenticated(user));
        } else {
          AppLogger.info('No stored user found', tag: 'AUTH');
          emit(const AuthUnauthenticated());
        }
      },
    );
  }

  /// Handle login request.
  Future<void> _onAuthLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    AppLogger.blocEvent(
      'AuthBloc',
      'AuthLoginRequested',
      data: {'username': event.username},
    );
    AppLogger.auth('Login attempt', username: event.username);

    emit(const AuthLoading());

    final result = await _loginUseCase(
      username: event.username,
      password: event.password,
    );

    result.fold(
      (failure) {
        AppLogger.error(
          'Login failed',
          tag: 'AUTH',
          error: failure.message,
        );
        emit(AuthError(failure.message));
      },
      (user) {
        AppLogger.auth(
          'Login successful',
          username: user.username,
          data: {'role': user.role.name, 'userId': user.id},
        );
        emit(AuthAuthenticated(user));
      },
    );
  }

  /// Handle registration request.
  Future<void> _onAuthRegisterRequested(
    AuthRegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    AppLogger.blocEvent(
      'AuthBloc',
      'AuthRegisterRequested',
      data: {
        'username': event.username,
        'fullName': event.fullName,
        'role': event.role.name,
      },
    );
    AppLogger.auth(
      'Registration attempt',
      username: event.username,
      data: {'role': event.role.name},
    );

    emit(const AuthLoading());

    final result = await _registerUseCase(
      username: event.username,
      password: event.password,
      fullName: event.fullName,
      role: event.role,
    );

    result.fold(
      (failure) {
        AppLogger.error(
          'Registration failed',
          tag: 'AUTH',
          error: failure.message,
        );
        emit(AuthError(failure.message));
      },
      (user) {
        AppLogger.auth(
          'Registration successful',
          username: user.username,
          data: {'role': user.role.name, 'userId': user.id},
        );
        emit(const AuthRegistrationSuccess(
            'Registration successful! Please login.'));
      },
    );
  }

  /// Handle logout request.
  Future<void> _onAuthLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    AppLogger.blocEvent('AuthBloc', 'AuthLogoutRequested');
    AppLogger.auth('Logout attempt');

    emit(const AuthLoading());

    final result = await _logoutUseCase();

    result.fold(
      (failure) {
        AppLogger.error(
          'Logout failed',
          tag: 'AUTH',
          error: failure.message,
        );
        emit(AuthError(failure.message));
      },
      (_) {
        AppLogger.auth('Logout successful');
        emit(const AuthUnauthenticated());
      },
    );
  }
}
