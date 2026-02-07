// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OrderItem _$OrderItemFromJson(Map<String, dynamic> json) => _OrderItem(
  id: (json['id'] as num).toInt(),
  orderId: (json['order_id'] as num).toInt(),
  menuId: (json['menu_id'] as num).toInt(),
  quantity: (json['quantity'] as num?)?.toInt() ?? 1,
  priceAtTime: const ItemPriceConverter().fromJson(json['price_at_time']),
  subtotal: const ItemPriceConverter().fromJson(json['subtotal']),
  specialNotes: json['special_notes'] as String?,
  status:
      $enumDecodeNullable(_$OrderItemStatusEnumMap, json['status']) ??
      OrderItemStatus.pending,
  menuName: json['menu_name'] as String?,
  menuImageUrl: json['menu_image_url'] as String?,
);

Map<String, dynamic> _$OrderItemToJson(_OrderItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order_id': instance.orderId,
      'menu_id': instance.menuId,
      'quantity': instance.quantity,
      'price_at_time': const ItemPriceConverter().toJson(instance.priceAtTime),
      'subtotal': _$JsonConverterToJson<dynamic, double>(
        instance.subtotal,
        const ItemPriceConverter().toJson,
      ),
      'special_notes': instance.specialNotes,
      'status': _$OrderItemStatusEnumMap[instance.status]!,
      'menu_name': instance.menuName,
      'menu_image_url': instance.menuImageUrl,
    };

const _$OrderItemStatusEnumMap = {
  OrderItemStatus.pending: 'pending',
  OrderItemStatus.cooking: 'cooking',
  OrderItemStatus.served: 'served',
};

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
