part of 'cashier_bloc.dart';

abstract class CashierState extends Equatable {
  const CashierState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class CashierInitial extends CashierState {}

/// Loading state
class CashierLoading extends CashierState {}

/// Loaded state with orders ready for payment
class CashierLoaded extends CashierState {
  final List<Order> readyOrders;
  final Order? selectedOrder;
  final DateTime lastUpdated;
  final String? error;

  const CashierLoaded({
    required this.readyOrders,
    this.selectedOrder,
    required this.lastUpdated,
    this.error,
  });

  /// Get total orders ready for payment
  int get totalReadyOrders => readyOrders.length;

  /// Get total revenue from ready orders
  double get totalPendingRevenue {
    return readyOrders.fold(0.0, (sum, order) => sum + order.totalAmount);
  }

  /// Check if an order is selected
  bool get hasSelectedOrder => selectedOrder != null;

  CashierLoaded copyWith({
    List<Order>? readyOrders,
    Order? selectedOrder,
    DateTime? lastUpdated,
    String? error,
    bool clearSelectedOrder = false,
  }) {
    return CashierLoaded(
      readyOrders: readyOrders ?? this.readyOrders,
      selectedOrder: clearSelectedOrder
          ? null
          : selectedOrder ?? this.selectedOrder,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      error: error,
    );
  }

  @override
  List<Object?> get props => [readyOrders, selectedOrder, lastUpdated, error];
}

/// Payment processing state
class CashierProcessingPayment extends CashierState {
  final Order order;
  final PaymentMethod paymentMethod;
  final double amountPaid;

  const CashierProcessingPayment({
    required this.order,
    required this.paymentMethod,
    required this.amountPaid,
  });

  @override
  List<Object?> get props => [order, paymentMethod, amountPaid];
}

/// Payment completed state
class CashierPaymentCompleted extends CashierState {
  final Order order;
  final PaymentMethod paymentMethod;
  final double amountPaid;
  final double change;
  final String receiptData;

  const CashierPaymentCompleted({
    required this.order,
    required this.paymentMethod,
    required this.amountPaid,
    required this.change,
    required this.receiptData,
  });

  @override
  List<Object?> get props => [
    order,
    paymentMethod,
    amountPaid,
    change,
    receiptData,
  ];
}

/// Transaction history loaded state
class CashierTransactionsLoaded extends CashierState {
  final List<Order> transactions;
  final DateTime? startDate;
  final DateTime? endDate;
  final double totalRevenue;
  final int totalTransactions;

  const CashierTransactionsLoaded({
    required this.transactions,
    this.startDate,
    this.endDate,
    required this.totalRevenue,
    required this.totalTransactions,
  });

  @override
  List<Object?> get props => [
    transactions,
    startDate,
    endDate,
    totalRevenue,
    totalTransactions,
  ];
}

/// Error state
class CashierError extends CashierState {
  final String message;

  const CashierError(this.message);

  @override
  List<Object?> get props => [message];
}
