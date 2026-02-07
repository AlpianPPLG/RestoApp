import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:restoapp/core/constants/api_endpoints.dart';

/// Remote data source for payments.
@injectable
class PaymentRemoteDataSource {
  final Dio _dio;

  PaymentRemoteDataSource(this._dio);

  Future<Map<String, dynamic>> processPayment(Map<String, dynamic> data) async {
    final response = await _dio.post(ApiEndpoints.payments, data: data);
    return response.data['data'] as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>?> getPaymentByOrderId(int orderId) async {
    final response = await _dio.get(
      ApiEndpoints.payments,
      queryParameters: {'order_id': orderId},
    );
    final data = response.data['data'];
    if (data is List && data.isNotEmpty) {
      return data.first as Map<String, dynamic>;
    }
    return data as Map<String, dynamic>?;
  }

  Future<List<dynamic>> getPayments() async {
    final response = await _dio.get(ApiEndpoints.payments);
    return response.data['data'] as List<dynamic>;
  }
}
