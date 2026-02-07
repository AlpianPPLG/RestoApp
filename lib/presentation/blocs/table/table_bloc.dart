import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:restoapp/core/utils/logger/app_logger.dart';
import 'package:restoapp/domain/entities/restaurant_table.dart';
import 'package:restoapp/domain/entities/enums.dart';
import 'package:restoapp/domain/repositories/table_repository.dart';

part 'table_event.dart';
part 'table_state.dart';

/// BLoC for managing table data.
@injectable
class TableBloc extends Bloc<TableEvent, TableState> {
  final TableRepository _tableRepository;

  TableBloc(this._tableRepository) : super(const TableInitial()) {
    on<TableLoadAll>(_onLoadAll);
    on<TableCreate>(_onCreate);
    on<TableUpdate>(_onUpdate);
    on<TableUpdateStatus>(_onUpdateStatus);
    on<TableDelete>(_onDelete);

    AppLogger.info('TableBloc initialized', tag: 'TABLE');
  }

  List<RestaurantTable> _allTables = [];

  Future<void> _onLoadAll(TableLoadAll event, Emitter<TableState> emit) async {
    AppLogger.blocEvent('TableBloc', 'TableLoadAll');
    emit(const TableLoading());

    try {
      _allTables = await _tableRepository.getTables();

      emit(
        TableLoaded(
          tables: _allTables,
          availableCount: _allTables
              .where((t) => t.status == TableStatus.available)
              .length,
          occupiedCount: _allTables
              .where((t) => t.status == TableStatus.occupied)
              .length,
          reservedCount: _allTables
              .where((t) => t.status == TableStatus.reserved)
              .length,
        ),
      );

      AppLogger.info('Loaded ${_allTables.length} tables', tag: 'TABLE');
    } catch (e) {
      AppLogger.error('Failed to load tables', tag: 'TABLE', error: e);
      emit(TableError(e.toString()));
    }
  }

  Future<void> _onCreate(TableCreate event, Emitter<TableState> emit) async {
    AppLogger.blocEvent(
      'TableBloc',
      'TableCreate',
      data: {'tableNumber': event.table.tableNumber},
    );
    emit(const TableLoading());

    try {
      final newTable = await _tableRepository.createTable(event.table);
      _allTables = [..._allTables, newTable];

      emit(
        TableOperationSuccess(
          'Table "${newTable.tableNumber}" created successfully',
        ),
      );
      _emitLoaded(emit);

      AppLogger.info('Table created: ${newTable.tableNumber}', tag: 'TABLE');
    } catch (e) {
      AppLogger.error('Failed to create table', tag: 'TABLE', error: e);
      emit(TableError(e.toString()));
      _emitLoaded(emit);
    }
  }

  Future<void> _onUpdate(TableUpdate event, Emitter<TableState> emit) async {
    AppLogger.blocEvent(
      'TableBloc',
      'TableUpdate',
      data: {'id': event.table.id},
    );
    emit(const TableLoading());

    try {
      final updatedTable = await _tableRepository.updateTable(event.table);
      _allTables = _allTables
          .map((t) => t.id == updatedTable.id ? updatedTable : t)
          .toList();

      emit(
        TableOperationSuccess(
          'Table "${updatedTable.tableNumber}" updated successfully',
        ),
      );
      _emitLoaded(emit);

      AppLogger.info(
        'Table updated: ${updatedTable.tableNumber}',
        tag: 'TABLE',
      );
    } catch (e) {
      AppLogger.error('Failed to update table', tag: 'TABLE', error: e);
      emit(TableError(e.toString()));
      _emitLoaded(emit);
    }
  }

  Future<void> _onUpdateStatus(
    TableUpdateStatus event,
    Emitter<TableState> emit,
  ) async {
    AppLogger.blocEvent(
      'TableBloc',
      'TableUpdateStatus',
      data: {'id': event.tableId, 'status': event.status.name},
    );

    try {
      await _tableRepository.updateTableStatus(event.tableId, event.status);
      _allTables = _allTables.map((t) {
        if (t.id == event.tableId) {
          return t.copyWith(status: event.status);
        }
        return t;
      }).toList();

      emit(
        TableOperationSuccess(
          'Table status updated to ${event.status.displayName}',
        ),
      );
      _emitLoaded(emit);

      AppLogger.info(
        'Table status updated: ${event.tableId} -> ${event.status.name}',
        tag: 'TABLE',
      );
    } catch (e) {
      AppLogger.error('Failed to update table status', tag: 'TABLE', error: e);
      emit(TableError(e.toString()));
      _emitLoaded(emit);
    }
  }

  Future<void> _onDelete(TableDelete event, Emitter<TableState> emit) async {
    AppLogger.blocEvent(
      'TableBloc',
      'TableDelete',
      data: {'id': event.tableId},
    );
    emit(const TableLoading());

    try {
      await _tableRepository.deleteTable(event.tableId);
      final deletedTable = _allTables.firstWhere((t) => t.id == event.tableId);
      _allTables = _allTables.where((t) => t.id != event.tableId).toList();

      emit(
        TableOperationSuccess('Table "${deletedTable.tableNumber}" deleted'),
      );
      _emitLoaded(emit);

      AppLogger.info('Table deleted: ${event.tableId}', tag: 'TABLE');
    } catch (e) {
      AppLogger.error('Failed to delete table', tag: 'TABLE', error: e);
      emit(TableError(e.toString()));
      _emitLoaded(emit);
    }
  }

  void _emitLoaded(Emitter<TableState> emit) {
    emit(
      TableLoaded(
        tables: _allTables,
        availableCount: _allTables
            .where((t) => t.status == TableStatus.available)
            .length,
        occupiedCount: _allTables
            .where((t) => t.status == TableStatus.occupied)
            .length,
        reservedCount: _allTables
            .where((t) => t.status == TableStatus.reserved)
            .length,
      ),
    );
  }
}
