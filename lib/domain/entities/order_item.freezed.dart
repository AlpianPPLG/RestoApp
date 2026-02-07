// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OrderItem {

 int get id;@JsonKey(name: 'order_id') int get orderId;@JsonKey(name: 'menu_id') int get menuId; int get quantity;@JsonKey(name: 'price_at_time')@ItemPriceConverter() double get priceAtTime;@ItemPriceConverter() double? get subtotal;@JsonKey(name: 'special_notes') String? get specialNotes; OrderItemStatus get status;// Joined fields (from menu)
@JsonKey(name: 'menu_name') String? get menuName;@JsonKey(name: 'menu_image_url') String? get menuImageUrl;
/// Create a copy of OrderItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderItemCopyWith<OrderItem> get copyWith => _$OrderItemCopyWithImpl<OrderItem>(this as OrderItem, _$identity);

  /// Serializes this OrderItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderItem&&(identical(other.id, id) || other.id == id)&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.menuId, menuId) || other.menuId == menuId)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.priceAtTime, priceAtTime) || other.priceAtTime == priceAtTime)&&(identical(other.subtotal, subtotal) || other.subtotal == subtotal)&&(identical(other.specialNotes, specialNotes) || other.specialNotes == specialNotes)&&(identical(other.status, status) || other.status == status)&&(identical(other.menuName, menuName) || other.menuName == menuName)&&(identical(other.menuImageUrl, menuImageUrl) || other.menuImageUrl == menuImageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,orderId,menuId,quantity,priceAtTime,subtotal,specialNotes,status,menuName,menuImageUrl);

@override
String toString() {
  return 'OrderItem(id: $id, orderId: $orderId, menuId: $menuId, quantity: $quantity, priceAtTime: $priceAtTime, subtotal: $subtotal, specialNotes: $specialNotes, status: $status, menuName: $menuName, menuImageUrl: $menuImageUrl)';
}


}

