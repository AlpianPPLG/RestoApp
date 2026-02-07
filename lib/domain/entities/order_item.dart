import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:restoapp/domain/entities/enums.dart';

part 'order_item.freezed.dart';
part 'order_item.g.dart';

/// Custom converter for price that handles both String and num
class ItemPriceConverter implements JsonConverter<double, dynamic> {
  const ItemPriceConverter();

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

/// Order item entity (pesanan detail per item).
@freezed
abstract class OrderItem with _$OrderItem {
  const factory OrderItem({
    required int id,
    @JsonKey(name: 'order_id') required int orderId,
    @JsonKey(name: 'menu_id') required int menuId,
    @Default(1) int quantity,
    @JsonKey(name: 'price_at_time')
    @ItemPriceConverter()
    required double priceAtTime,
    @ItemPriceConverter() double? subtotal,
    @JsonKey(name: 'special_notes') String? specialNotes,
    @Default(OrderItemStatus.pending) OrderItemStatus status,
    // Joined fields (from menu)
    @JsonKey(name: 'menu_name') String? menuName,
    @JsonKey(name: 'menu_image_url') String? menuImageUrl,
  }) = _OrderItem;

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);
}
