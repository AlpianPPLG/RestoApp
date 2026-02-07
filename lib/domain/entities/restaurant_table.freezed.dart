// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'restaurant_table.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RestaurantTable {

 int get id;@JsonKey(name: 'table_number') String get tableNumber; int get capacity; TableStatus get status;@JsonKey(name: 'created_at') DateTime? get createdAt;@JsonKey(name: 'current_order_id') int? get currentOrderId;@JsonKey(name: 'order_status') String? get orderStatus;@JsonKey(name: 'order_created_at') DateTime? get orderCreatedAt; int get warning;
/// Create a copy of RestaurantTable
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RestaurantTableCopyWith<RestaurantTable> get copyWith => _$RestaurantTableCopyWithImpl<RestaurantTable>(this as RestaurantTable, _$identity);

  /// Serializes this RestaurantTable to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RestaurantTable&&(identical(other.id, id) || other.id == id)&&(identical(other.tableNumber, tableNumber) || other.tableNumber == tableNumber)&&(identical(other.capacity, capacity) || other.capacity == capacity)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.currentOrderId, currentOrderId) || other.currentOrderId == currentOrderId)&&(identical(other.orderStatus, orderStatus) || other.orderStatus == orderStatus)&&(identical(other.orderCreatedAt, orderCreatedAt) || other.orderCreatedAt == orderCreatedAt)&&(identical(other.warning, warning) || other.warning == warning));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,tableNumber,capacity,status,createdAt,currentOrderId,orderStatus,orderCreatedAt,warning);

@override
String toString() {
  return 'RestaurantTable(id: $id, tableNumber: $tableNumber, capacity: $capacity, status: $status, createdAt: $createdAt, currentOrderId: $currentOrderId, orderStatus: $orderStatus, orderCreatedAt: $orderCreatedAt, warning: $warning)';
}


}

/// @nodoc
abstract mixin class $RestaurantTableCopyWith<$Res>  {
  factory $RestaurantTableCopyWith(RestaurantTable value, $Res Function(RestaurantTable) _then) = _$RestaurantTableCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'table_number') String tableNumber, int capacity, TableStatus status,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'current_order_id') int? currentOrderId,@JsonKey(name: 'order_status') String? orderStatus,@JsonKey(name: 'order_created_at') DateTime? orderCreatedAt, int warning
});




}
/// @nodoc
class _$RestaurantTableCopyWithImpl<$Res>
    implements $RestaurantTableCopyWith<$Res> {
  _$RestaurantTableCopyWithImpl(this._self, this._then);

  final RestaurantTable _self;
  final $Res Function(RestaurantTable) _then;

/// Create a copy of RestaurantTable
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? tableNumber = null,Object? capacity = null,Object? status = null,Object? createdAt = freezed,Object? currentOrderId = freezed,Object? orderStatus = freezed,Object? orderCreatedAt = freezed,Object? warning = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,tableNumber: null == tableNumber ? _self.tableNumber : tableNumber // ignore: cast_nullable_to_non_nullable
as String,capacity: null == capacity ? _self.capacity : capacity // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TableStatus,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,currentOrderId: freezed == currentOrderId ? _self.currentOrderId : currentOrderId // ignore: cast_nullable_to_non_nullable
as int?,orderStatus: freezed == orderStatus ? _self.orderStatus : orderStatus // ignore: cast_nullable_to_non_nullable
as String?,orderCreatedAt: freezed == orderCreatedAt ? _self.orderCreatedAt : orderCreatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,warning: null == warning ? _self.warning : warning // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [RestaurantTable].
extension RestaurantTablePatterns on RestaurantTable {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RestaurantTable value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RestaurantTable() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RestaurantTable value)  $default,){
final _that = this;
switch (_that) {
case _RestaurantTable():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RestaurantTable value)?  $default,){
final _that = this;
switch (_that) {
case _RestaurantTable() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'table_number')  String tableNumber,  int capacity,  TableStatus status, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'current_order_id')  int? currentOrderId, @JsonKey(name: 'order_status')  String? orderStatus, @JsonKey(name: 'order_created_at')  DateTime? orderCreatedAt,  int warning)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RestaurantTable() when $default != null:
return $default(_that.id,_that.tableNumber,_that.capacity,_that.status,_that.createdAt,_that.currentOrderId,_that.orderStatus,_that.orderCreatedAt,_that.warning);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'table_number')  String tableNumber,  int capacity,  TableStatus status, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'current_order_id')  int? currentOrderId, @JsonKey(name: 'order_status')  String? orderStatus, @JsonKey(name: 'order_created_at')  DateTime? orderCreatedAt,  int warning)  $default,) {final _that = this;
switch (_that) {
case _RestaurantTable():
return $default(_that.id,_that.tableNumber,_that.capacity,_that.status,_that.createdAt,_that.currentOrderId,_that.orderStatus,_that.orderCreatedAt,_that.warning);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'table_number')  String tableNumber,  int capacity,  TableStatus status, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'current_order_id')  int? currentOrderId, @JsonKey(name: 'order_status')  String? orderStatus, @JsonKey(name: 'order_created_at')  DateTime? orderCreatedAt,  int warning)?  $default,) {final _that = this;
switch (_that) {
case _RestaurantTable() when $default != null:
return $default(_that.id,_that.tableNumber,_that.capacity,_that.status,_that.createdAt,_that.currentOrderId,_that.orderStatus,_that.orderCreatedAt,_that.warning);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RestaurantTable implements RestaurantTable {
  const _RestaurantTable({required this.id, @JsonKey(name: 'table_number') required this.tableNumber, required this.capacity, this.status = TableStatus.available, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'current_order_id') this.currentOrderId, @JsonKey(name: 'order_status') this.orderStatus, @JsonKey(name: 'order_created_at') this.orderCreatedAt, this.warning = 0});
  factory _RestaurantTable.fromJson(Map<String, dynamic> json) => _$RestaurantTableFromJson(json);

@override final  int id;
@override@JsonKey(name: 'table_number') final  String tableNumber;
@override final  int capacity;
@override@JsonKey() final  TableStatus status;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;
@override@JsonKey(name: 'current_order_id') final  int? currentOrderId;
@override@JsonKey(name: 'order_status') final  String? orderStatus;
@override@JsonKey(name: 'order_created_at') final  DateTime? orderCreatedAt;
@override@JsonKey() final  int warning;

/// Create a copy of RestaurantTable
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RestaurantTableCopyWith<_RestaurantTable> get copyWith => __$RestaurantTableCopyWithImpl<_RestaurantTable>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RestaurantTableToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RestaurantTable&&(identical(other.id, id) || other.id == id)&&(identical(other.tableNumber, tableNumber) || other.tableNumber == tableNumber)&&(identical(other.capacity, capacity) || other.capacity == capacity)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.currentOrderId, currentOrderId) || other.currentOrderId == currentOrderId)&&(identical(other.orderStatus, orderStatus) || other.orderStatus == orderStatus)&&(identical(other.orderCreatedAt, orderCreatedAt) || other.orderCreatedAt == orderCreatedAt)&&(identical(other.warning, warning) || other.warning == warning));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,tableNumber,capacity,status,createdAt,currentOrderId,orderStatus,orderCreatedAt,warning);

