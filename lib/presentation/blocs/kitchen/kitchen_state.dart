part of 'kitchen_bloc.dart';

abstract class KitchenState extends Equatable {
  const KitchenState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class KitchenInitial extends KitchenState {}

/// Loading orders
class KitchenLoading extends KitchenState {}

/// Orders loaded successfully
class KitchenLoaded extends KitchenState {
  final List<Order> orders;
  final DateTime lastUpdated;
  final bool isRefreshing;
  final String? error;
  final List<int>? newOrderIds; // For sound alerts

  const KitchenLoaded({
    required this.orders,
    required this.lastUpdated,
    this.isRefreshing = false,
    this.error,
    this.newOrderIds,
  });

  KitchenLoaded copyWith({
    List<Order>? orders,
    DateTime? lastUpdated,
    bool? isRefreshing,
    String? error,
    List<int>? newOrderIds,
  }) {
    return KitchenLoaded(
      orders: orders ?? this.orders,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      error: error,
      newOrderIds: newOrderIds,
    );
  }

  // Helper getters for statistics
  int get pendingOrders =>
      orders.where((order) => order.status == OrderStatus.pending).length;

  int get cookingOrders =>
      orders.where((order) => order.status == OrderStatus.processing).length;

  int get readyOrders =>
      orders.where((order) => order.status == OrderStatus.delivered).length;

  // Get orders that have been waiting too long (>20 minutes)
  List<Order> get lateOrders {
    final now = DateTime.now();
    return orders.where((order) {
      if (order.createdAt != null) {
        final waitTime = now.difference(order.createdAt!);
        return waitTime.inMinutes > 20;
      }
      return false;
    }).toList();
  }

  @override
  List<Object?> get props => [
    orders,
    lastUpdated,
    isRefreshing,
    error,
    newOrderIds,
  ];
}

/// Error loading orders
class KitchenError extends KitchenState {
  final String message;

  const KitchenError({required this.message});

  @override
  List<Object?> get props => [message];
}
