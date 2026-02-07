import 'package:restoapp/domain/entities/payment.dart';
import 'package:restoapp/domain/entities/enums.dart';

/// Payment repository interface.
abstract class PaymentRepository {
  /// Process a payment.
  Future<Payment> processPayment({
    required int orderId,
    required int cashierId,
    required PaymentMethod method,
    required double amountPaid,
    required double changeAmount,
  });

  /// Get payment by order ID.
  Future<Payment?> getPaymentByOrderId(int orderId);

  /// Get all payments (for reporting).
  Future<List<Payment>> getPayments();
}
