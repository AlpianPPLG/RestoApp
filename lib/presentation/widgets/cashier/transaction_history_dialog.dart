import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restoapp/core/theme/app_colors.dart';
import 'package:restoapp/core/theme/app_spacing.dart';
import 'package:restoapp/presentation/blocs/cashier/cashier_bloc.dart';
import 'package:restoapp/domain/entities/order.dart';
import 'package:restoapp/domain/entities/enums.dart';
import 'package:intl/intl.dart';
import 'package:restoapp/presentation/widgets/cashier/receipt_actions_widget.dart';

class TransactionHistoryDialog extends StatefulWidget {
  const TransactionHistoryDialog({super.key});

  @override
  State<TransactionHistoryDialog> createState() =>
      _TransactionHistoryDialogState();
}

class _TransactionHistoryDialogState extends State<TransactionHistoryDialog> {
  @override
  void initState() {
    super.initState();
    // Load transaction history
    context.read<CashierBloc>().add(const CashierLoadTransactions());
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.8,
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                const Icon(Icons.history, color: AppColors.primary, size: 28),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  'Transaction History',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),

            const Divider(),
            const SizedBox(height: AppSpacing.md),

            // Search and Filter Bar
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search by order ID or table...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.sm,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                ElevatedButton.icon(
                  onPressed: () {
                    context.read<CashierBloc>().add(
                      const CashierLoadTransactions(),
                    );
                  },
                  icon: const Icon(Icons.refresh, size: 18),
                  label: const Text('Refresh'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppSpacing.md),

            // Transaction List
            Expanded(
              child: BlocBuilder<CashierBloc, CashierState>(
                builder: (context, state) {
                  if (state is CashierLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    );
                  }

                  if (state is CashierTransactionsLoaded) {
                    if (state.transactions.isEmpty) {
                      return const Center(
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
                              'No transactions found',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.separated(
                      itemCount: state.transactions.length,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) {
                        final transaction = state.transactions[index];
                        return _buildTransactionTile(transaction);
                      },
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
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          ElevatedButton(
                            onPressed: () {
                              context.read<CashierBloc>().add(
                                const CashierLoadTransactions(),
                              );
                            },
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionTile(Order transaction) {
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');

    return ExpansionTile(
      leading: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: _getStatusColor(transaction.status).withOpacity(0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          _getStatusIcon(transaction.status),
          color: _getStatusColor(transaction.status),
        ),
      ),
      title: Row(
        children: [
          Text(
            'Order #${transaction.id}',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: _getStatusColor(transaction.status).withOpacity(0.2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              transaction.status.displayName,
              style: TextStyle(
                color: _getStatusColor(transaction.status),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Text('Table: ${transaction.tableNumber ?? transaction.tableId}'),
          Text(
            'Date: ${dateFormat.format(transaction.createdAt ?? DateTime.now())}',
          ),
          Text('Total: \$${transaction.totalAmount.toStringAsFixed(2)}'),
          if (transaction.waiterName != null)
            Text('Waiter: ${transaction.waiterName}'),
        ],
      ),
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSpacing.md),
          margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order Items
              Text(
                'Items (${transaction.items.length})',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              ...transaction.items.map(
                (item) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    children: [
                      Text(
                        '${item.quantity}x',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(child: Text(item.menuName ?? 'Unknown Item')),
                      Text(
                        '\$${(item.quantity * item.priceAtTime).toStringAsFixed(2)}',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: AppSpacing.md),

              // Receipt Actions (only for completed orders)
              if (transaction.status == OrderStatus.completed)
                ReceiptActionsWidget(
                  order: transaction,
                  paymentMethod:
                      PaymentMethod.cash, // Default - could be stored in DB
                  amountPaid: transaction.totalAmount,
                  change: 0.0,
                ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
      ],
    );
  }

  Color _getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return Colors.orange;
      case OrderStatus.processing:
        return Colors.blue;
      case OrderStatus.delivered:
        return Colors.green;
      case OrderStatus.completed:
        return AppColors.success;
      case OrderStatus.cancelled:
        return Colors.red;
    }
  }

  IconData _getStatusIcon(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return Icons.access_time;
      case OrderStatus.processing:
        return Icons.restaurant;
      case OrderStatus.delivered:
        return Icons.done_all;
      case OrderStatus.completed:
        return Icons.payment;
      case OrderStatus.cancelled:
        return Icons.cancel;
    }
  }
}
