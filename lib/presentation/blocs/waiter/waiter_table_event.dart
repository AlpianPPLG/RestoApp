part of 'waiter_table_bloc.dart';

abstract class WaiterTableEvent extends Equatable {
  const WaiterTableEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load all tables
class WaiterTableLoadAll extends WaiterTableEvent {
  const WaiterTableLoadAll();
}

/// Event to refresh tables data
class WaiterTableRefresh extends WaiterTableEvent {
  const WaiterTableRefresh();
}

/// Event to start auto refresh timer
class WaiterTableStartAutoRefresh extends WaiterTableEvent {
  const WaiterTableStartAutoRefresh();
}

/// Event to stop auto refresh timer
class WaiterTableStopAutoRefresh extends WaiterTableEvent {
  const WaiterTableStopAutoRefresh();
}

/// Event to select a table for new order
class WaiterTableSelect extends WaiterTableEvent {
  final RestaurantTable table;

  const WaiterTableSelect({required this.table});

  @override
  List<Object?> get props => [table];
}

/// Event to clear table selection
class WaiterTableClearSelection extends WaiterTableEvent {
  const WaiterTableClearSelection();
}
