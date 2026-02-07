// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Payment {

 int get id;@JsonKey(name: 'order_id') int get orderId;@JsonKey(name: 'cashier_id') int get cashierId;@JsonKey(name: 'payment_method') PaymentMethod get paymentMethod;@JsonKey(name: 'amount_paid')@PaymentAmountConverter() double get amountPaid;@JsonKey(name: 'change_amount')@PaymentAmountConverter() double get changeAmount;@JsonKey(name: 'transaction_date') DateTime? get transactionDate;// Joined fields
@JsonKey(name: 'cashier_name') String? get cashierName;
/// Create a copy of Payment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentCopyWith<Payment> get copyWith => _$PaymentCopyWithImpl<Payment>(this as Payment, _$identity);

  /// Serializes this Payment to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Payment&&(identical(other.id, id) || other.id == id)&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.cashierId, cashierId) || other.cashierId == cashierId)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.amountPaid, amountPaid) || other.amountPaid == amountPaid)&&(identical(other.changeAmount, changeAmount) || other.changeAmount == changeAmount)&&(identical(other.transactionDate, transactionDate) || other.transactionDate == transactionDate)&&(identical(other.cashierName, cashierName) || other.cashierName == cashierName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,orderId,cashierId,paymentMethod,amountPaid,changeAmount,transactionDate,cashierName);

@override
String toString() {
  return 'Payment(id: $id, orderId: $orderId, cashierId: $cashierId, paymentMethod: $paymentMethod, amountPaid: $amountPaid, changeAmount: $changeAmount, transactionDate: $transactionDate, cashierName: $cashierName)';
}


}

