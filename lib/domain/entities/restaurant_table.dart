import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:restoapp/domain/entities/enums.dart';

part 'restaurant_table.freezed.dart';
part 'restaurant_table.g.dart';

/// Restaurant table entity.
@freezed
abstract class RestaurantTable with _$RestaurantTable {
  const factory RestaurantTable({
    required int id,
    @JsonKey(name: 'table_number') required String tableNumber,
    required int capacity,
    @Default(TableStatus.available) TableStatus status,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'current_order_id') int? currentOrderId,
    @JsonKey(name: 'order_status') String? orderStatus,
    @JsonKey(name: 'order_created_at') DateTime? orderCreatedAt,
    @Default(0) int warning,
  }) = _RestaurantTable;

  factory RestaurantTable.fromJson(Map<String, dynamic> json) =>
      _$RestaurantTableFromJson(json);
}
