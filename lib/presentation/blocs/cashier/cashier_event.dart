part of 'cashier_bloc.dart';

abstract class CashierEvent extends Equatable {
  const CashierEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load orders ready for payment
class CashierLoadReadyOrders extends CashierEvent {
  const CashierLoadReadyOrders();
}

/// Event to refresh ready orders
class CashierRefresh extends CashierEvent {
  const CashierRefresh();
}

/// Event to start auto refresh timer
class CashierStartAutoRefresh extends CashierEvent {
  const CashierStartAutoRefresh();
}

/// Event to stop auto refresh timer
class CashierStopAutoRefresh extends CashierEvent {
  const CashierStopAutoRefresh();
}

/// Event to select an order for payment
class CashierSelectOrder extends CashierEvent {
  final int orderId;

  const CashierSelectOrder({required this.orderId});

  @override
  List<Object?> get props => [orderId];
}

/// Event to process payment
class CashierProcessPayment extends CashierEvent {
  final int orderId;
  final PaymentMethod paymentMethod;
  final double amountPaid;
  final String? notes;

  const CashierProcessPayment({
    required this.orderId,
    required this.paymentMethod,
    required this.amountPaid,
    this.notes,
  });

  @override
  List<Object?> get props => [orderId, paymentMethod, amountPaid, notes];
}

/// Event to generate receipt
class CashierGenerateReceipt extends CashierEvent {
  final int orderId;

  const CashierGenerateReceipt({required this.orderId});

  @override
  List<Object?> get props => [orderId];
}

/// Event to load transaction history
class CashierLoadTransactions extends CashierEvent {
  final DateTime? startDate;
  final DateTime? endDate;

  const CashierLoadTransactions({this.startDate, this.endDate});

  @override
  List<Object?> get props => [startDate, endDate];
}

/// Event to clear selected order
class CashierClearSelection extends CashierEvent {
  const CashierClearSelection();
}
