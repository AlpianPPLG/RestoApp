part of 'waiter_table_bloc.dart';

abstract class WaiterTableState extends Equatable {
  const WaiterTableState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class WaiterTableInitial extends WaiterTableState {}

/// Loading tables
class WaiterTableLoading extends WaiterTableState {}

/// Tables loaded successfully
class WaiterTableLoaded extends WaiterTableState {
  final List<RestaurantTable> tables;
  final RestaurantTable? selectedTable;
  final DateTime lastUpdated;
  final bool isRefreshing;
  final String? error;

  const WaiterTableLoaded({
    required this.tables,
    this.selectedTable,
    required this.lastUpdated,
    this.isRefreshing = false,
    this.error,
  });

  WaiterTableLoaded copyWith({
    List<RestaurantTable>? tables,
    RestaurantTable? selectedTable,
    DateTime? lastUpdated,
    bool? isRefreshing,
    String? error,
  }) {
    return WaiterTableLoaded(
      tables: tables ?? this.tables,
      selectedTable: selectedTable ?? this.selectedTable,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      error: error,
    );
  }

  // Helper getters for statistics
  int get availableTables =>
      tables.where((table) => table.status == TableStatus.available).length;

  int get occupiedTables =>
      tables.where((table) => table.status == TableStatus.occupied).length;

  int get reservedTables =>
      tables.where((table) => table.status == TableStatus.reserved).length;

  @override
  List<Object?> get props => [
    tables,
    selectedTable,
    lastUpdated,
    isRefreshing,
    error,
  ];
}

/// Error loading tables
class WaiterTableError extends WaiterTableState {
  final String message;

  const WaiterTableError({required this.message});

  @override
  List<Object?> get props => [message];
}
