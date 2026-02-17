import 'package:restoapp/domain/entities/order.dart';
import 'package:restoapp/domain/entities/enums.dart';

/// Order repository interface.
abstract class OrderRepository {
  /// Get all orders, optionally filtered by status.
  Future<List<Order>> getOrders({OrderStatus? status});

  /// Get a single order by ID (with items).
  Future<Order> getOrderById(int id);

  /// Create a new order with items.
  Future<Order> createOrder(Order order);

  /// Update order status.
  Future<void> updateOrderStatus(int id, OrderStatus status);

  /// Update individual order item status.
  Future<void> updateOrderItemStatus(int itemId, OrderItemStatus status);

  /// Cancel an order.
  Future<void> cancelOrder(int id);

  /// Get orders for kitchen (pending/processing).
  Future<List<Order>> getKitchenOrders();

  /// Get orders ready for payment (delivered).
  Future<List<Order>> getPendingPaymentOrders();

  /// Get orders by specific status.
  Future<List<Order>> getOrdersByStatus(OrderStatus status);

  /// Get single order with full details.
  Future<Order> getOrder(int orderId);

  /// Process payment for an order.
  Future<void> processPayment({
    required int orderId,
    required PaymentMethod paymentMethod,
    required double amountPaid,
    String? notes,
  });

  /// Get transaction history within date range.
  Future<List<Order>> getTransactionHistory({
    DateTime? startDate,
    DateTime? endDate,
  });
}
