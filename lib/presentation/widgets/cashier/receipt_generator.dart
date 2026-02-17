import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restoapp/core/theme/app_spacing.dart';
import 'package:restoapp/domain/entities/order.dart';
import 'package:restoapp/domain/entities/enums.dart';

class ReceiptGenerator extends StatelessWidget {
  final Order order;
  final PaymentMethod paymentMethod;
  final double amountPaid;
  final double change;
  final bool isDialog;

  const ReceiptGenerator({
    super.key,
    required this.order,
    required this.paymentMethod,
    required this.amountPaid,
    required this.change,
    this.isDialog = true,
  });

  @override
  Widget build(BuildContext context) {
    return isDialog ? _buildReceiptDialog(context) : _buildReceiptView(context);
  }

  Widget _buildReceiptDialog(BuildContext context) {
    return Dialog(
      child: Container(
        width: 400,
        constraints: const BoxConstraints(maxHeight: 600),
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(4),
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.receipt_long, color: Colors.white),
                  const SizedBox(width: AppSpacing.sm),
                  const Text(
                    'Receipt Preview',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close, color: Colors.white),
                  ),
                ],
              ),
            ),

            // Receipt Content
            Expanded(
              child: SingleChildScrollView(child: _buildReceiptView(context)),
            ),

            // Action Buttons
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey, width: 0.2)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.close),
                      label: const Text('Close'),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _printReceipt(context);
                      },
                      icon: const Icon(Icons.print),
                      label: const Text('Print'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReceiptView(BuildContext context) {
    const textStyle = TextStyle(
      fontFamily: 'monospace',
      fontSize: 12,
      height: 1.4,
    );

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Restaurant Header
          const Text('=====================================', style: textStyle),
          const SizedBox(height: 4),
          const Text(
            'RESTOAPP RESTAURANT',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              height: 1.4,
            ),
          ),
          const Text('Thank you for dining with us!', style: textStyle),
          const Text('=====================================', style: textStyle),
          const SizedBox(height: AppSpacing.md),

          // Order Information
          _ReceiptRow('Order #:', '${order.id}'),
          _ReceiptRow('Table:', '${order.tableNumber ?? order.tableId}'),
          _ReceiptRow('Date:', _formatDateTime(DateTime.now())),
          _ReceiptRow('Cashier:', 'Staff'),
          if (order.waiterName != null)
            _ReceiptRow('Waiter:', order.waiterName!),

          const SizedBox(height: AppSpacing.sm),
          const Center(
            child: Text(
              '=====================================',
              style: textStyle,
            ),
          ),
          const Center(
            child: Text(
              'ITEMS:',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                fontWeight: FontWeight.bold,
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(height: 4),

          // Order Items
          ...order.items.map(
            (item) => Column(
              children: [
                _ReceiptRow(
                  '${item.quantity}x ${_truncateText(item.menuName ?? 'Unknown', 25)}',
                  '',
                ),
                _ReceiptRow(
                  '    @\$${item.priceAtTime.toStringAsFixed(2)}',
                  '\$${(item.quantity * item.priceAtTime).toStringAsFixed(2)}',
                ),
                if (item.specialNotes != null && item.specialNotes!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      'Note: ${item.specialNotes}',
                      style: textStyle.copyWith(
                        fontStyle: FontStyle.italic,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                const SizedBox(height: 4),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.sm),
          const Center(
            child: Text(
              '=====================================',
              style: textStyle,
            ),
          ),

          // Totals
          _ReceiptRow(
            'Subtotal:',
            '\$${ReceiptGenerator._calculateSubtotal(order).toStringAsFixed(2)}',
          ),
          _ReceiptRow(
            'Tax:',
            '\$${ReceiptGenerator._calculateTax(order).toStringAsFixed(2)}',
          ),
          const Center(
            child: Text(
              '-------------------------------------',
              style: textStyle,
            ),
          ),
          _ReceiptRow(
            'TOTAL:',
            '\$${order.totalAmount.toStringAsFixed(2)}',
            isBold: true,
          ),

          const SizedBox(height: AppSpacing.sm),

          // Payment Information
          _ReceiptRow('Payment:', paymentMethod.displayName),
          _ReceiptRow('Amount Paid:', '\$${amountPaid.toStringAsFixed(2)}'),
          if (change > 0)
            _ReceiptRow('Change:', '\$${change.toStringAsFixed(2)}'),

          const SizedBox(height: AppSpacing.md),
          const Center(
            child: Text(
              '=====================================',
              style: textStyle,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),

          // Footer
          const Center(
            child: Text(
              'Thank you for your visit!',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                fontWeight: FontWeight.bold,
                height: 1.4,
              ),
            ),
          ),
          const Center(child: Text('Please come again!', style: textStyle)),
          const SizedBox(height: AppSpacing.sm),
          const Center(
            child: Text(
              '=====================================',
              style: textStyle,
            ),
          ),

          // QR Code placeholder (in a real app, this would be an actual QR code)
          const SizedBox(height: AppSpacing.sm),
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: const Center(
              child: Text(
                'QR',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ),
          const SizedBox(height: 4),
          const Center(
            child: Text(
              'Scan for Review',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  void _printReceipt(BuildContext context) {
    // In a real app, this would integrate with a thermal printer
    // For now, we'll just show a success message
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 8),
            Text('Receipt printed successfully'),
          ],
        ),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day.toString().padLeft(2, '0')}/'
        '${dateTime.month.toString().padLeft(2, '0')}/'
        '${dateTime.year} ${dateTime.hour.toString().padLeft(2, '0')}:'
        '${dateTime.minute.toString().padLeft(2, '0')}';
  }

  String _truncateText(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength - 3)}...';
  }

  /// Calculate subtotal from order items
  static double _calculateSubtotal(Order order) {
    return order.items.fold(
      0.0,
      (total, item) => total + (item.quantity * item.priceAtTime),
    );
  }

  /// Calculate tax from order subtotal (10% tax rate)
  static double _calculateTax(Order order) {
    final subtotal = _calculateSubtotal(order);
    return subtotal * 0.1; // 10% tax rate
  }

  /// Static method to show receipt dialog
  static Future<void> showReceiptDialog(
    BuildContext context, {
    required Order order,
    required PaymentMethod paymentMethod,
    required double amountPaid,
    required double change,
  }) {
    return showDialog<void>(
      context: context,
      builder: (context) => ReceiptGenerator(
        order: order,
        paymentMethod: paymentMethod,
        amountPaid: amountPaid,
        change: change,
        isDialog: true,
      ),
    );
  }

  /// Static method to generate receipt text
  static String generateReceiptText({
    required Order order,
    required PaymentMethod paymentMethod,
    required double amountPaid,
    required double change,
  }) {
    final buffer = StringBuffer();

    buffer.writeln('=====================================');
    buffer.writeln('           RESTOAPP RECEIPT          ');
    buffer.writeln('=====================================');
    buffer.writeln();
    buffer.writeln('Order #: ${order.id}');
    buffer.writeln('Table: ${order.tableNumber ?? order.tableId}');
    buffer.writeln('Date: ${DateTime.now().toString().split('.')[0]}');
    buffer.writeln('Cashier: Staff');
    if (order.waiterName != null) {
      buffer.writeln('Waiter: ${order.waiterName}');
    }
    buffer.writeln();
    buffer.writeln('=====================================');
    buffer.writeln('Items:');

    for (final item in order.items) {
      buffer.writeln('${item.quantity}x ${item.menuName ?? 'Unknown Item'}');
      buffer.writeln(
        '    @\$${item.priceAtTime.toStringAsFixed(2)} = \$${(item.quantity * item.priceAtTime).toStringAsFixed(2)}',
      );
      if (item.specialNotes != null && item.specialNotes!.isNotEmpty) {
        buffer.writeln('    Note: ${item.specialNotes}');
      }
    }

    buffer.writeln('=====================================');
    buffer.writeln(
      'Subtotal:  \$${_calculateSubtotal(order).toStringAsFixed(2)}',
    );
    buffer.writeln('Tax:       \$${_calculateTax(order).toStringAsFixed(2)}');
    buffer.writeln('Total:     \$${order.totalAmount.toStringAsFixed(2)}');
    buffer.writeln();
    buffer.writeln('Payment:   ${paymentMethod.displayName}');
    buffer.writeln('Paid:      \$${amountPaid.toStringAsFixed(2)}');
    if (change > 0) {
      buffer.writeln('Change:    \$${change.toStringAsFixed(2)}');
    }
    buffer.writeln();
    buffer.writeln('=====================================');
    buffer.writeln('       Thank you for dining!        ');
    buffer.writeln('=====================================');

    return buffer.toString();
  }
}

class _ReceiptRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;

  const _ReceiptRow(this.label, this.value, {this.isBold = false});

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      fontFamily: 'monospace',
      fontSize: 12,
      height: 1.4,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: isBold
                  ? textStyle.copyWith(fontWeight: FontWeight.bold)
                  : textStyle,
            ),
          ),
          Text(
            value,
            style: isBold
                ? textStyle.copyWith(fontWeight: FontWeight.bold)
                : textStyle,
          ),
        ],
      ),
    );
  }
}
