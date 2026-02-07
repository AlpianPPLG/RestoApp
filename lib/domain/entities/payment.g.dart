// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Payment _$PaymentFromJson(Map<String, dynamic> json) => _Payment(
  id: (json['id'] as num).toInt(),
  orderId: (json['order_id'] as num).toInt(),
  cashierId: (json['cashier_id'] as num).toInt(),
  paymentMethod:
      $enumDecodeNullable(_$PaymentMethodEnumMap, json['payment_method']) ??
      PaymentMethod.cash,
  amountPaid: const PaymentAmountConverter().fromJson(json['amount_paid']),
  changeAmount: const PaymentAmountConverter().fromJson(json['change_amount']),
  transactionDate: json['transaction_date'] == null
      ? null
      : DateTime.parse(json['transaction_date'] as String),
  cashierName: json['cashier_name'] as String?,
);

Map<String, dynamic> _$PaymentToJson(_Payment instance) => <String, dynamic>{
  'id': instance.id,
  'order_id': instance.orderId,
  'cashier_id': instance.cashierId,
  'payment_method': _$PaymentMethodEnumMap[instance.paymentMethod]!,
  'amount_paid': const PaymentAmountConverter().toJson(instance.amountPaid),
  'change_amount': const PaymentAmountConverter().toJson(instance.changeAmount),
  'transaction_date': instance.transactionDate?.toIso8601String(),
  'cashier_name': instance.cashierName,
};

const _$PaymentMethodEnumMap = {
  PaymentMethod.cash: 'cash',
  PaymentMethod.qris: 'qris',
  PaymentMethod.debit: 'debit',
};
