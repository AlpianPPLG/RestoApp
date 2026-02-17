import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:restoapp/core/error/exceptions.dart';
import 'package:restoapp/domain/entities/restaurant_table.dart';
import 'package:restoapp/domain/entities/enums.dart';
import 'package:restoapp/domain/repositories/table_repository.dart';

part 'waiter_table_event.dart';
part 'waiter_table_state.dart';

@injectable
class WaiterTableBloc extends Bloc<WaiterTableEvent, WaiterTableState> {
  final TableRepository tableRepository;
  Timer? _autoRefreshTimer;

  WaiterTableBloc({required this.tableRepository})
    : super(WaiterTableInitial()) {
    on<WaiterTableLoadAll>(_onLoadAll);
    on<WaiterTableRefresh>(_onRefresh);
    on<WaiterTableStartAutoRefresh>(_onStartAutoRefresh);
    on<WaiterTableStopAutoRefresh>(_onStopAutoRefresh);
    on<WaiterTableSelect>(_onSelectTable);
    on<WaiterTableClearSelection>(_onClearSelection);
  }

  Future<void> _onLoadAll(
    WaiterTableLoadAll event,
    Emitter<WaiterTableState> emit,
  ) async {
    emit(WaiterTableLoading());

    try {
      final tables = await tableRepository.getTables();
      emit(
        WaiterTableLoaded(
          tables: tables,
          selectedTable: null,
          lastUpdated: DateTime.now(),
        ),
      );
    } on ServerException catch (e) {
      emit(WaiterTableError(message: e.message));
    } catch (e) {
      emit(const WaiterTableError(message: 'Failed to load tables'));
    }
  }

  Future<void> _onRefresh(
    WaiterTableRefresh event,
    Emitter<WaiterTableState> emit,
  ) async {
    if (state is! WaiterTableLoaded) return;

    final currentState = state as WaiterTableLoaded;

    try {
      emit(currentState.copyWith(isRefreshing: true));

      final tables = await tableRepository.getTables();
      emit(
        currentState.copyWith(
          tables: tables,
          isRefreshing: false,
          lastUpdated: DateTime.now(),
          error: null,
        ),
      );
    } on ServerException catch (e) {
      emit(currentState.copyWith(isRefreshing: false, error: e.message));
    } catch (e) {
      emit(
        currentState.copyWith(
          isRefreshing: false,
          error: 'Failed to refresh tables',
        ),
      );
    }
  }

  void _onStartAutoRefresh(
    WaiterTableStartAutoRefresh event,
    Emitter<WaiterTableState> emit,
  ) {
    _stopAutoRefresh();

    _autoRefreshTimer = Timer.periodic(
      const Duration(seconds: 10), // Auto refresh every 10 seconds
      (timer) {
        if (!isClosed) {
          add(WaiterTableRefresh());
        }
      },
    );
  }

  void _onStopAutoRefresh(
    WaiterTableStopAutoRefresh event,
    Emitter<WaiterTableState> emit,
  ) {
    _stopAutoRefresh();
  }

  void _onSelectTable(WaiterTableSelect event, Emitter<WaiterTableState> emit) {
    if (state is WaiterTableLoaded) {
      final currentState = state as WaiterTableLoaded;
      emit(currentState.copyWith(selectedTable: event.table));
    }
  }

  void _onClearSelection(
    WaiterTableClearSelection event,
    Emitter<WaiterTableState> emit,
  ) {
    if (state is WaiterTableLoaded) {
      final currentState = state as WaiterTableLoaded;
      emit(currentState.copyWith(selectedTable: null));
    }
  }

  void _stopAutoRefresh() {
    _autoRefreshTimer?.cancel();
    _autoRefreshTimer = null;
  }

  @override
  Future<void> close() {
    _stopAutoRefresh();
    return super.close();
  }
}
