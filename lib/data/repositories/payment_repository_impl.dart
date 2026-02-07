import 'package:injectable/injectable.dart';

import 'package:restoapp/core/error/exceptions.dart';
import 'package:restoapp/domain/entities/enums.dart';
import 'package:restoapp/domain/entities/payment.dart';
import 'package:restoapp/domain/repositories/payment_repository.dart';
import 'package:restoapp/data/datasources/remote/payment_remote_datasource.dart';

/// Concrete implementation of [PaymentRepository].
@Injectable(as: PaymentRepository)
class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentRemoteDataSource _remoteDataSource;

  PaymentRepositoryImpl(this._remoteDataSource);

  @override
  Future<Payment> processPayment({
    required int orderId,
    required int cashierId,
    required PaymentMethod method,
    required double amountPaid,
    required double changeAmount,
  }) async {
    try {
      final data = await _remoteDataSource.processPayment({
        'order_id': orderId,
        'cashier_id': cashierId,
        'payment_method': method.name,
        'amount_paid': amountPaid,
        'change_amount': changeAmount,
      });
      return Payment.fromJson(data);
    } catch (e) {
      if (e is AppException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<Payment?> getPaymentByOrderId(int orderId) async {
    try {
      final data = await _remoteDataSource.getPaymentByOrderId(orderId);
      if (data == null) return null;
      return Payment.fromJson(data);
    } catch (e) {
      if (e is AppException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<Payment>> getPayments() async {
    try {
      final data = await _remoteDataSource.getPayments();
      return data
          .map((e) => Payment.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      if (e is AppException) rethrow;
      throw ServerException(message: e.toString());
    }
  }
}
