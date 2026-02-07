part of 'admin_bloc.dart';

/// Base class for all admin events.
abstract class AdminEvent extends Equatable {
  const AdminEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load dashboard data.
class AdminLoadDashboard extends AdminEvent {
  const AdminLoadDashboard();
}

/// Event to refresh dashboard data.
class AdminRefreshDashboard extends AdminEvent {
  const AdminRefreshDashboard();
}
