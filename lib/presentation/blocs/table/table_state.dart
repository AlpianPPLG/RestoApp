part of 'table_bloc.dart';

/// Base class for all table states.
abstract class TableState extends Equatable {
  const TableState();

  @override
  List<Object?> get props => [];
}

/// Initial state before loading tables.
class TableInitial extends TableState {
  const TableInitial();
}

/// State when loading table data.
class TableLoading extends TableState {
  const TableLoading();
}

/// State when tables are loaded.
class TableLoaded extends TableState {
  final List<RestaurantTable> tables;
  final int availableCount;
  final int occupiedCount;
  final int reservedCount;

  const TableLoaded({
    required this.tables,
    required this.availableCount,
    required this.occupiedCount,
    required this.reservedCount,
  });

  int get totalCount => tables.length;

  @override
  List<Object?> get props => [
    tables,
    availableCount,
    occupiedCount,
    reservedCount,
  ];
}

/// State when a table operation succeeds.
class TableOperationSuccess extends TableState {
  final String message;

  const TableOperationSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

/// State when table loading fails.
class TableError extends TableState {
  final String message;

  const TableError(this.message);

  @override
  List<Object?> get props => [message];
}
