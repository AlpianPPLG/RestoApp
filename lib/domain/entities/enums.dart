/// Enums shared across the application.
///
/// Matches the MySQL ENUM definitions in the database.
library;

import 'package:json_annotation/json_annotation.dart';

/// User roles in the system.
enum UserRole {
  admin,
  waiter,
  cashier,
  kitchen;

  String get displayName {
    switch (this) {
      case UserRole.admin:
        return 'Admin';
      case UserRole.waiter:
        return 'Waiter';
      case UserRole.cashier:
        return 'Cashier';
      case UserRole.kitchen:
        return 'Kitchen';
    }
  }
}

/// Physical table status.
enum TableStatus {
  available,
  reserved,
  occupied;

  String get displayName {
    switch (this) {
      case TableStatus.available:
        return 'Available';
      case TableStatus.reserved:
        return 'Reserved';
      case TableStatus.occupied:
        return 'Occupied';
    }
  }
}

/// Order type.
enum OrderType {
  @JsonValue('dine_in')
  dineIn,
  @JsonValue('take_away')
  takeAway;

  String get displayName {
    switch (this) {
      case OrderType.dineIn:
        return 'Dine In';
      case OrderType.takeAway:
        return 'Take Away';
    }
  }

  /// Value used in API / database.
  String get apiValue {
    switch (this) {
      case OrderType.dineIn:
        return 'dine_in';
      case OrderType.takeAway:
        return 'take_away';
    }
  }

  static OrderType fromApiValue(String value) {
    switch (value) {
      case 'dine_in':
        return OrderType.dineIn;
      case 'take_away':
        return OrderType.takeAway;
      default:
        return OrderType.dineIn;
    }
  }
}

/// Order status flow.
enum OrderStatus {
  pending,
  processing,
  delivered,
  completed,
  cancelled;

  String get displayName {
    switch (this) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.processing:
        return 'Processing';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.completed:
        return 'Completed';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }
}

/// Order item status.
enum OrderItemStatus {
  pending,
  cooking,
  served;

  String get displayName {
    switch (this) {
      case OrderItemStatus.pending:
        return 'Pending';
      case OrderItemStatus.cooking:
        return 'Cooking';
      case OrderItemStatus.served:
        return 'Served';
    }
  }
}

/// Payment methods.
enum PaymentMethod {
  cash,
  qris,
  debit;

  String get displayName {
    switch (this) {
      case PaymentMethod.cash:
        return 'Cash';
      case PaymentMethod.qris:
        return 'QRIS';
      case PaymentMethod.debit:
        return 'Debit';
    }
  }
}
