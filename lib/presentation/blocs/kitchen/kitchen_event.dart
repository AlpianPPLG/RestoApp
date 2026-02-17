part of 'kitchen_bloc.dart';

abstract class KitchenEvent extends Equatable {
  const KitchenEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load kitchen orders
class KitchenLoadOrders extends KitchenEvent {
  const KitchenLoadOrders();
}

/// Event to refresh kitchen orders
class KitchenRefresh extends KitchenEvent {
  const KitchenRefresh();
}

/// Event to start auto refresh timer
class KitchenStartAutoRefresh extends KitchenEvent {
  const KitchenStartAutoRefresh();
}

/// Event to stop auto refresh timer
class KitchenStopAutoRefresh extends KitchenEvent {
  const KitchenStopAutoRefresh();
}

/// Event to update order item status
class KitchenUpdateItemStatus extends KitchenEvent {
  final int itemId;
  final OrderItemStatus status;

  const KitchenUpdateItemStatus({required this.itemId, required this.status});

  @override
  List<Object?> get props => [itemId, status];
}

/// Event to update order status
class KitchenUpdateOrderStatus extends KitchenEvent {
  final int orderId;
  final OrderStatus status;

  const KitchenUpdateOrderStatus({required this.orderId, required this.status});

  @override
  List<Object?> get props => [orderId, status];
}
