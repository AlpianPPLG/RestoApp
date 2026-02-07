part of 'user_bloc.dart';

/// Base class for all user states.
abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

/// Initial state before loading users.
class UserInitial extends UserState {
  const UserInitial();
}

/// State when loading user data.
class UserLoading extends UserState {
  const UserLoading();
}

/// State when users are loaded.
class UserLoaded extends UserState {
  final List<User> users;
  final int adminCount;
  final int waiterCount;
  final int cashierCount;
  final int kitchenCount;

  const UserLoaded({
    required this.users,
    required this.adminCount,
    required this.waiterCount,
    required this.cashierCount,
    required this.kitchenCount,
  });

  int get totalCount => users.length;

  @override
  List<Object?> get props => [
    users,
    adminCount,
    waiterCount,
    cashierCount,
    kitchenCount,
  ];
}

/// State when a user operation succeeds.
class UserOperationSuccess extends UserState {
  final String message;

  const UserOperationSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

/// State when user loading fails.
class UserError extends UserState {
  final String message;

  const UserError(this.message);

  @override
  List<Object?> get props => [message];
}