/// @nodoc
abstract mixin class $OrderItemCopyWith<$Res>  {
  factory $OrderItemCopyWith(OrderItem value, $Res Function(OrderItem) _then) = _$OrderItemCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'order_id') int orderId,@JsonKey(name: 'menu_id') int menuId, int quantity,@JsonKey(name: 'price_at_time')@ItemPriceConverter() double priceAtTime,@ItemPriceConverter() double? subtotal,@JsonKey(name: 'special_notes') String? specialNotes, OrderItemStatus status,@JsonKey(name: 'menu_name') String? menuName,@JsonKey(name: 'menu_image_url') String? menuImageUrl
});




}
/// @nodoc
class _$OrderItemCopyWithImpl<$Res>
    implements $OrderItemCopyWith<$Res> {
  _$OrderItemCopyWithImpl(this._self, this._then);

  final OrderItem _self;
  final $Res Function(OrderItem) _then;

/// Create a copy of OrderItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? orderId = null,Object? menuId = null,Object? quantity = null,Object? priceAtTime = null,Object? subtotal = freezed,Object? specialNotes = freezed,Object? status = null,Object? menuName = freezed,Object? menuImageUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as int,menuId: null == menuId ? _self.menuId : menuId // ignore: cast_nullable_to_non_nullable
as int,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,priceAtTime: null == priceAtTime ? _self.priceAtTime : priceAtTime // ignore: cast_nullable_to_non_nullable
as double,subtotal: freezed == subtotal ? _self.subtotal : subtotal // ignore: cast_nullable_to_non_nullable
as double?,specialNotes: freezed == specialNotes ? _self.specialNotes : specialNotes // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as OrderItemStatus,menuName: freezed == menuName ? _self.menuName : menuName // ignore: cast_nullable_to_non_nullable
as String?,menuImageUrl: freezed == menuImageUrl ? _self.menuImageUrl : menuImageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [OrderItem].
extension OrderItemPatterns on OrderItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrderItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrderItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrderItem value)  $default,){
final _that = this;
switch (_that) {
case _OrderItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrderItem value)?  $default,){
final _that = this;
switch (_that) {
case _OrderItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'order_id')  int orderId, @JsonKey(name: 'menu_id')  int menuId,  int quantity, @JsonKey(name: 'price_at_time')@ItemPriceConverter()  double priceAtTime, @ItemPriceConverter()  double? subtotal, @JsonKey(name: 'special_notes')  String? specialNotes,  OrderItemStatus status, @JsonKey(name: 'menu_name')  String? menuName, @JsonKey(name: 'menu_image_url')  String? menuImageUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrderItem() when $default != null:
return $default(_that.id,_that.orderId,_that.menuId,_that.quantity,_that.priceAtTime,_that.subtotal,_that.specialNotes,_that.status,_that.menuName,_that.menuImageUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'order_id')  int orderId, @JsonKey(name: 'menu_id')  int menuId,  int quantity, @JsonKey(name: 'price_at_time')@ItemPriceConverter()  double priceAtTime, @ItemPriceConverter()  double? subtotal, @JsonKey(name: 'special_notes')  String? specialNotes,  OrderItemStatus status, @JsonKey(name: 'menu_name')  String? menuName, @JsonKey(name: 'menu_image_url')  String? menuImageUrl)  $default,) {final _that = this;
switch (_that) {
case _OrderItem():
return $default(_that.id,_that.orderId,_that.menuId,_that.quantity,_that.priceAtTime,_that.subtotal,_that.specialNotes,_that.status,_that.menuName,_that.menuImageUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'order_id')  int orderId, @JsonKey(name: 'menu_id')  int menuId,  int quantity, @JsonKey(name: 'price_at_time')@ItemPriceConverter()  double priceAtTime, @ItemPriceConverter()  double? subtotal, @JsonKey(name: 'special_notes')  String? specialNotes,  OrderItemStatus status, @JsonKey(name: 'menu_name')  String? menuName, @JsonKey(name: 'menu_image_url')  String? menuImageUrl)?  $default,) {final _that = this;
switch (_that) {
case _OrderItem() when $default != null:
return $default(_that.id,_that.orderId,_that.menuId,_that.quantity,_that.priceAtTime,_that.subtotal,_that.specialNotes,_that.status,_that.menuName,_that.menuImageUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OrderItem implements OrderItem {
  const _OrderItem({required this.id, @JsonKey(name: 'order_id') required this.orderId, @JsonKey(name: 'menu_id') required this.menuId, this.quantity = 1, @JsonKey(name: 'price_at_time')@ItemPriceConverter() required this.priceAtTime, @ItemPriceConverter() this.subtotal, @JsonKey(name: 'special_notes') this.specialNotes, this.status = OrderItemStatus.pending, @JsonKey(name: 'menu_name') this.menuName, @JsonKey(name: 'menu_image_url') this.menuImageUrl});
  factory _OrderItem.fromJson(Map<String, dynamic> json) => _$OrderItemFromJson(json);

@override final  int id;
@override@JsonKey(name: 'order_id') final  int orderId;
@override@JsonKey(name: 'menu_id') final  int menuId;
@override@JsonKey() final  int quantity;
@override@JsonKey(name: 'price_at_time')@ItemPriceConverter() final  double priceAtTime;
@override@ItemPriceConverter() final  double? subtotal;
@override@JsonKey(name: 'special_notes') final  String? specialNotes;
@override@JsonKey() final  OrderItemStatus status;
// Joined fields (from menu)
@override@JsonKey(name: 'menu_name') final  String? menuName;
@override@JsonKey(name: 'menu_image_url') final  String? menuImageUrl;

/// Create a copy of OrderItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderItemCopyWith<_OrderItem> get copyWith => __$OrderItemCopyWithImpl<_OrderItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OrderItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderItem&&(identical(other.id, id) || other.id == id)&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.menuId, menuId) || other.menuId == menuId)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.priceAtTime, priceAtTime) || other.priceAtTime == priceAtTime)&&(identical(other.subtotal, subtotal) || other.subtotal == subtotal)&&(identical(other.specialNotes, specialNotes) || other.specialNotes == specialNotes)&&(identical(other.status, status) || other.status == status)&&(identical(other.menuName, menuName) || other.menuName == menuName)&&(identical(other.menuImageUrl, menuImageUrl) || other.menuImageUrl == menuImageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,orderId,menuId,quantity,priceAtTime,subtotal,specialNotes,status,menuName,menuImageUrl);

@override
String toString() {
  return 'OrderItem(id: $id, orderId: $orderId, menuId: $menuId, quantity: $quantity, priceAtTime: $priceAtTime, subtotal: $subtotal, specialNotes: $specialNotes, status: $status, menuName: $menuName, menuImageUrl: $menuImageUrl)';
}


}

/// @nodoc
abstract mixin class _$OrderItemCopyWith<$Res> implements $OrderItemCopyWith<$Res> {
  factory _$OrderItemCopyWith(_OrderItem value, $Res Function(_OrderItem) _then) = __$OrderItemCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'order_id') int orderId,@JsonKey(name: 'menu_id') int menuId, int quantity,@JsonKey(name: 'price_at_time')@ItemPriceConverter() double priceAtTime,@ItemPriceConverter() double? subtotal,@JsonKey(name: 'special_notes') String? specialNotes, OrderItemStatus status,@JsonKey(name: 'menu_name') String? menuName,@JsonKey(name: 'menu_image_url') String? menuImageUrl
});




}
/// @nodoc
class __$OrderItemCopyWithImpl<$Res>
    implements _$OrderItemCopyWith<$Res> {
  __$OrderItemCopyWithImpl(this._self, this._then);

  final _OrderItem _self;
  final $Res Function(_OrderItem) _then;

/// Create a copy of OrderItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? orderId = null,Object? menuId = null,Object? quantity = null,Object? priceAtTime = null,Object? subtotal = freezed,Object? specialNotes = freezed,Object? status = null,Object? menuName = freezed,Object? menuImageUrl = freezed,}) {
  return _then(_OrderItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as int,menuId: null == menuId ? _self.menuId : menuId // ignore: cast_nullable_to_non_nullable
as int,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,priceAtTime: null == priceAtTime ? _self.priceAtTime : priceAtTime // ignore: cast_nullable_to_non_nullable
as double,subtotal: freezed == subtotal ? _self.subtotal : subtotal // ignore: cast_nullable_to_non_nullable
as double?,specialNotes: freezed == specialNotes ? _self.specialNotes : specialNotes // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as OrderItemStatus,menuName: freezed == menuName ? _self.menuName : menuName // ignore: cast_nullable_to_non_nullable
as String?,menuImageUrl: freezed == menuImageUrl ? _self.menuImageUrl : menuImageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
