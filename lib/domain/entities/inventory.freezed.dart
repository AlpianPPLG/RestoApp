// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inventory.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Inventory {

 int get id;@JsonKey(name: 'menu_id') int get menuId;@JsonKey(name: 'daily_stock') int get dailyStock;@JsonKey(name: 'remaining_stock') int get remainingStock;@JsonKey(name: 'last_updated') DateTime? get lastUpdated;
/// Create a copy of Inventory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InventoryCopyWith<Inventory> get copyWith => _$InventoryCopyWithImpl<Inventory>(this as Inventory, _$identity);

  /// Serializes this Inventory to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Inventory&&(identical(other.id, id) || other.id == id)&&(identical(other.menuId, menuId) || other.menuId == menuId)&&(identical(other.dailyStock, dailyStock) || other.dailyStock == dailyStock)&&(identical(other.remainingStock, remainingStock) || other.remainingStock == remainingStock)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,menuId,dailyStock,remainingStock,lastUpdated);

@override
String toString() {
  return 'Inventory(id: $id, menuId: $menuId, dailyStock: $dailyStock, remainingStock: $remainingStock, lastUpdated: $lastUpdated)';
}


}

/// @nodoc
abstract mixin class $InventoryCopyWith<$Res>  {
  factory $InventoryCopyWith(Inventory value, $Res Function(Inventory) _then) = _$InventoryCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'menu_id') int menuId,@JsonKey(name: 'daily_stock') int dailyStock,@JsonKey(name: 'remaining_stock') int remainingStock,@JsonKey(name: 'last_updated') DateTime? lastUpdated
});




}
/// @nodoc
class _$InventoryCopyWithImpl<$Res>
    implements $InventoryCopyWith<$Res> {
  _$InventoryCopyWithImpl(this._self, this._then);

  final Inventory _self;
  final $Res Function(Inventory) _then;

/// Create a copy of Inventory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? menuId = null,Object? dailyStock = null,Object? remainingStock = null,Object? lastUpdated = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,menuId: null == menuId ? _self.menuId : menuId // ignore: cast_nullable_to_non_nullable
as int,dailyStock: null == dailyStock ? _self.dailyStock : dailyStock // ignore: cast_nullable_to_non_nullable
as int,remainingStock: null == remainingStock ? _self.remainingStock : remainingStock // ignore: cast_nullable_to_non_nullable
as int,lastUpdated: freezed == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Inventory].
extension InventoryPatterns on Inventory {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Inventory value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Inventory() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Inventory value)  $default,){
final _that = this;
switch (_that) {
case _Inventory():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Inventory value)?  $default,){
final _that = this;
switch (_that) {
case _Inventory() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'menu_id')  int menuId, @JsonKey(name: 'daily_stock')  int dailyStock, @JsonKey(name: 'remaining_stock')  int remainingStock, @JsonKey(name: 'last_updated')  DateTime? lastUpdated)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Inventory() when $default != null:
return $default(_that.id,_that.menuId,_that.dailyStock,_that.remainingStock,_that.lastUpdated);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'menu_id')  int menuId, @JsonKey(name: 'daily_stock')  int dailyStock, @JsonKey(name: 'remaining_stock')  int remainingStock, @JsonKey(name: 'last_updated')  DateTime? lastUpdated)  $default,) {final _that = this;
switch (_that) {
case _Inventory():
return $default(_that.id,_that.menuId,_that.dailyStock,_that.remainingStock,_that.lastUpdated);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'menu_id')  int menuId, @JsonKey(name: 'daily_stock')  int dailyStock, @JsonKey(name: 'remaining_stock')  int remainingStock, @JsonKey(name: 'last_updated')  DateTime? lastUpdated)?  $default,) {final _that = this;
switch (_that) {
case _Inventory() when $default != null:
return $default(_that.id,_that.menuId,_that.dailyStock,_that.remainingStock,_that.lastUpdated);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Inventory implements Inventory {
  const _Inventory({required this.id, @JsonKey(name: 'menu_id') required this.menuId, @JsonKey(name: 'daily_stock') this.dailyStock = 0, @JsonKey(name: 'remaining_stock') this.remainingStock = 0, @JsonKey(name: 'last_updated') this.lastUpdated});
  factory _Inventory.fromJson(Map<String, dynamic> json) => _$InventoryFromJson(json);

@override final  int id;
@override@JsonKey(name: 'menu_id') final  int menuId;
@override@JsonKey(name: 'daily_stock') final  int dailyStock;
@override@JsonKey(name: 'remaining_stock') final  int remainingStock;
@override@JsonKey(name: 'last_updated') final  DateTime? lastUpdated;

/// Create a copy of Inventory
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InventoryCopyWith<_Inventory> get copyWith => __$InventoryCopyWithImpl<_Inventory>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InventoryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Inventory&&(identical(other.id, id) || other.id == id)&&(identical(other.menuId, menuId) || other.menuId == menuId)&&(identical(other.dailyStock, dailyStock) || other.dailyStock == dailyStock)&&(identical(other.remainingStock, remainingStock) || other.remainingStock == remainingStock)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,menuId,dailyStock,remainingStock,lastUpdated);

@override
String toString() {
  return 'Inventory(id: $id, menuId: $menuId, dailyStock: $dailyStock, remainingStock: $remainingStock, lastUpdated: $lastUpdated)';
}


}

/// @nodoc
abstract mixin class _$InventoryCopyWith<$Res> implements $InventoryCopyWith<$Res> {
  factory _$InventoryCopyWith(_Inventory value, $Res Function(_Inventory) _then) = __$InventoryCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'menu_id') int menuId,@JsonKey(name: 'daily_stock') int dailyStock,@JsonKey(name: 'remaining_stock') int remainingStock,@JsonKey(name: 'last_updated') DateTime? lastUpdated
});




}
/// @nodoc
class __$InventoryCopyWithImpl<$Res>
    implements _$InventoryCopyWith<$Res> {
  __$InventoryCopyWithImpl(this._self, this._then);

  final _Inventory _self;
  final $Res Function(_Inventory) _then;

/// Create a copy of Inventory
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? menuId = null,Object? dailyStock = null,Object? remainingStock = null,Object? lastUpdated = freezed,}) {
  return _then(_Inventory(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,menuId: null == menuId ? _self.menuId : menuId // ignore: cast_nullable_to_non_nullable
as int,dailyStock: null == dailyStock ? _self.dailyStock : dailyStock // ignore: cast_nullable_to_non_nullable
as int,remainingStock: null == remainingStock ? _self.remainingStock : remainingStock // ignore: cast_nullable_to_non_nullable
as int,lastUpdated: freezed == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
