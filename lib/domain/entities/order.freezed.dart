// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Order {

 int get id;@JsonKey(name: 'table_id') int? get tableId;@JsonKey(name: 'user_id') int get userId;@JsonKey(name: 'customer_name') String? get customerName;@JsonKey(name: 'order_type') OrderType get orderType; OrderStatus get status;@JsonKey(name: 'total_amount')@AmountConverter() double get totalAmount;@JsonKey(name: 'created_at') DateTime? get createdAt;@JsonKey(name: 'updated_at') DateTime? get updatedAt;// Joined fields
 List<OrderItem> get items;@JsonKey(name: 'table_number') String? get tableNumber;@JsonKey(name: 'waiter_name') String? get waiterName;
/// Create a copy of Order
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderCopyWith<Order> get copyWith => _$OrderCopyWithImpl<Order>(this as Order, _$identity);

  /// Serializes this Order to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Order&&(identical(other.id, id) || other.id == id)&&(identical(other.tableId, tableId) || other.tableId == tableId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.orderType, orderType) || other.orderType == orderType)&&(identical(other.status, status) || other.status == status)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.tableNumber, tableNumber) || other.tableNumber == tableNumber)&&(identical(other.waiterName, waiterName) || other.waiterName == waiterName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,tableId,userId,customerName,orderType,status,totalAmount,createdAt,updatedAt,const DeepCollectionEquality().hash(items),tableNumber,waiterName);

@override
String toString() {
  return 'Order(id: $id, tableId: $tableId, userId: $userId, customerName: $customerName, orderType: $orderType, status: $status, totalAmount: $totalAmount, createdAt: $createdAt, updatedAt: $updatedAt, items: $items, tableNumber: $tableNumber, waiterName: $waiterName)';
}


}

/// @nodoc
abstract mixin class $OrderCopyWith<$Res>  {
  factory $OrderCopyWith(Order value, $Res Function(Order) _then) = _$OrderCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'table_id') int? tableId,@JsonKey(name: 'user_id') int userId,@JsonKey(name: 'customer_name') String? customerName,@JsonKey(name: 'order_type') OrderType orderType, OrderStatus status,@JsonKey(name: 'total_amount')@AmountConverter() double totalAmount,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt, List<OrderItem> items,@JsonKey(name: 'table_number') String? tableNumber,@JsonKey(name: 'waiter_name') String? waiterName
});




}
/// @nodoc
class _$OrderCopyWithImpl<$Res>
    implements $OrderCopyWith<$Res> {
  _$OrderCopyWithImpl(this._self, this._then);

  final Order _self;
  final $Res Function(Order) _then;

/// Create a copy of Order
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? tableId = freezed,Object? userId = null,Object? customerName = freezed,Object? orderType = null,Object? status = null,Object? totalAmount = null,Object? createdAt = freezed,Object? updatedAt = freezed,Object? items = null,Object? tableNumber = freezed,Object? waiterName = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,tableId: freezed == tableId ? _self.tableId : tableId // ignore: cast_nullable_to_non_nullable
as int?,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,customerName: freezed == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String?,orderType: null == orderType ? _self.orderType : orderType // ignore: cast_nullable_to_non_nullable
as OrderType,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as OrderStatus,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<OrderItem>,tableNumber: freezed == tableNumber ? _self.tableNumber : tableNumber // ignore: cast_nullable_to_non_nullable
as String?,waiterName: freezed == waiterName ? _self.waiterName : waiterName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Order].
extension OrderPatterns on Order {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Order value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Order() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Order value)  $default,){
final _that = this;
switch (_that) {
case _Order():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Order value)?  $default,){
final _that = this;
switch (_that) {
case _Order() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'table_id')  int? tableId, @JsonKey(name: 'user_id')  int userId, @JsonKey(name: 'customer_name')  String? customerName, @JsonKey(name: 'order_type')  OrderType orderType,  OrderStatus status, @JsonKey(name: 'total_amount')@AmountConverter()  double totalAmount, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt,  List<OrderItem> items, @JsonKey(name: 'table_number')  String? tableNumber, @JsonKey(name: 'waiter_name')  String? waiterName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Order() when $default != null:
return $default(_that.id,_that.tableId,_that.userId,_that.customerName,_that.orderType,_that.status,_that.totalAmount,_that.createdAt,_that.updatedAt,_that.items,_that.tableNumber,_that.waiterName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'table_id')  int? tableId, @JsonKey(name: 'user_id')  int userId, @JsonKey(name: 'customer_name')  String? customerName, @JsonKey(name: 'order_type')  OrderType orderType,  OrderStatus status, @JsonKey(name: 'total_amount')@AmountConverter()  double totalAmount, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt,  List<OrderItem> items, @JsonKey(name: 'table_number')  String? tableNumber, @JsonKey(name: 'waiter_name')  String? waiterName)  $default,) {final _that = this;
switch (_that) {
case _Order():
return $default(_that.id,_that.tableId,_that.userId,_that.customerName,_that.orderType,_that.status,_that.totalAmount,_that.createdAt,_that.updatedAt,_that.items,_that.tableNumber,_that.waiterName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'table_id')  int? tableId, @JsonKey(name: 'user_id')  int userId, @JsonKey(name: 'customer_name')  String? customerName, @JsonKey(name: 'order_type')  OrderType orderType,  OrderStatus status, @JsonKey(name: 'total_amount')@AmountConverter()  double totalAmount, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt,  List<OrderItem> items, @JsonKey(name: 'table_number')  String? tableNumber, @JsonKey(name: 'waiter_name')  String? waiterName)?  $default,) {final _that = this;
switch (_that) {
case _Order() when $default != null:
return $default(_that.id,_that.tableId,_that.userId,_that.customerName,_that.orderType,_that.status,_that.totalAmount,_that.createdAt,_that.updatedAt,_that.items,_that.tableNumber,_that.waiterName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Order implements Order {
  const _Order({required this.id, @JsonKey(name: 'table_id') this.tableId, @JsonKey(name: 'user_id') required this.userId, @JsonKey(name: 'customer_name') this.customerName, @JsonKey(name: 'order_type') this.orderType = OrderType.dineIn, this.status = OrderStatus.pending, @JsonKey(name: 'total_amount')@AmountConverter() this.totalAmount = 0, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'updated_at') this.updatedAt, final  List<OrderItem> items = const [], @JsonKey(name: 'table_number') this.tableNumber, @JsonKey(name: 'waiter_name') this.waiterName}): _items = items;
  factory _Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

@override final  int id;
@override@JsonKey(name: 'table_id') final  int? tableId;
@override@JsonKey(name: 'user_id') final  int userId;
@override@JsonKey(name: 'customer_name') final  String? customerName;
@override@JsonKey(name: 'order_type') final  OrderType orderType;
@override@JsonKey() final  OrderStatus status;
@override@JsonKey(name: 'total_amount')@AmountConverter() final  double totalAmount;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime? updatedAt;
// Joined fields
 final  List<OrderItem> _items;
// Joined fields
@override@JsonKey() List<OrderItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override@JsonKey(name: 'table_number') final  String? tableNumber;
@override@JsonKey(name: 'waiter_name') final  String? waiterName;

/// Create a copy of Order
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderCopyWith<_Order> get copyWith => __$OrderCopyWithImpl<_Order>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OrderToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Order&&(identical(other.id, id) || other.id == id)&&(identical(other.tableId, tableId) || other.tableId == tableId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.orderType, orderType) || other.orderType == orderType)&&(identical(other.status, status) || other.status == status)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.tableNumber, tableNumber) || other.tableNumber == tableNumber)&&(identical(other.waiterName, waiterName) || other.waiterName == waiterName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,tableId,userId,customerName,orderType,status,totalAmount,createdAt,updatedAt,const DeepCollectionEquality().hash(_items),tableNumber,waiterName);

