import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restoapp/core/di/injection.dart';
import 'package:restoapp/core/theme/app_colors.dart';
import 'package:restoapp/core/theme/app_spacing.dart';
import 'package:restoapp/presentation/blocs/cashier/cashier_bloc.dart';
import 'package:restoapp/presentation/widgets/cashier/cashier_stats_bar.dart';
import 'package:restoapp/presentation/widgets/cashier/ready_orders_list.dart';
import 'package:restoapp/presentation/widgets/cashier/payment_section.dart';
import 'package:restoapp/presentation/widgets/cashier/receipt_actions_widget.dart';
import 'package:restoapp/presentation/widgets/cashier/transaction_history_dialog.dart';

class CashierDashboardPage extends StatelessWidget {
  const CashierDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CashierBloc>()
        ..add(const CashierLoadReadyOrders())
        ..add(const CashierStartAutoRefresh()),
      child: const _CashierDashboardView(),
    );
  }
}

class _CashierDashboardView extends StatelessWidget {
  const _CashierDashboardView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text(
          'Cashier POS',
          style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              context.read<CashierBloc>().add(const CashierRefresh());
            },
            icon: const Icon(Icons.refresh, color: Colors.white),
            tooltip: 'Refresh Orders',
          ),
          IconButton(
            onPressed: () {
              // Navigate to transaction history
              _showTransactionHistory(context);
            },
            icon: const Icon(Icons.history, color: Colors.white),
            tooltip: 'Transaction History',
          ),
          IconButton(
            onPressed: () {
              // Clear selection
              context.read<CashierBloc>().add(const CashierClearSelection());
            },
            icon: const Icon(Icons.clear_all, color: Colors.white),
            tooltip: 'Clear Selection',
          ),
          const SizedBox(width: AppSpacing.sm),
        ],
      ),
      body: BlocConsumer<CashierBloc, CashierState>(
        listener: (context, state) {
          if (state is CashierPaymentCompleted) {
            _showPaymentSuccessDialog(context, state);
          }
        },
        builder: (context, state) {
          if (state is CashierLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          if (state is CashierError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red.shade400,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    state.message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  ElevatedButton(
                    onPressed: () {
                      context.read<CashierBloc>().add(
                        const CashierLoadReadyOrders(),
                      );
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is CashierLoaded) {
            return CustomScrollView(
              slivers: [
                // Stats Bar
                SliverToBoxAdapter(
                  child: Container(
                    color: Colors.white,
                    child: CashierStatsBar(
                      totalReadyOrders: state.totalReadyOrders,
                      totalPendingRevenue: state.totalPendingRevenue,
                      lastUpdated: state.lastUpdated,
                    ),
                  ),
                ),

                // Error Message (if any)
                if (state.error != null)
                  SliverToBoxAdapter(
                    child: Container(
                      margin: const EdgeInsets.all(AppSpacing.md),
                      padding: const EdgeInsets.all(AppSpacing.sm),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.red.shade200),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.error_outline, color: Colors.red.shade600),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: Text(
                              state.error!,
                              style: TextStyle(color: Colors.red.shade700),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              context.read<CashierBloc>().add(
                                const CashierRefresh(),
                              );
                            },
                            icon: Icon(
                              Icons.refresh,
                              color: Colors.red.shade600,
                            ),
                            iconSize: 20,
                          ),
                        ],
                      ),
                    ),
                  ),

                // Main Content
                if (state.readyOrders.isEmpty)
                  const SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.receipt_long_outlined,
                            size: 64,
                            color: Colors.grey,
                          ),
                          SizedBox(height: AppSpacing.md),
                          Text(
                            'No orders ready for payment',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: AppSpacing.sm),
                          Text(
                            'Orders will appear here when they are ready',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  )
                else ...[
                  // Content Layout
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Ready Orders List (Left Side)
                          Expanded(
                            flex: state.hasSelectedOrder ? 1 : 2,
                            child: ReadyOrdersList(
                              orders: state.readyOrders,
                              selectedOrderId: state.selectedOrder?.id,
                              onOrderSelect: (orderId) {
                                context.read<CashierBloc>().add(
                                  CashierSelectOrder(orderId: orderId),
                                );
                              },
                            ),
                          ),

                          // Payment Section (Right Side)
                          if (state.hasSelectedOrder) ...[
                            const SizedBox(width: AppSpacing.md),
                            Expanded(
                              flex: 1,
                              child: PaymentSection(
                                order: state.selectedOrder!,
                                onProcessPayment:
                                    (paymentMethod, amountPaid, notes) {
                                      context.read<CashierBloc>().add(
                                        CashierProcessPayment(
                                          orderId: state.selectedOrder!.id,
                                          paymentMethod: paymentMethod,
                                          amountPaid: amountPaid,
                                          notes: notes,
                                        ),
                                      );
                                    },
                                onCancel: () {
                                  context.read<CashierBloc>().add(
                                    const CashierClearSelection(),
                                  );
                                },
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            );
          }

          if (state is CashierProcessingPayment) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: AppSpacing.md),
                  Text(
                    'Processing payment...',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  void _showPaymentSuccessDialog(
    BuildContext context,
    CashierPaymentCompleted state,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.check_circle, color: AppColors.success, size: 28),
            SizedBox(width: AppSpacing.sm),
            Text('Payment Successful'),
          ],
        ),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Payment Summary
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order #${state.order.id}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text('Payment Method: ${state.paymentMethod.displayName}'),
                    Text(
                      'Total Amount: \$${state.order.totalAmount.toStringAsFixed(2)}',
                    ),
                    Text(
                      'Amount Paid: \$${state.amountPaid.toStringAsFixed(2)}',
                    ),
                    if (state.change > 0)
                      Text(
                        'Change: \$${state.change.toStringAsFixed(2)}',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.md),

              // Receipt Actions
              ReceiptActionsWidget(
                order: state.order,
                paymentMethod: state.paymentMethod,
                amountPaid: state.amountPaid,
                change: state.change,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              context.read<CashierBloc>().add(const CashierLoadReadyOrders());
            },
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showTransactionHistory(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => BlocProvider.value(
        value: context.read<CashierBloc>(),
        child: const TransactionHistoryDialog(),
      ),
    );
  }
}
