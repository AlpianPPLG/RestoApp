import 'dart:io';
import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:restoapp/domain/entities/order.dart';
import 'package:restoapp/domain/entities/enums.dart';
import 'package:intl/intl.dart';
import 'package:injectable/injectable.dart' hide Order;

@injectable
class PdfReceiptService {
  /// Generate PDF receipt for an order
  Future<Uint8List> generatePdfReceipt({
    required Order order,
    required PaymentMethod paymentMethod,
    required double amountPaid,
    required double change,
  }) async {
    final pdf = pw.Document();

    // Calculate totals
    final subtotal = _calculateSubtotal(order);
    final tax = _calculateTax(order);
    final total = order.totalAmount;

    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header
              pw.Center(
                child: pw.Column(
                  children: [
                    pw.Text(
                      'RestoApp',
                      style: pw.TextStyle(
                        fontSize: 28,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 8),
                    pw.Text(
                      'Restaurant Management System',
                      style: pw.TextStyle(
                        fontSize: 14,
                        fontStyle: pw.FontStyle.italic,
                      ),
                    ),
                    pw.SizedBox(height: 4),
                    pw.Text(
                      'Jl. Contoh No. 123, Jakarta',
                      style: const pw.TextStyle(fontSize: 12),
                    ),
                    pw.Text(
                      'Tel: (021) 1234-5678',
                      style: const pw.TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),

              pw.SizedBox(height: 32),

              // Receipt Info
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'Receipt #${order.id}',
                        style: pw.TextStyle(
                          fontSize: 16,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(height: 4),
                      pw.Text(
                        'Table: ${order.tableId}',
                        style: const pw.TextStyle(fontSize: 12),
                      ),
                      if (order.customerName?.isNotEmpty == true)
                        pw.Text(
                          'Customer: ${order.customerName}',
                          style: const pw.TextStyle(fontSize: 12),
                        ),
                    ],
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text(
                        dateFormat.format(order.createdAt ?? DateTime.now()),
                        style: const pw.TextStyle(fontSize: 12),
                      ),
                      pw.SizedBox(height: 4),
                      pw.Text(
                        'Cashier: ${order.waiterName ?? 'System'}',
                        style: const pw.TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),

              pw.SizedBox(height: 24),

              // Items header
              pw.Container(
                padding: const pw.EdgeInsets.symmetric(vertical: 8),
                decoration: const pw.BoxDecoration(
                  border: pw.Border(bottom: pw.BorderSide(width: 1)),
                ),
                child: pw.Row(
                  children: [
                    pw.Expanded(
                      flex: 3,
                      child: pw.Text(
                        'Item',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Text(
                        'Qty',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        textAlign: pw.TextAlign.center,
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Text(
                        'Price',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        textAlign: pw.TextAlign.right,
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Text(
                        'Total',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        textAlign: pw.TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ),

              // Items
              ...order.items.map((item) {
                final itemTotal = item.quantity * item.priceAtTime;
                return pw.Container(
                  padding: const pw.EdgeInsets.symmetric(vertical: 4),
                  child: pw.Row(
                    children: [
                      pw.Expanded(
                        flex: 3,
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              item.menuName ?? 'Unknown Item',
                              style: const pw.TextStyle(fontSize: 12),
                            ),
                            if (item.specialNotes?.isNotEmpty == true)
                              pw.Padding(
                                padding: const pw.EdgeInsets.only(top: 2),
                                child: pw.Text(
                                  'Note: ${item.specialNotes}',
                                  style: pw.TextStyle(
                                    fontSize: 10,
                                    fontStyle: pw.FontStyle.italic,
                                    color: PdfColors.grey700,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      pw.Expanded(
                        child: pw.Text(
                          '${item.quantity}',
                          style: const pw.TextStyle(fontSize: 12),
                          textAlign: pw.TextAlign.center,
                        ),
                      ),
                      pw.Expanded(
                        child: pw.Text(
                          '\$${item.priceAtTime.toStringAsFixed(2)}',
                          style: const pw.TextStyle(fontSize: 12),
                          textAlign: pw.TextAlign.right,
                        ),
                      ),
                      pw.Expanded(
                        child: pw.Text(
                          '\$${itemTotal.toStringAsFixed(2)}',
                          style: const pw.TextStyle(fontSize: 12),
                          textAlign: pw.TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                );
              }),

              pw.SizedBox(height: 16),

              // Totals
              pw.Container(
                decoration: const pw.BoxDecoration(
                  border: pw.Border(top: pw.BorderSide(width: 1)),
                ),
                child: pw.Column(
                  children: [
                    pw.SizedBox(height: 8),
                    _buildTotalRow(
                      'Subtotal:',
                      '\$${subtotal.toStringAsFixed(2)}',
                    ),
                    _buildTotalRow('Tax (10%):', '\$${tax.toStringAsFixed(2)}'),
                    pw.Container(
                      margin: const pw.EdgeInsets.symmetric(vertical: 8),
                      padding: const pw.EdgeInsets.symmetric(vertical: 8),
                      decoration: const pw.BoxDecoration(
                        border: pw.Border(
                          top: pw.BorderSide(width: 2),
                          bottom: pw.BorderSide(width: 2),
                        ),
                      ),
                      child: _buildTotalRow(
                        'Total:',
                        '\$${total.toStringAsFixed(2)}',
                        isTotal: true,
                      ),
                    ),
                  ],
                ),
              ),

              pw.SizedBox(height: 16),

              // Payment Info
              pw.Container(
                padding: const pw.EdgeInsets.all(16),
                decoration: pw.BoxDecoration(
                  color: PdfColors.grey100,
                  borderRadius: pw.BorderRadius.circular(8),
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'Payment Information',
                      style: pw.TextStyle(
                        fontSize: 14,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 8),
                    _buildPaymentRow(
                      'Payment Method:',
                      _getPaymentMethodDisplay(paymentMethod),
                    ),
                    _buildPaymentRow(
                      'Amount Paid:',
                      '\$${amountPaid.toStringAsFixed(2)}',
                    ),
                    if (change > 0)
                      _buildPaymentRow(
                        'Change:',
                        '\$${change.toStringAsFixed(2)}',
                      ),
                  ],
                ),
              ),

              pw.Spacer(),

              // Footer
              pw.Center(
                child: pw.Column(
                  children: [
                    pw.Text(
                      'Thank you for dining with us!',
                      style: pw.TextStyle(
                        fontSize: 16,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 8),
                    pw.Text(
                      'Visit us again soon',
                      style: const pw.TextStyle(fontSize: 12),
                    ),
                    pw.SizedBox(height: 16),
                    pw.Text(
                      '* This is a computer-generated receipt *',
                      style: pw.TextStyle(
                        fontSize: 10,
                        fontStyle: pw.FontStyle.italic,
                        color: PdfColors.grey600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );

    return await pdf.save();
  }

  /// Generate thermal printer format receipt (58mm)
  Future<String> generateThermalReceipt({
    required Order order,
    required PaymentMethod paymentMethod,
    required double amountPaid,
    required double change,
  }) async {
    final buffer = StringBuffer();
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');

    // Calculate totals
    final subtotal = _calculateSubtotal(order);
    final tax = _calculateTax(order);

    // Header (centered)
    buffer.writeln(_centerText('RestoApp', 32));
    buffer.writeln(_centerText('Restaurant Management', 32));
    buffer.writeln(_centerText('Jl. Contoh No. 123, Jakarta', 32));
    buffer.writeln(_centerText('Tel: (021) 1234-5678', 32));
    buffer.writeln('================================');
    buffer.writeln();

    // Order info
    buffer.writeln('Receipt #: ${order.id}');
    buffer.writeln('Table: ${order.tableId}');
    if (order.customerName?.isNotEmpty == true) {
      buffer.writeln('Customer: ${order.customerName}');
    }
    buffer.writeln(
      'Date: ${dateFormat.format(order.createdAt ?? DateTime.now())}',
    );
    buffer.writeln('Cashier: ${order.waiterName ?? 'System'}');
    buffer.writeln('================================');
    buffer.writeln();

    // Items
    for (final item in order.items) {
      buffer.writeln('${item.menuName ?? 'Unknown Item'}');
      final itemTotal = item.quantity * item.priceAtTime;
      buffer.writeln(
        '${item.quantity} x \$${item.priceAtTime.toStringAsFixed(2)} = \$${itemTotal.toStringAsFixed(2)}',
      );

      if (item.specialNotes?.isNotEmpty == true) {
        buffer.writeln('Note: ${item.specialNotes}');
      }
      buffer.writeln();
    }

    buffer.writeln('================================');
    buffer.writeln(
      _formatLine('Subtotal:', '\$${subtotal.toStringAsFixed(2)}'),
    );
    buffer.writeln(_formatLine('Tax (10%):', '\$${tax.toStringAsFixed(2)}'));
    buffer.writeln('================================');
    buffer.writeln(
      _formatLine('TOTAL:', '\$${order.totalAmount.toStringAsFixed(2)}'),
    );
    buffer.writeln('================================');
    buffer.writeln();

    // Payment info
    buffer.writeln(
      'Payment Method: ${_getPaymentMethodDisplay(paymentMethod)}',
    );
    buffer.writeln('Amount Paid: \$${amountPaid.toStringAsFixed(2)}');
    if (change > 0) {
      buffer.writeln('Change: \$${change.toStringAsFixed(2)}');
    }
    buffer.writeln();

    // Footer
    buffer.writeln(_centerText('Thank you for dining!', 32));
    buffer.writeln(_centerText('Visit us again soon', 32));
    buffer.writeln('================================');
    buffer.writeln();
    buffer.writeln();
    buffer.writeln();

    return buffer.toString();
  }

  /// Save PDF to device storage
  Future<String> savePdfToDevice(Uint8List pdfBytes, String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$fileName.pdf');
    await file.writeAsBytes(pdfBytes);
    return file.path;
  }

  // Helper methods
  pw.Widget _buildTotalRow(String label, String value, {bool isTotal = false}) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(
          label,
          style: pw.TextStyle(
            fontSize: isTotal ? 14 : 12,
            fontWeight: isTotal ? pw.FontWeight.bold : pw.FontWeight.normal,
          ),
        ),
        pw.Text(
          value,
          style: pw.TextStyle(
            fontSize: isTotal ? 14 : 12,
            fontWeight: isTotal ? pw.FontWeight.bold : pw.FontWeight.normal,
          ),
        ),
      ],
    );
  }

  pw.Widget _buildPaymentRow(String label, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 2),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(label, style: const pw.TextStyle(fontSize: 12)),
          pw.Text(value, style: const pw.TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  String _centerText(String text, int width) {
    if (text.length >= width) return text;
    final padding = (width - text.length) ~/ 2;
    return ' ' * padding + text + ' ' * padding;
  }

  String _formatLine(String label, String value) {
    const totalWidth = 32;
    final valueLength = value.length;
    final labelLength = label.length;
    final dotsLength = totalWidth - labelLength - valueLength;
    final dots = '.' * (dotsLength > 0 ? dotsLength : 1);
    return '$label$dots$value';
  }

  String _getPaymentMethodDisplay(PaymentMethod method) {
    switch (method) {
      case PaymentMethod.cash:
        return 'Cash';
      case PaymentMethod.qris:
        return 'QRIS';
      case PaymentMethod.debit:
        return 'Debit Card';
    }
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
}
