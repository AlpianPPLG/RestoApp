import 'package:freezed_annotation/freezed_annotation.dart';

part 'inventory.freezed.dart';
part 'inventory.g.dart';

/// Inventory entity for daily menu stock.
@freezed
abstract class Inventory with _$Inventory {
  const factory Inventory({
    required int id,
    @JsonKey(name: 'menu_id') required int menuId,
    @JsonKey(name: 'daily_stock') @Default(0) int dailyStock,
    @JsonKey(name: 'remaining_stock') @Default(0) int remainingStock,
    @JsonKey(name: 'last_updated') DateTime? lastUpdated,
  }) = _Inventory;

  factory Inventory.fromJson(Map<String, dynamic> json) =>
      _$InventoryFromJson(json);
}
