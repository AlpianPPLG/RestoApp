// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'menu.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Menu {

 int get id;@JsonKey(name: 'category_id') int get categoryId; String get name; String? get description;@PriceConverter() double get price;@JsonKey(name: 'image_url') String? get imageUrl;@JsonKey(name: 'is_active', fromJson: _boolFromJson) bool get isActive;@JsonKey(name: 'created_at') DateTime? get createdAt;@JsonKey(name: 'category_name') String? get categoryName;@JsonKey(name: 'daily_stock') int? get dailyStock;@JsonKey(name: 'remaining_stock') int? get remainingStock;
/// Create a copy of Menu
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MenuCopyWith<Menu> get copyWith => _$MenuCopyWithImpl<Menu>(this as Menu, _$identity);

  /// Serializes this Menu to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Menu&&(identical(other.id, id) || other.id == id)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.price, price) || other.price == price)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.dailyStock, dailyStock) || other.dailyStock == dailyStock)&&(identical(other.remainingStock, remainingStock) || other.remainingStock == remainingStock));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,categoryId,name,description,price,imageUrl,isActive,createdAt,categoryName,dailyStock,remainingStock);

@override
String toString() {
  return 'Menu(id: $id, categoryId: $categoryId, name: $name, description: $description, price: $price, imageUrl: $imageUrl, isActive: $isActive, createdAt: $createdAt, categoryName: $categoryName, dailyStock: $dailyStock, remainingStock: $remainingStock)';
}


}

/// @nodoc
abstract mixin class $MenuCopyWith<$Res>  {
  factory $MenuCopyWith(Menu value, $Res Function(Menu) _then) = _$MenuCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'category_id') int categoryId, String name, String? description,@PriceConverter() double price,@JsonKey(name: 'image_url') String? imageUrl,@JsonKey(name: 'is_active', fromJson: _boolFromJson) bool isActive,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'category_name') String? categoryName,@JsonKey(name: 'daily_stock') int? dailyStock,@JsonKey(name: 'remaining_stock') int? remainingStock
});




}
/// @nodoc
class _$MenuCopyWithImpl<$Res>
    implements $MenuCopyWith<$Res> {
  _$MenuCopyWithImpl(this._self, this._then);

  final Menu _self;
  final $Res Function(Menu) _then;

/// Create a copy of Menu
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? categoryId = null,Object? name = null,Object? description = freezed,Object? price = null,Object? imageUrl = freezed,Object? isActive = null,Object? createdAt = freezed,Object? categoryName = freezed,Object? dailyStock = freezed,Object? remainingStock = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,categoryName: freezed == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String?,dailyStock: freezed == dailyStock ? _self.dailyStock : dailyStock // ignore: cast_nullable_to_non_nullable
as int?,remainingStock: freezed == remainingStock ? _self.remainingStock : remainingStock // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [Menu].
extension MenuPatterns on Menu {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Menu value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Menu() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Menu value)  $default,){
final _that = this;
switch (_that) {
case _Menu():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Menu value)?  $default,){
final _that = this;
switch (_that) {
case _Menu() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'category_id')  int categoryId,  String name,  String? description, @PriceConverter()  double price, @JsonKey(name: 'image_url')  String? imageUrl, @JsonKey(name: 'is_active', fromJson: _boolFromJson)  bool isActive, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'category_name')  String? categoryName, @JsonKey(name: 'daily_stock')  int? dailyStock, @JsonKey(name: 'remaining_stock')  int? remainingStock)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Menu() when $default != null:
return $default(_that.id,_that.categoryId,_that.name,_that.description,_that.price,_that.imageUrl,_that.isActive,_that.createdAt,_that.categoryName,_that.dailyStock,_that.remainingStock);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'category_id')  int categoryId,  String name,  String? description, @PriceConverter()  double price, @JsonKey(name: 'image_url')  String? imageUrl, @JsonKey(name: 'is_active', fromJson: _boolFromJson)  bool isActive, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'category_name')  String? categoryName, @JsonKey(name: 'daily_stock')  int? dailyStock, @JsonKey(name: 'remaining_stock')  int? remainingStock)  $default,) {final _that = this;
switch (_that) {
case _Menu():
return $default(_that.id,_that.categoryId,_that.name,_that.description,_that.price,_that.imageUrl,_that.isActive,_that.createdAt,_that.categoryName,_that.dailyStock,_that.remainingStock);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'category_id')  int categoryId,  String name,  String? description, @PriceConverter()  double price, @JsonKey(name: 'image_url')  String? imageUrl, @JsonKey(name: 'is_active', fromJson: _boolFromJson)  bool isActive, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'category_name')  String? categoryName, @JsonKey(name: 'daily_stock')  int? dailyStock, @JsonKey(name: 'remaining_stock')  int? remainingStock)?  $default,) {final _that = this;
switch (_that) {
case _Menu() when $default != null:
return $default(_that.id,_that.categoryId,_that.name,_that.description,_that.price,_that.imageUrl,_that.isActive,_that.createdAt,_that.categoryName,_that.dailyStock,_that.remainingStock);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Menu implements Menu {
  const _Menu({required this.id, @JsonKey(name: 'category_id') required this.categoryId, required this.name, this.description, @PriceConverter() required this.price, @JsonKey(name: 'image_url') this.imageUrl, @JsonKey(name: 'is_active', fromJson: _boolFromJson) this.isActive = true, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'category_name') this.categoryName, @JsonKey(name: 'daily_stock') this.dailyStock, @JsonKey(name: 'remaining_stock') this.remainingStock});
  factory _Menu.fromJson(Map<String, dynamic> json) => _$MenuFromJson(json);

@override final  int id;
@override@JsonKey(name: 'category_id') final  int categoryId;
@override final  String name;
@override final  String? description;
@override@PriceConverter() final  double price;
@override@JsonKey(name: 'image_url') final  String? imageUrl;
@override@JsonKey(name: 'is_active', fromJson: _boolFromJson) final  bool isActive;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;
@override@JsonKey(name: 'category_name') final  String? categoryName;
@override@JsonKey(name: 'daily_stock') final  int? dailyStock;
@override@JsonKey(name: 'remaining_stock') final  int? remainingStock;

/// Create a copy of Menu
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MenuCopyWith<_Menu> get copyWith => __$MenuCopyWithImpl<_Menu>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MenuToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Menu&&(identical(other.id, id) || other.id == id)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.price, price) || other.price == price)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.dailyStock, dailyStock) || other.dailyStock == dailyStock)&&(identical(other.remainingStock, remainingStock) || other.remainingStock == remainingStock));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,categoryId,name,description,price,imageUrl,isActive,createdAt,categoryName,dailyStock,remainingStock);

