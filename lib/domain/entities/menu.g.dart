// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Menu _$MenuFromJson(Map<String, dynamic> json) => _Menu(
  id: (json['id'] as num).toInt(),
  categoryId: (json['category_id'] as num).toInt(),
  name: json['name'] as String,
  description: json['description'] as String?,
  price: const PriceConverter().fromJson(json['price']),
  imageUrl: json['image_url'] as String?,
  isActive: json['is_active'] == null ? true : _boolFromJson(json['is_active']),
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  categoryName: json['category_name'] as String?,
  dailyStock: (json['daily_stock'] as num?)?.toInt(),
  remainingStock: (json['remaining_stock'] as num?)?.toInt(),
);

Map<String, dynamic> _$MenuToJson(_Menu instance) => <String, dynamic>{
  'id': instance.id,
  'category_id': instance.categoryId,
  'name': instance.name,
  'description': instance.description,
  'price': const PriceConverter().toJson(instance.price),
  'image_url': instance.imageUrl,
  'is_active': instance.isActive,
  'created_at': instance.createdAt?.toIso8601String(),
  'category_name': instance.categoryName,
  'daily_stock': instance.dailyStock,
  'remaining_stock': instance.remainingStock,
};
