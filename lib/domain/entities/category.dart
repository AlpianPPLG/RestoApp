import 'package:freezed_annotation/freezed_annotation.dart';

part 'category.freezed.dart';
part 'category.g.dart';

/// Menu category entity.
@freezed
abstract class Category with _$Category {
  const factory Category({
    required int id,
    required String name,
    String? icon,
    @JsonKey(name: 'sort_order') @Default(0) int sortOrder,
  }) = _Category;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
}