@override
String toString() {
  return 'Menu(id: $id, categoryId: $categoryId, name: $name, description: $description, price: $price, imageUrl: $imageUrl, isActive: $isActive, createdAt: $createdAt, categoryName: $categoryName, dailyStock: $dailyStock, remainingStock: $remainingStock)';
}


}

/// @nodoc
abstract mixin class _$MenuCopyWith<$Res> implements $MenuCopyWith<$Res> {
  factory _$MenuCopyWith(_Menu value, $Res Function(_Menu) _then) = __$MenuCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'category_id') int categoryId, String name, String? description,@PriceConverter() double price,@JsonKey(name: 'image_url') String? imageUrl,@JsonKey(name: 'is_active', fromJson: _boolFromJson) bool isActive,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'category_name') String? categoryName,@JsonKey(name: 'daily_stock') int? dailyStock,@JsonKey(name: 'remaining_stock') int? remainingStock
});




}
/// @nodoc
class __$MenuCopyWithImpl<$Res>
    implements _$MenuCopyWith<$Res> {
  __$MenuCopyWithImpl(this._self, this._then);

  final _Menu _self;
  final $Res Function(_Menu) _then;

/// Create a copy of Menu
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? categoryId = null,Object? name = null,Object? description = freezed,Object? price = null,Object? imageUrl = freezed,Object? isActive = null,Object? createdAt = freezed,Object? categoryName = freezed,Object? dailyStock = freezed,Object? remainingStock = freezed,}) {
  return _then(_Menu(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,categoryName: freezed == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String?,dailyStock: freezed == dailyStock ? _self.dailyStock : dailyStock // ignore: cast_nullable_to_non_nullable
as int?,remainingStock: freezed == remainingStock ? _self.remainingStock : remainingStock // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
