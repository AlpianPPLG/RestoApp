import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart' hide Order;
import 'package:restoapp/core/error/exceptions.dart';
import 'package:restoapp/domain/entities/enums.dart';
import 'package:restoapp/domain/entities/order.dart';
import 'package:restoapp/domain/repositories/order_repository.dart';

part 'kitchen_event.dart';
part 'kitchen_state.dart';

@injectable
class KitchenBloc extends Bloc<KitchenEvent, KitchenState> {
  final OrderRepository orderRepository;
  Timer? _autoRefreshTimer;

  KitchenBloc({required this.orderRepository}) : super(KitchenInitial()) {
    on<KitchenLoadOrders>(_onLoadOrders);
    on<KitchenRefresh>(_onRefresh);
    on<KitchenStartAutoRefresh>(_onStartAutoRefresh);
    on<KitchenStopAutoRefresh>(_onStopAutoRefresh);
    on<KitchenUpdateItemStatus>(_onUpdateItemStatus);
    on<KitchenUpdateOrderStatus>(_onUpdateOrderStatus);
  }

  Future<void> _onLoadOrders(
    KitchenLoadOrders event,
    Emitter<KitchenState> emit,
  ) async {
    emit(KitchenLoading());

    try {
      final orders = await orderRepository.getKitchenOrders();
      emit(KitchenLoaded(orders: orders, lastUpdated: DateTime.now()));
    } on ServerException catch (e) {
      emit(KitchenError(message: e.message));
    } catch (e) {
      emit(const KitchenError(message: 'Failed to load kitchen orders'));
    }
  }

  Future<void> _onRefresh(
    KitchenRefresh event,
    Emitter<KitchenState> emit,
  ) async {
    if (state is! KitchenLoaded) return;

    final currentState = state as KitchenLoaded;

    try {
      emit(currentState.copyWith(isRefreshing: true));

      final orders = await orderRepository.getKitchenOrders();

      // Check for new orders for sound alert
      final newOrderIds = orders
          .where(
            (order) =>
                !currentState.orders.any((existing) => existing.id == order.id),
          )
          .map((order) => order.id)
          .toList();

      emit(
        currentState.copyWith(
          orders: orders,
          isRefreshing: false,
          lastUpdated: DateTime.now(),
          error: null,
          newOrderIds: newOrderIds.isNotEmpty ? newOrderIds : null,
        ),
      );
    } on ServerException catch (e) {
      emit(currentState.copyWith(isRefreshing: false, error: e.message));
    } catch (e) {
      emit(
        currentState.copyWith(
          isRefreshing: false,
          error: 'Failed to refresh orders',
        ),
      );
    }
  }

  void _onStartAutoRefresh(
    KitchenStartAutoRefresh event,
    Emitter<KitchenState> emit,
  ) {
    _stopAutoRefresh();

    _autoRefreshTimer = Timer.periodic(
      const Duration(seconds: 5), // Auto refresh every 5 seconds for kitchen
      (timer) {
        if (!isClosed) {
          add(KitchenRefresh());
        }
      },
    );
  }

  void _onStopAutoRefresh(
    KitchenStopAutoRefresh event,
    Emitter<KitchenState> emit,
  ) {
    _stopAutoRefresh();
  }

  Future<void> _onUpdateItemStatus(
    KitchenUpdateItemStatus event,
    Emitter<KitchenState> emit,
  ) async {
    if (state is! KitchenLoaded) return;

    final currentState = state as KitchenLoaded;

    try {
      // Update item status on server
      await orderRepository.updateOrderItemStatus(event.itemId, event.status);

      // Update local state optimistically
      final updatedOrders = currentState.orders.map((order) {
        final updatedItems = order.items.map((item) {
          if (item.id == event.itemId) {
            return item.copyWith(status: event.status);
          }
          return item;
        }).toList();

        // ignore: unnecessary_null_comparison
        if (updatedItems != null) {
          // Check if all items are served to update order status
          final allServed = updatedItems.every(
            (item) => item.status == OrderItemStatus.served,
          );

          return order.copyWith(
            items: updatedItems,
            status: allServed ? OrderStatus.delivered : order.status,
          );
        }

        return order;
      }).toList();

      emit(
        currentState.copyWith(
          orders: updatedOrders,
          lastUpdated: DateTime.now(),
          error: null,
        ),
      );
    } on ServerException catch (e) {
      emit(currentState.copyWith(error: e.message));
    } catch (e) {
      emit(currentState.copyWith(error: 'Failed to update item status'));
    }
  }

  Future<void> _onUpdateOrderStatus(
    KitchenUpdateOrderStatus event,
    Emitter<KitchenState> emit,
  ) async {
    if (state is! KitchenLoaded) return;

    final currentState = state as KitchenLoaded;

    try {
      // Update order status
      await orderRepository.updateOrderStatus(event.orderId, event.status);

      // Reload orders to get fresh data
      final orders = await orderRepository.getKitchenOrders();
      emit(
        currentState.copyWith(
          orders: orders,
          lastUpdated: DateTime.now(),
          error: null,
        ),
      );
    } on ServerException catch (e) {
      emit(currentState.copyWith(error: e.message));
    } catch (e) {
      emit(currentState.copyWith(error: 'Failed to update order status'));
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
