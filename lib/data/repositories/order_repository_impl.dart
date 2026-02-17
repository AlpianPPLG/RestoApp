import 'package:injectable/injectable.dart' hide Order;

import 'package:restoapp/core/error/exceptions.dart';
import 'package:restoapp/domain/entities/enums.dart';
import 'package:restoapp/domain/entities/order.dart';
import 'package:restoapp/domain/repositories/order_repository.dart';
import 'package:restoapp/data/datasources/remote/order_remote_datasource.dart';

/// Concrete implementation of [OrderRepository].
@Injectable(as: OrderRepository)
class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource _remoteDataSource;

  OrderRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<Order>> getOrders({OrderStatus? status}) async {
    try {
      final data = await _remoteDataSource.getOrders(status: status?.name);
      return data
          .map((e) => Order.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      if (e is AppException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<Order> getOrderById(int id) async {
    try {
      final data = await _remoteDataSource.getOrderById(id);
      return Order.fromJson(data);
    } catch (e) {
      if (e is AppException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<Order> createOrder(Order order) async {
    try {
      final data = await _remoteDataSource.createOrder(order.toJson());
      return Order.fromJson(data);
    } catch (e) {
      if (e is AppException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> updateOrderStatus(int id, OrderStatus status) async {
    try {
      await _remoteDataSource.updateOrderStatus(id, status.name);
    } catch (e) {
      if (e is AppException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> updateOrderItemStatus(int itemId, OrderItemStatus status) async {
    try {
      await _remoteDataSource.updateOrderItemStatus(itemId, status.name);
    } catch (e) {
      if (e is AppException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> cancelOrder(int id) async {
    await updateOrderStatus(id, OrderStatus.cancelled);
  }

  @override
  Future<List<Order>> getKitchenOrders() async {
    try {
      final pending = await _remoteDataSource.getOrders(
        status: OrderStatus.pending.name,
      );
      final processing = await _remoteDataSource.getOrders(
        status: OrderStatus.processing.name,
      );
      final combined = [...pending, ...processing];
      return combined
          .map((e) => Order.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      if (e is AppException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<Order>> getPendingPaymentOrders() async {
    return getOrders(status: OrderStatus.delivered);
  }

  @override
  Future<List<Order>> getOrdersByStatus(OrderStatus status) async {
    return getOrders(status: status);
  }

  @override
  Future<Order> getOrder(int orderId) async {
    return getOrderById(orderId);
  }

  @override
  Future<void> processPayment({
    required int orderId,
    required PaymentMethod paymentMethod,
    required double amountPaid,
    String? notes,
  }) async {
    try {
      await _remoteDataSource.processPayment(
        orderId: orderId,
        paymentMethod: paymentMethod.name,
        amountPaid: amountPaid,
        notes: notes,
      );

      // Update order status to completed after successful payment
      await updateOrderStatus(orderId, OrderStatus.completed);
    } catch (e) {
      if (e is AppException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<Order>> getTransactionHistory({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final data = await _remoteDataSource.getTransactionHistory(
        startDate: startDate?.toIso8601String(),
        endDate: endDate?.toIso8601String(),
      );
      return data
          .map((e) => Order.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      if (e is AppException) rethrow;
      throw ServerException(message: e.toString());
    }
  }
}
