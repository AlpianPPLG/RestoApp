import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart' hide Order;
import 'package:restoapp/core/error/exceptions.dart';
import 'package:restoapp/domain/entities/enums.dart';
import 'package:restoapp/domain/entities/order.dart';
import 'package:restoapp/domain/repositories/order_repository.dart';

part 'cashier_event.dart';
part 'cashier_state.dart';

@injectable
class CashierBloc extends Bloc<CashierEvent, CashierState> {
  final OrderRepository orderRepository;
  Timer? _autoRefreshTimer;

  CashierBloc({required this.orderRepository}) : super(CashierInitial()) {
    on<CashierLoadReadyOrders>(_onLoadReadyOrders);
    on<CashierRefresh>(_onRefresh);
    on<CashierStartAutoRefresh>(_onStartAutoRefresh);
    on<CashierStopAutoRefresh>(_onStopAutoRefresh);
    on<CashierSelectOrder>(_onSelectOrder);
    on<CashierProcessPayment>(_onProcessPayment);
    on<CashierGenerateReceipt>(_onGenerateReceipt);
    on<CashierLoadTransactions>(_onLoadTransactions);
    on<CashierClearSelection>(_onClearSelection);
  }

  Future<void> _onLoadReadyOrders(
    CashierLoadReadyOrders event,
    Emitter<CashierState> emit,
  ) async {
    emit(CashierLoading());

    try {
      // Get orders that are ready for payment (status: delivered)
      final orders = await orderRepository.getOrdersByStatus(
        OrderStatus.delivered,
      );
      emit(CashierLoaded(readyOrders: orders, lastUpdated: DateTime.now()));
    } on ServerException catch (e) {
      emit(CashierError(e.message));
    } catch (e) {
      emit(const CashierError('Failed to load ready orders'));
    }
  }

  Future<void> _onRefresh(
    CashierRefresh event,
    Emitter<CashierState> emit,
  ) async {
    if (state is! CashierLoaded) return;

    final currentState = state as CashierLoaded;

    try {
      final orders = await orderRepository.getOrdersByStatus(
        OrderStatus.delivered,
      );
      emit(
        currentState.copyWith(
          readyOrders: orders,
          lastUpdated: DateTime.now(),
          error: null,
        ),
      );
    } on ServerException catch (e) {
      emit(currentState.copyWith(error: e.message));
    } catch (e) {
      emit(currentState.copyWith(error: 'Failed to refresh orders'));
    }
  }

  void _onStartAutoRefresh(
    CashierStartAutoRefresh event,
    Emitter<CashierState> emit,
  ) {
    _stopAutoRefresh();
    _autoRefreshTimer = Timer.periodic(
      const Duration(seconds: 15), // Refresh every 15 seconds for cashier
      (_) => add(const CashierRefresh()),
    );
  }

  void _onStopAutoRefresh(
    CashierStopAutoRefresh event,
    Emitter<CashierState> emit,
  ) {
    _stopAutoRefresh();
  }

  Future<void> _onSelectOrder(
    CashierSelectOrder event,
    Emitter<CashierState> emit,
  ) async {
    if (state is! CashierLoaded) return;

    final currentState = state as CashierLoaded;

    try {
      // Get full order details with items
      final order = await orderRepository.getOrder(event.orderId);
      emit(currentState.copyWith(selectedOrder: order, error: null));
    } on ServerException catch (e) {
      emit(currentState.copyWith(error: e.message));
    } catch (e) {
      emit(currentState.copyWith(error: 'Failed to select order'));
    }
  }

  Future<void> _onProcessPayment(
    CashierProcessPayment event,
    Emitter<CashierState> emit,
  ) async {
    if (state is! CashierLoaded) return;

    final currentState = state as CashierLoaded;
    final order = currentState.selectedOrder;

    if (order == null) {
      emit(currentState.copyWith(error: 'No order selected for payment'));
      return;
    }

    emit(
      CashierProcessingPayment(
        order: order,
        paymentMethod: event.paymentMethod,
        amountPaid: event.amountPaid,
      ),
    );

    try {
      // Calculate change for cash payments
      double change = 0.0;
      if (event.paymentMethod == PaymentMethod.cash) {
        change = event.amountPaid - order.totalAmount;
        if (change < 0) {
          emit(CashierError('Insufficient payment amount'));
          return;
        }
      }

      // Process payment in backend
      await orderRepository.processPayment(
        orderId: event.orderId,
        paymentMethod: event.paymentMethod,
        amountPaid: event.amountPaid,
        notes: event.notes,
      );

      // Generate receipt data
      final receiptData = _generateReceiptData(
        order,
        event.paymentMethod,
        event.amountPaid,
        change,
      );

      emit(
        CashierPaymentCompleted(
          order: order,
          paymentMethod: event.paymentMethod,
          amountPaid: event.amountPaid,
          change: change,
          receiptData: receiptData,
        ),
      );
    } on ServerException catch (e) {
      emit(currentState.copyWith(error: e.message));
    } catch (e) {
      emit(currentState.copyWith(error: 'Failed to process payment'));
    }
  }

