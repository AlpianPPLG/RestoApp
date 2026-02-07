import 'package:freezed_annotation/freezed_annotation.dart';

part 'menu.freezed.dart';
part 'menu.g.dart';

/// Custom converter for price that handles both String and num
class PriceConverter implements JsonConverter<double, dynamic> {
  const PriceConverter();

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

/// Menu item entity.
@freezed
abstract class Menu with _$Menu {
  const factory Menu({
    required int id,
    @JsonKey(name: 'category_id') required int categoryId,
    required String name,
    String? description,
    @PriceConverter() required double price,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'is_active', fromJson: _boolFromJson)
    @Default(true)
    bool isActive,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'category_name') String? categoryName,
    @JsonKey(name: 'daily_stock') int? dailyStock,
    @JsonKey(name: 'remaining_stock') int? remainingStock,
  }) = _Menu;

  factory Menu.fromJson(Map<String, dynamic> json) => _$MenuFromJson(json);
}

/// Helper to convert int (0/1) or bool to bool
bool _boolFromJson(dynamic value) {
  if (value is bool) return value;
  if (value is int) return value == 1;
  if (value is String) return value == '1' || value.toLowerCase() == 'true';
  return true;
}