@override
String toString() {
  return 'Order(id: $id, tableId: $tableId, userId: $userId, customerName: $customerName, orderType: $orderType, status: $status, totalAmount: $totalAmount, createdAt: $createdAt, updatedAt: $updatedAt, items: $items, tableNumber: $tableNumber, waiterName: $waiterName)';
}


}

/// @nodoc
abstract mixin class _$OrderCopyWith<$Res> implements $OrderCopyWith<$Res> {
  factory _$OrderCopyWith(_Order value, $Res Function(_Order) _then) = __$OrderCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'table_id') int? tableId,@JsonKey(name: 'user_id') int userId,@JsonKey(name: 'customer_name') String? customerName,@JsonKey(name: 'order_type') OrderType orderType, OrderStatus status,@JsonKey(name: 'total_amount')@AmountConverter() double totalAmount,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt, List<OrderItem> items,@JsonKey(name: 'table_number') String? tableNumber,@JsonKey(name: 'waiter_name') String? waiterName
});




}
/// @nodoc
class __$OrderCopyWithImpl<$Res>
    implements _$OrderCopyWith<$Res> {
  __$OrderCopyWithImpl(this._self, this._then);

  final _Order _self;
  final $Res Function(_Order) _then;

/// Create a copy of Order
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? tableId = freezed,Object? userId = null,Object? customerName = freezed,Object? orderType = null,Object? status = null,Object? totalAmount = null,Object? createdAt = freezed,Object? updatedAt = freezed,Object? items = null,Object? tableNumber = freezed,Object? waiterName = freezed,}) {
  return _then(_Order(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,tableId: freezed == tableId ? _self.tableId : tableId // ignore: cast_nullable_to_non_nullable
as int?,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,customerName: freezed == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String?,orderType: null == orderType ? _self.orderType : orderType // ignore: cast_nullable_to_non_nullable
as OrderType,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as OrderStatus,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<OrderItem>,tableNumber: freezed == tableNumber ? _self.tableNumber : tableNumber // ignore: cast_nullable_to_non_nullable
as String?,waiterName: freezed == waiterName ? _self.waiterName : waiterName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
