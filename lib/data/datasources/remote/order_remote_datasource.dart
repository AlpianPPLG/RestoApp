import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:restoapp/core/constants/api_endpoints.dart';

/// Remote data source for orders.
@injectable
class OrderRemoteDataSource {
  final Dio _dio;

  OrderRemoteDataSource(this._dio);

  Future<List<dynamic>> getOrders({String? status}) async {
    final queryParams = <String, dynamic>{};
    if (status != null) {
      queryParams['status'] = status;
    }
    final response = await _dio.get(
      ApiEndpoints.orders,
      queryParameters: queryParams,
    );
    return response.data['data'] as List<dynamic>;
  }

  Future<Map<String, dynamic>> getOrderById(int id) async {
    final response = await _dio.get(ApiEndpoints.orderById(id));
    return response.data['data'] as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> createOrder(Map<String, dynamic> data) async {
    final response = await _dio.post(ApiEndpoints.orders, data: data);
    return response.data['data'] as Map<String, dynamic>;
  }

  Future<void> updateOrderStatus(int id, String status) async {
    await _dio.patch(ApiEndpoints.orderStatus(id), data: {'status': status});
  }

  Future<void> updateOrderItemStatus(int itemId, String status) async {
    await _dio.patch(
      ApiEndpoints.orderItemStatus(itemId),
      data: {'status': status},
    );
  }

  Future<void> processPayment({
    required int orderId,
    required String paymentMethod,
    required double amountPaid,
    String? notes,
  }) async {
    await _dio.post(
      ApiEndpoints.processPayment(orderId),
      data: {
        'payment_method': paymentMethod,
        'amount_paid': amountPaid,
        'notes': notes,
      },
    );
  }

  Future<List<dynamic>> getTransactionHistory({
    String? startDate,
    String? endDate,
  }) async {
    final queryParams = <String, dynamic>{};
    if (startDate != null) {
      queryParams['start_date'] = startDate;
    }
    if (endDate != null) {
      queryParams['end_date'] = endDate;
    }
    final response = await _dio.get(
      ApiEndpoints.transactionHistory,
      queryParameters: queryParams,
    );
    return response.data['data'] as List<dynamic>;
  }
}
