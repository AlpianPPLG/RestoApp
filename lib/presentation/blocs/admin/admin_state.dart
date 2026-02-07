part of 'admin_bloc.dart';

/// Base class for all admin states.
abstract class AdminState extends Equatable {
  const AdminState();

  @override
  List<Object?> get props => [];
}

/// Initial state before loading dashboard.
class AdminInitial extends AdminState {
  const AdminInitial();
}

/// State when loading dashboard data.
class AdminLoading extends AdminState {
  const AdminLoading();
}

/// State when dashboard data is loaded.
class AdminLoaded extends AdminState {
  final int totalMenus;
  final int activeMenus;
  final int totalTables;
  final int availableTables;
  final int todayOrders;
  final double todayRevenue;
  final int pendingOrders;

  const AdminLoaded({
    required this.totalMenus,
    required this.activeMenus,
    required this.totalTables,
    required this.availableTables,
    required this.todayOrders,
    required this.todayRevenue,
    required this.pendingOrders,
  });

  @override
  List<Object?> get props => [
    totalMenus,
    activeMenus,
    totalTables,
    availableTables,
    todayOrders,
    todayRevenue,
    pendingOrders,
  ];
}

/// State when dashboard loading fails.
class AdminError extends AdminState {
  final String message;

  const AdminError(this.message);

  @override
  List<Object?> get props => [message];
}
