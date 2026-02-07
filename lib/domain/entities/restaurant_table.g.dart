// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_table.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RestaurantTable _$RestaurantTableFromJson(Map<String, dynamic> json) =>
    _RestaurantTable(
      id: (json['id'] as num).toInt(),
      tableNumber: json['table_number'] as String,
      capacity: (json['capacity'] as num).toInt(),
      status:
          $enumDecodeNullable(_$TableStatusEnumMap, json['status']) ??
          TableStatus.available,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      currentOrderId: (json['current_order_id'] as num?)?.toInt(),
      orderStatus: json['order_status'] as String?,
      orderCreatedAt: json['order_created_at'] == null
          ? null
          : DateTime.parse(json['order_created_at'] as String),
      warning: (json['warning'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$RestaurantTableToJson(_RestaurantTable instance) =>
    <String, dynamic>{
      'id': instance.id,
      'table_number': instance.tableNumber,
      'capacity': instance.capacity,
      'status': _$TableStatusEnumMap[instance.status]!,
      'created_at': instance.createdAt?.toIso8601String(),
      'current_order_id': instance.currentOrderId,
      'order_status': instance.orderStatus,
      'order_created_at': instance.orderCreatedAt?.toIso8601String(),
      'warning': instance.warning,
    };

const _$TableStatusEnumMap = {
  TableStatus.available: 'available',
  TableStatus.reserved: 'reserved',
  TableStatus.occupied: 'occupied',
};
