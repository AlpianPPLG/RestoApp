// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Inventory _$InventoryFromJson(Map<String, dynamic> json) => _Inventory(
  id: (json['id'] as num).toInt(),
  menuId: (json['menu_id'] as num).toInt(),
  dailyStock: (json['daily_stock'] as num?)?.toInt() ?? 0,
  remainingStock: (json['remaining_stock'] as num?)?.toInt() ?? 0,
  lastUpdated: json['last_updated'] == null
      ? null
      : DateTime.parse(json['last_updated'] as String),
);

Map<String, dynamic> _$InventoryToJson(_Inventory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'menu_id': instance.menuId,
      'daily_stock': instance.dailyStock,
      'remaining_stock': instance.remainingStock,
      'last_updated': instance.lastUpdated?.toIso8601String(),
    };
