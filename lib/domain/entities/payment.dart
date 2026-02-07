import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:restoapp/domain/entities/enums.dart';

part 'payment.freezed.dart';
part 'payment.g.dart';

/// Custom converter for payment amounts that handles both String and num
class PaymentAmountConverter implements JsonConverter<double, dynamic> {
  const PaymentAmountConverter();

  @override
  double fromJson(dynamic json) {
    if (json is String) {
      return double.tryParse(json) ?? 0.0;
    } else if (json is num) {
      return json.toDouble();
    }
    return 0.0;
  }

  @override
  dynamic toJson(double object) => object;
}

/// Payment entity.
@freezed
abstract class Payment with _$Payment {
  const factory Payment({
    required int id,
    @JsonKey(name: 'order_id') required int orderId,
    @JsonKey(name: 'cashier_id') required int cashierId,
    @JsonKey(name: 'payment_method')
    @Default(PaymentMethod.cash)
    PaymentMethod paymentMethod,
    @JsonKey(name: 'amount_paid')
    @PaymentAmountConverter()
    required double amountPaid,
    @JsonKey(name: 'change_amount')
    @PaymentAmountConverter()
    required double changeAmount,
    @JsonKey(name: 'transaction_date') DateTime? transactionDate,
    // Joined fields
    @JsonKey(name: 'cashier_name') String? cashierName,
  }) = _Payment;

  factory Payment.fromJson(Map<String, dynamic> json) =>
      _$PaymentFromJson(json);
}
