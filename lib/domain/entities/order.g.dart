// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Order _$OrderFromJson(Map<String, dynamic> json) => _Order(
  id: (json['id'] as num).toInt(),
  tableId: (json['table_id'] as num?)?.toInt(),
  userId: (json['user_id'] as num).toInt(),
  customerName: json['customer_name'] as String?,
  orderType:
      $enumDecodeNullable(_$OrderTypeEnumMap, json['order_type']) ??
      OrderType.dineIn,
  status:
      $enumDecodeNullable(_$OrderStatusEnumMap, json['status']) ??
      OrderStatus.pending,
  totalAmount: json['total_amount'] == null
      ? 0
      : const AmountConverter().fromJson(json['total_amount']),
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  tableNumber: json['table_number'] as String?,
  waiterName: json['waiter_name'] as String?,
);

Map<String, dynamic> _$OrderToJson(_Order instance) => <String, dynamic>{
  'id': instance.id,
  'table_id': instance.tableId,
  'user_id': instance.userId,
  'customer_name': instance.customerName,
  'order_type': _$OrderTypeEnumMap[instance.orderType]!,
  'status': _$OrderStatusEnumMap[instance.status]!,
  'total_amount': const AmountConverter().toJson(instance.totalAmount),
  'created_at': instance.createdAt?.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
  'items': instance.items,
  'table_number': instance.tableNumber,
  'waiter_name': instance.waiterName,
};

const _$OrderTypeEnumMap = {
  OrderType.dineIn: 'dine_in',
  OrderType.takeAway: 'take_away',
};

const _$OrderStatusEnumMap = {
  OrderStatus.pending: 'pending',
  OrderStatus.processing: 'processing',
  OrderStatus.delivered: 'delivered',
  OrderStatus.completed: 'completed',
  OrderStatus.cancelled: 'cancelled',
};
