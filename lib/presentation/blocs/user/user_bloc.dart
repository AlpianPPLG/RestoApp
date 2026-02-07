import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:restoapp/core/utils/logger/app_logger.dart';
import 'package:restoapp/domain/entities/user.dart';
import 'package:restoapp/domain/entities/enums.dart';
import 'package:restoapp/domain/repositories/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

/// BLoC for managing user data.
@injectable
class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;

  UserBloc(this._userRepository) : super(const UserInitial()) {
    on<UserLoadAll>(_onLoadAll);
    on<UserCreate>(_onCreate);
    on<UserUpdate>(_onUpdate);
    on<UserUpdatePassword>(_onUpdatePassword);
    on<UserDelete>(_onDelete);

    AppLogger.info('UserBloc initialized', tag: 'USER');
  }

  List<User> _allUsers = [];

  Future<void> _onLoadAll(UserLoadAll event, Emitter<UserState> emit) async {
    AppLogger.blocEvent('UserBloc', 'UserLoadAll');
    emit(const UserLoading());

    try {
      _allUsers = await _userRepository.getUsers();

      emit(
        UserLoaded(
          users: _allUsers,
          adminCount: _allUsers.where((u) => u.role == UserRole.admin).length,
          waiterCount: _allUsers.where((u) => u.role == UserRole.waiter).length,
          cashierCount: _allUsers
              .where((u) => u.role == UserRole.cashier)
              .length,
          kitchenCount: _allUsers
              .where((u) => u.role == UserRole.kitchen)
              .length,
        ),
      );

      AppLogger.info('Loaded ${_allUsers.length} users', tag: 'USER');
    } catch (e) {
      AppLogger.error('Failed to load users', tag: 'USER', error: e);
      emit(UserError(e.toString()));
    }
  }

  Future<void> _onCreate(UserCreate event, Emitter<UserState> emit) async {
    AppLogger.blocEvent(
      'UserBloc',
      'UserCreate',
      data: {'username': event.username},
    );
    emit(const UserLoading());

    try {
      final newUser = await _userRepository.createUser(
        username: event.username,
        password: event.password,
        fullName: event.fullName,
        role: event.role,
      );
      _allUsers = [..._allUsers, newUser];

      emit(
        UserOperationSuccess('User "${newUser.username}" created successfully'),
      );
      _emitLoaded(emit);

      AppLogger.info('User created: ${newUser.username}', tag: 'USER');
    } catch (e) {
      AppLogger.error('Failed to create user', tag: 'USER', error: e);
      emit(UserError(e.toString()));
      _emitLoaded(emit);
    }
  }

  Future<void> _onUpdate(UserUpdate event, Emitter<UserState> emit) async {
    AppLogger.blocEvent('UserBloc', 'UserUpdate', data: {'id': event.id});
    emit(const UserLoading());

    try {
      final updatedUser = await _userRepository.updateUser(
        id: event.id,
        fullName: event.fullName,
        role: event.role,
      );
      _allUsers = _allUsers
          .map((u) => u.id == updatedUser.id ? updatedUser : u)
          .toList();

      emit(
        UserOperationSuccess(
          'User "${updatedUser.username}" updated successfully',
        ),
      );
      _emitLoaded(emit);

      AppLogger.info('User updated: ${updatedUser.username}', tag: 'USER');
    } catch (e) {
      AppLogger.error('Failed to update user', tag: 'USER', error: e);
      emit(UserError(e.toString()));
      _emitLoaded(emit);
    }
  }

  Future<void> _onUpdatePassword(
    UserUpdatePassword event,
    Emitter<UserState> emit,
  ) async {
    AppLogger.blocEvent(
      'UserBloc',
      'UserUpdatePassword',
      data: {'id': event.userId},
    );

    try {
      await _userRepository.updatePassword(event.userId, event.newPassword);
      final user = _allUsers.firstWhere((u) => u.id == event.userId);

      emit(
        UserOperationSuccess(
          'Password for "${user.username}" updated successfully',
        ),
      );
      _emitLoaded(emit);

      AppLogger.info('Password updated for user: ${event.userId}', tag: 'USER');
    } catch (e) {
      AppLogger.error('Failed to update password', tag: 'USER', error: e);
      emit(UserError(e.toString()));
      _emitLoaded(emit);
    }
  }

  Future<void> _onDelete(UserDelete event, Emitter<UserState> emit) async {
    AppLogger.blocEvent('UserBloc', 'UserDelete', data: {'id': event.userId});
    emit(const UserLoading());

    try {
      await _userRepository.deleteUser(event.userId);
      final deletedUser = _allUsers.firstWhere((u) => u.id == event.userId);
      _allUsers = _allUsers.where((u) => u.id != event.userId).toList();

      emit(UserOperationSuccess('User "${deletedUser.username}" deleted'));
      _emitLoaded(emit);

      AppLogger.info('User deleted: ${event.userId}', tag: 'USER');
    } catch (e) {
      AppLogger.error('Failed to delete user', tag: 'USER', error: e);
      emit(UserError(e.toString()));
      _emitLoaded(emit);
    }
  }

  void _emitLoaded(Emitter<UserState> emit) {
    emit(
      UserLoaded(
        users: _allUsers,
        adminCount: _allUsers.where((u) => u.role == UserRole.admin).length,
        waiterCount: _allUsers.where((u) => u.role == UserRole.waiter).length,
        cashierCount: _allUsers.where((u) => u.role == UserRole.cashier).length,
        kitchenCount: _allUsers.where((u) => u.role == UserRole.kitchen).length,
      ),
    );
  }
}
