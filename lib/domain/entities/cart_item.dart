import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_item.freezed.dart';
part 'cart_item.g.dart';

/// Cart item entity (local-only, not persisted to backend).
@freezed
abstract class CartItem with _$CartItem {
  const factory CartItem({
    required int menuId,
    required String menuName,
    required double price,
    @Default(1) int quantity,
    String? specialNotes,
    String? imageUrl,
  }) = _CartItem;

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);
}