/// @nodoc
abstract mixin class $PaymentCopyWith<$Res>  {
  factory $PaymentCopyWith(Payment value, $Res Function(Payment) _then) = _$PaymentCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'order_id') int orderId,@JsonKey(name: 'cashier_id') int cashierId,@JsonKey(name: 'payment_method') PaymentMethod paymentMethod,@JsonKey(name: 'amount_paid')@PaymentAmountConverter() double amountPaid,@JsonKey(name: 'change_amount')@PaymentAmountConverter() double changeAmount,@JsonKey(name: 'transaction_date') DateTime? transactionDate,@JsonKey(name: 'cashier_name') String? cashierName
});




}
/// @nodoc
class _$PaymentCopyWithImpl<$Res>
    implements $PaymentCopyWith<$Res> {
  _$PaymentCopyWithImpl(this._self, this._then);

  final Payment _self;
  final $Res Function(Payment) _then;

/// Create a copy of Payment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? orderId = null,Object? cashierId = null,Object? paymentMethod = null,Object? amountPaid = null,Object? changeAmount = null,Object? transactionDate = freezed,Object? cashierName = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as int,cashierId: null == cashierId ? _self.cashierId : cashierId // ignore: cast_nullable_to_non_nullable
as int,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as PaymentMethod,amountPaid: null == amountPaid ? _self.amountPaid : amountPaid // ignore: cast_nullable_to_non_nullable
as double,changeAmount: null == changeAmount ? _self.changeAmount : changeAmount // ignore: cast_nullable_to_non_nullable
as double,transactionDate: freezed == transactionDate ? _self.transactionDate : transactionDate // ignore: cast_nullable_to_non_nullable
as DateTime?,cashierName: freezed == cashierName ? _self.cashierName : cashierName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Payment].
extension PaymentPatterns on Payment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Payment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Payment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Payment value)  $default,){
final _that = this;
switch (_that) {
case _Payment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Payment value)?  $default,){
final _that = this;
switch (_that) {
case _Payment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'order_id')  int orderId, @JsonKey(name: 'cashier_id')  int cashierId, @JsonKey(name: 'payment_method')  PaymentMethod paymentMethod, @JsonKey(name: 'amount_paid')@PaymentAmountConverter()  double amountPaid, @JsonKey(name: 'change_amount')@PaymentAmountConverter()  double changeAmount, @JsonKey(name: 'transaction_date')  DateTime? transactionDate, @JsonKey(name: 'cashier_name')  String? cashierName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Payment() when $default != null:
return $default(_that.id,_that.orderId,_that.cashierId,_that.paymentMethod,_that.amountPaid,_that.changeAmount,_that.transactionDate,_that.cashierName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'order_id')  int orderId, @JsonKey(name: 'cashier_id')  int cashierId, @JsonKey(name: 'payment_method')  PaymentMethod paymentMethod, @JsonKey(name: 'amount_paid')@PaymentAmountConverter()  double amountPaid, @JsonKey(name: 'change_amount')@PaymentAmountConverter()  double changeAmount, @JsonKey(name: 'transaction_date')  DateTime? transactionDate, @JsonKey(name: 'cashier_name')  String? cashierName)  $default,) {final _that = this;
switch (_that) {
case _Payment():
return $default(_that.id,_that.orderId,_that.cashierId,_that.paymentMethod,_that.amountPaid,_that.changeAmount,_that.transactionDate,_that.cashierName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'order_id')  int orderId, @JsonKey(name: 'cashier_id')  int cashierId, @JsonKey(name: 'payment_method')  PaymentMethod paymentMethod, @JsonKey(name: 'amount_paid')@PaymentAmountConverter()  double amountPaid, @JsonKey(name: 'change_amount')@PaymentAmountConverter()  double changeAmount, @JsonKey(name: 'transaction_date')  DateTime? transactionDate, @JsonKey(name: 'cashier_name')  String? cashierName)?  $default,) {final _that = this;
switch (_that) {
case _Payment() when $default != null:
return $default(_that.id,_that.orderId,_that.cashierId,_that.paymentMethod,_that.amountPaid,_that.changeAmount,_that.transactionDate,_that.cashierName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Payment implements Payment {
  const _Payment({required this.id, @JsonKey(name: 'order_id') required this.orderId, @JsonKey(name: 'cashier_id') required this.cashierId, @JsonKey(name: 'payment_method') this.paymentMethod = PaymentMethod.cash, @JsonKey(name: 'amount_paid')@PaymentAmountConverter() required this.amountPaid, @JsonKey(name: 'change_amount')@PaymentAmountConverter() required this.changeAmount, @JsonKey(name: 'transaction_date') this.transactionDate, @JsonKey(name: 'cashier_name') this.cashierName});
  factory _Payment.fromJson(Map<String, dynamic> json) => _$PaymentFromJson(json);

@override final  int id;
@override@JsonKey(name: 'order_id') final  int orderId;
@override@JsonKey(name: 'cashier_id') final  int cashierId;
@override@JsonKey(name: 'payment_method') final  PaymentMethod paymentMethod;
@override@JsonKey(name: 'amount_paid')@PaymentAmountConverter() final  double amountPaid;
@override@JsonKey(name: 'change_amount')@PaymentAmountConverter() final  double changeAmount;
@override@JsonKey(name: 'transaction_date') final  DateTime? transactionDate;
// Joined fields
@override@JsonKey(name: 'cashier_name') final  String? cashierName;

/// Create a copy of Payment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentCopyWith<_Payment> get copyWith => __$PaymentCopyWithImpl<_Payment>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaymentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Payment&&(identical(other.id, id) || other.id == id)&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.cashierId, cashierId) || other.cashierId == cashierId)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.amountPaid, amountPaid) || other.amountPaid == amountPaid)&&(identical(other.changeAmount, changeAmount) || other.changeAmount == changeAmount)&&(identical(other.transactionDate, transactionDate) || other.transactionDate == transactionDate)&&(identical(other.cashierName, cashierName) || other.cashierName == cashierName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,orderId,cashierId,paymentMethod,amountPaid,changeAmount,transactionDate,cashierName);

@override
String toString() {
  return 'Payment(id: $id, orderId: $orderId, cashierId: $cashierId, paymentMethod: $paymentMethod, amountPaid: $amountPaid, changeAmount: $changeAmount, transactionDate: $transactionDate, cashierName: $cashierName)';
}


}

/// @nodoc
abstract mixin class _$PaymentCopyWith<$Res> implements $PaymentCopyWith<$Res> {
  factory _$PaymentCopyWith(_Payment value, $Res Function(_Payment) _then) = __$PaymentCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'order_id') int orderId,@JsonKey(name: 'cashier_id') int cashierId,@JsonKey(name: 'payment_method') PaymentMethod paymentMethod,@JsonKey(name: 'amount_paid')@PaymentAmountConverter() double amountPaid,@JsonKey(name: 'change_amount')@PaymentAmountConverter() double changeAmount,@JsonKey(name: 'transaction_date') DateTime? transactionDate,@JsonKey(name: 'cashier_name') String? cashierName
});




}
/// @nodoc
class __$PaymentCopyWithImpl<$Res>
    implements _$PaymentCopyWith<$Res> {
  __$PaymentCopyWithImpl(this._self, this._then);

  final _Payment _self;
  final $Res Function(_Payment) _then;

/// Create a copy of Payment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? orderId = null,Object? cashierId = null,Object? paymentMethod = null,Object? amountPaid = null,Object? changeAmount = null,Object? transactionDate = freezed,Object? cashierName = freezed,}) {
  return _then(_Payment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as int,cashierId: null == cashierId ? _self.cashierId : cashierId // ignore: cast_nullable_to_non_nullable
as int,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as PaymentMethod,amountPaid: null == amountPaid ? _self.amountPaid : amountPaid // ignore: cast_nullable_to_non_nullable
as double,changeAmount: null == changeAmount ? _self.changeAmount : changeAmount // ignore: cast_nullable_to_non_nullable
as double,transactionDate: freezed == transactionDate ? _self.transactionDate : transactionDate // ignore: cast_nullable_to_non_nullable
as DateTime?,cashierName: freezed == cashierName ? _self.cashierName : cashierName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
