import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:restoapp/core/utils/logger/app_logger.dart';
import 'package:restoapp/domain/entities/menu.dart';
import 'package:restoapp/domain/entities/restaurant_table.dart';
import 'package:restoapp/domain/repositories/menu_repository.dart';
import 'package:restoapp/domain/repositories/table_repository.dart';
import 'package:restoapp/domain/repositories/order_repository.dart';

part 'admin_event.dart';
part 'admin_state.dart';

/// BLoC for managing admin dashboard state.
@injectable
class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final MenuRepository _menuRepository;
  final TableRepository _tableRepository;
  final OrderRepository _orderRepository;

  AdminBloc(this._menuRepository, this._tableRepository, this._orderRepository)
    : super(const AdminInitial()) {
    on<AdminLoadDashboard>(_onLoadDashboard);
    on<AdminRefreshDashboard>(_onRefreshDashboard);

    AppLogger.info('AdminBloc initialized', tag: 'ADMIN');
  }

  Future<void> _onLoadDashboard(
    AdminLoadDashboard event,
    Emitter<AdminState> emit,
  ) async {
    AppLogger.blocEvent('AdminBloc', 'AdminLoadDashboard');
    emit(const AdminLoading());

    try {
      // Fetch all data in parallel
      final results = await Future.wait([
        _menuRepository.getMenus(),
        _tableRepository.getTables(),
        _fetchTodayStats(),
      ]);

      final menus = results[0] as List<Menu>;
      final tables = results[1] as List<RestaurantTable>;
      final stats = results[2] as Map<String, dynamic>;

      emit(
        AdminLoaded(
          totalMenus: menus.length,
          activeMenus: menus.where((m) => m.isActive).length,
          totalTables: tables.length,
          availableTables: tables
              .where((t) => t.status.name == 'available')
              .length,
          todayOrders: stats['todayOrders'] as int,
          todayRevenue: stats['todayRevenue'] as double,
          pendingOrders: stats['pendingOrders'] as int,
        ),
      );

      AppLogger.info('Dashboard loaded successfully', tag: 'ADMIN');
    } catch (e) {
      AppLogger.error('Failed to load dashboard', tag: 'ADMIN', error: e);
      emit(AdminError(e.toString()));
    }
  }

  Future<void> _onRefreshDashboard(
    AdminRefreshDashboard event,
    Emitter<AdminState> emit,
  ) async {
    AppLogger.blocEvent('AdminBloc', 'AdminRefreshDashboard');
    // Just call load dashboard logic
    await _onLoadDashboard(const AdminLoadDashboard(), emit);
  }

  Future<Map<String, dynamic>> _fetchTodayStats() async {
    try {
      final orders = await _orderRepository.getOrders();
      final today = DateTime.now();
      final todayOrders = orders.where((o) {
        if (o.createdAt == null) return false;
        return o.createdAt!.year == today.year &&
            o.createdAt!.month == today.month &&
            o.createdAt!.day == today.day;
      }).toList();

      final pendingOrders = orders
          .where(
            (o) => o.status.name == 'pending' || o.status.name == 'processing',
          )
          .length;

      double todayRevenue = 0;
      for (final order in todayOrders) {
        if (order.status.name == 'completed') {
          todayRevenue += order.totalAmount;
        }
      }

      return {
        'todayOrders': todayOrders.length,
        'todayRevenue': todayRevenue,
        'pendingOrders': pendingOrders,
      };
    } catch (e) {
      AppLogger.warning('Failed to fetch order stats: $e', tag: 'ADMIN');
      return {'todayOrders': 0, 'todayRevenue': 0.0, 'pendingOrders': 0};
    }
  }
}