  Future<void> _onGenerateReceipt(
    CashierGenerateReceipt event,
    Emitter<CashierState> emit,
  ) async {
    try {
      final order = await orderRepository.getOrder(event.orderId);

      // Generate receipt data for this order
      _generateReceiptData(
        order,
        PaymentMethod
            .cash, // Default payment method since Order doesn't have paymentMethod
        order.totalAmount,
        0.0,
      );

      // Could emit a specific receipt generated state if needed
      // For now, we'll handle this in the UI
    } on ServerException catch (e) {
      if (state is CashierLoaded) {
        final currentState = state as CashierLoaded;
        emit(currentState.copyWith(error: e.message));
      } else {
        emit(CashierError(e.message));
      }
    } catch (e) {
      if (state is CashierLoaded) {
        final currentState = state as CashierLoaded;
        emit(currentState.copyWith(error: 'Failed to generate receipt'));
      } else {
        emit(const CashierError('Failed to generate receipt'));
      }
    }
  }

  Future<void> _onLoadTransactions(
    CashierLoadTransactions event,
    Emitter<CashierState> emit,
  ) async {
    emit(CashierLoading());

    try {
      final transactions = await orderRepository.getTransactionHistory(
        startDate: event.startDate,
        endDate: event.endDate,
      );

      final totalRevenue = transactions.fold(
        0.0,
        (sum, order) => sum + order.totalAmount,
      );

      emit(
        CashierTransactionsLoaded(
          transactions: transactions,
          startDate: event.startDate,
          endDate: event.endDate,
          totalRevenue: totalRevenue,
          totalTransactions: transactions.length,
        ),
      );
    } on ServerException catch (e) {
      emit(CashierError(e.message));
    } catch (e) {
      emit(const CashierError('Failed to load transaction history'));
    }
  }

  void _onClearSelection(
    CashierClearSelection event,
    Emitter<CashierState> emit,
  ) {
    if (state is CashierLoaded) {
      final currentState = state as CashierLoaded;
      emit(currentState.copyWith(clearSelectedOrder: true));
    }
  }

  String _generateReceiptData(
    Order order,
    PaymentMethod paymentMethod,
    double amountPaid,
    double change,
  ) {
    final buffer = StringBuffer();

    buffer.writeln('=====================================');
    buffer.writeln('           RESTOAPP RECEIPT          ');
    buffer.writeln('=====================================');
    buffer.writeln();
    buffer.writeln('Order #: ${order.id}');
    buffer.writeln('Table: ${order.tableNumber ?? order.tableId}');
    buffer.writeln('Date: ${DateTime.now().toString().split('.')[0]}');
    buffer.writeln('Cashier: Staff');
    buffer.writeln();
    buffer.writeln('=====================================');
    buffer.writeln('Items:');

    for (final item in order.items) {
      buffer.writeln('${item.quantity}x ${item.menuName ?? 'Unknown Item'}');
      buffer.writeln(
        '    @${item.priceAtTime.toStringAsFixed(2)} = ${(item.quantity * item.priceAtTime).toStringAsFixed(2)}',
      );
      if (item.specialNotes != null && item.specialNotes!.isNotEmpty) {
        buffer.writeln('    Note: ${item.specialNotes}');
      }
    }

    buffer.writeln('=====================================');
    final subtotal = _calculateSubtotal(order);
    final tax = _calculateTax(order);
    buffer.writeln('Subtotal:  ${subtotal.toStringAsFixed(2)}');
    buffer.writeln('Tax:       ${tax.toStringAsFixed(2)}');
    buffer.writeln('Total:     ${order.totalAmount.toStringAsFixed(2)}');
    buffer.writeln();
    buffer.writeln('Payment:   ${paymentMethod.displayName}');
    buffer.writeln('Paid:      ${amountPaid.toStringAsFixed(2)}');
    if (change > 0) {
      buffer.writeln('Change:    ${change.toStringAsFixed(2)}');
    }
    buffer.writeln();
    buffer.writeln('=====================================');
    buffer.writeln('       Thank you for dining!        ');
    buffer.writeln('=====================================');

    return buffer.toString();
  }

  double _calculateSubtotal(Order order) {
    return order.items.fold(
      0.0,
      (total, item) => total + (item.quantity * item.priceAtTime),
    );
  }

  double _calculateTax(Order order) {
    final subtotal = _calculateSubtotal(order);
    return subtotal * 0.1; // 10% tax rate
  }

  void _stopAutoRefresh() {
    _autoRefreshTimer?.cancel();
    _autoRefreshTimer = null;
  }

  @override
  Future<void> close() {
    _stopAutoRefresh();
    return super.close();
  }
}
