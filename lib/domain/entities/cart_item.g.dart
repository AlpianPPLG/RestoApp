// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CartItem _$CartItemFromJson(Map<String, dynamic> json) => _CartItem(
  menuId: (json['menuId'] as num).toInt(),
  menuName: json['menuName'] as String,
  price: (json['price'] as num).toDouble(),
  quantity: (json['quantity'] as num?)?.toInt() ?? 1,
  specialNotes: json['specialNotes'] as String?,
  imageUrl: json['imageUrl'] as String?,
);

Map<String, dynamic> _$CartItemToJson(_CartItem instance) => <String, dynamic>{
  'menuId': instance.menuId,
  'menuName': instance.menuName,
  'price': instance.price,
  'quantity': instance.quantity,
  'specialNotes': instance.specialNotes,
  'imageUrl': instance.imageUrl,
};
