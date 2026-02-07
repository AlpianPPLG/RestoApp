import 'package:restoapp/domain/entities/restaurant_table.dart';
import 'package:restoapp/domain/entities/enums.dart';

/// Table repository interface.
abstract class TableRepository {
  /// Get all tables.
  Future<List<RestaurantTable>> getTables();

  /// Get a single table by ID.
  Future<RestaurantTable> getTableById(int id);

  /// Create a new table.
  Future<RestaurantTable> createTable(RestaurantTable table);

  /// Update an existing table.
  Future<RestaurantTable> updateTable(RestaurantTable table);

  /// Update table status.
  Future<void> updateTableStatus(int id, TableStatus status);

  /// Delete a table.
  Future<void> deleteTable(int id);
}
