part of 'table_bloc.dart';

/// Base class for all table events.
abstract class TableEvent extends Equatable {
  const TableEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load all tables.
class TableLoadAll extends TableEvent {
  const TableLoadAll();
}

/// Event to create a new table.
class TableCreate extends TableEvent {
  final RestaurantTable table;

  const TableCreate(this.table);

  @override
  List<Object?> get props => [table];
}

/// Event to update an existing table.
class TableUpdate extends TableEvent {
  final RestaurantTable table;

  const TableUpdate(this.table);

  @override
  List<Object?> get props => [table];
}

/// Event to update table status.
class TableUpdateStatus extends TableEvent {
  final int tableId;
  final TableStatus status;

  const TableUpdateStatus({required this.tableId, required this.status});

  @override
  List<Object?> get props => [tableId, status];
}

/// Event to delete a table.
class TableDelete extends TableEvent {
  final int tableId;

  const TableDelete(this.tableId);

  @override
  List<Object?> get props => [tableId];
}
