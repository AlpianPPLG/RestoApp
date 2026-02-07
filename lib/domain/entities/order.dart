import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:restoapp/domain/entities/enums.dart';
import 'package:restoapp/domain/entities/order_item.dart';

part 'order.freezed.dart';
part 'order.g.dart';

/// Custom converter for totalAmount that handles both String and num
class AmountConverter implements JsonConverter<double, dynamic> {
  const AmountConverter();

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

/// Order entity (transaction header).
@freezed
abstract class Order with _$Order {
  const factory Order({
    required int id,
    @JsonKey(name: 'table_id') int? tableId,
    @JsonKey(name: 'user_id') required int userId,
    @JsonKey(name: 'customer_name') String? customerName,
    @JsonKey(name: 'order_type') @Default(OrderType.dineIn) OrderType orderType,
    @Default(OrderStatus.pending) OrderStatus status,
    @JsonKey(name: 'total_amount')
    @AmountConverter()
    @Default(0)
    double totalAmount,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    // Joined fields
    @Default([]) List<OrderItem> items,
    @JsonKey(name: 'table_number') String? tableNumber,
    @JsonKey(name: 'waiter_name') String? waiterName,
  }) = _Order;

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
}
