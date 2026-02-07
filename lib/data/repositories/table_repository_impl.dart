import 'package:injectable/injectable.dart';

import 'package:restoapp/core/error/exceptions.dart';
import 'package:restoapp/domain/entities/enums.dart';
import 'package:restoapp/domain/entities/restaurant_table.dart';
import 'package:restoapp/domain/repositories/table_repository.dart';
import 'package:restoapp/data/datasources/remote/table_remote_datasource.dart';

/// Concrete implementation of [TableRepository].
@Injectable(as: TableRepository)
class TableRepositoryImpl implements TableRepository {
  final TableRemoteDataSource _remoteDataSource;

  TableRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<RestaurantTable>> getTables() async {
    try {
      final data = await _remoteDataSource.getTables();
      return data
          .map((e) => RestaurantTable.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      if (e is AppException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<RestaurantTable> getTableById(int id) async {
    try {
      final data = await _remoteDataSource.getTableById(id);
      return RestaurantTable.fromJson(data);
    } catch (e) {
      if (e is AppException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<RestaurantTable> createTable(RestaurantTable table) async {
    try {
      final data = await _remoteDataSource.createTable(table.toJson());
      return RestaurantTable.fromJson(data);
    } catch (e) {
      if (e is AppException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<RestaurantTable> updateTable(RestaurantTable table) async {
    try {
      final data = await _remoteDataSource.updateTable(
        table.id,
        table.toJson(),
      );
      return RestaurantTable.fromJson(data);
    } catch (e) {
      if (e is AppException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> updateTableStatus(int id, TableStatus status) async {
    try {
      await _remoteDataSource.updateTableStatus(id, status.name);
    } catch (e) {
      if (e is AppException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> deleteTable(int id) async {
    try {
      await _remoteDataSource.deleteTable(id);
    } catch (e) {
      if (e is AppException) rethrow;
      throw ServerException(message: e.toString());
    }
  }
}