@override
String toString() {
  return 'RestaurantTable(id: $id, tableNumber: $tableNumber, capacity: $capacity, status: $status, createdAt: $createdAt, currentOrderId: $currentOrderId, orderStatus: $orderStatus, orderCreatedAt: $orderCreatedAt, warning: $warning)';
}


}

/// @nodoc
abstract mixin class _$RestaurantTableCopyWith<$Res> implements $RestaurantTableCopyWith<$Res> {
  factory _$RestaurantTableCopyWith(_RestaurantTable value, $Res Function(_RestaurantTable) _then) = __$RestaurantTableCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'table_number') String tableNumber, int capacity, TableStatus status,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'current_order_id') int? currentOrderId,@JsonKey(name: 'order_status') String? orderStatus,@JsonKey(name: 'order_created_at') DateTime? orderCreatedAt, int warning
});




}
/// @nodoc
class __$RestaurantTableCopyWithImpl<$Res>
    implements _$RestaurantTableCopyWith<$Res> {
  __$RestaurantTableCopyWithImpl(this._self, this._then);

  final _RestaurantTable _self;
  final $Res Function(_RestaurantTable) _then;

/// Create a copy of RestaurantTable
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? tableNumber = null,Object? capacity = null,Object? status = null,Object? createdAt = freezed,Object? currentOrderId = freezed,Object? orderStatus = freezed,Object? orderCreatedAt = freezed,Object? warning = null,}) {
  return _then(_RestaurantTable(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,tableNumber: null == tableNumber ? _self.tableNumber : tableNumber // ignore: cast_nullable_to_non_nullable
as String,capacity: null == capacity ? _self.capacity : capacity // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TableStatus,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,currentOrderId: freezed == currentOrderId ? _self.currentOrderId : currentOrderId // ignore: cast_nullable_to_non_nullable
as int?,orderStatus: freezed == orderStatus ? _self.orderStatus : orderStatus // ignore: cast_nullable_to_non_nullable
as String?,orderCreatedAt: freezed == orderCreatedAt ? _self.orderCreatedAt : orderCreatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,warning: null == warning ? _self.warning : warning // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
