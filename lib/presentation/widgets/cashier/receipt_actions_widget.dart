import 'package:flutter/material.dart';
import 'package:restoapp/core/di/injection.dart';
import 'package:restoapp/core/services/pdf_receipt_service.dart';
import 'package:restoapp/core/services/print_share_service.dart';
import 'package:restoapp/core/theme/app_colors.dart';
import 'package:restoapp/core/theme/app_spacing.dart';
import 'package:restoapp/domain/entities/order.dart';
import 'package:restoapp/domain/entities/enums.dart';

class ReceiptActionsWidget extends StatefulWidget {
  final Order order;
  final PaymentMethod paymentMethod;
  final double amountPaid;
  final double change;

  const ReceiptActionsWidget({
    super.key,
    required this.order,
    required this.paymentMethod,
    required this.amountPaid,
    required this.change,
  });

  @override
  State<ReceiptActionsWidget> createState() => _ReceiptActionsWidgetState();
}

class _ReceiptActionsWidgetState extends State<ReceiptActionsWidget> {
  final PdfReceiptService _pdfService = getIt<PdfReceiptService>();
  final PrintShareService _printShareService = getIt<PrintShareService>();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Receipt Actions',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          // PDF Actions Row
          Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  icon: Icons.picture_as_pdf,
                  label: 'PDF',
                  color: Colors.red,
                  onPressed: _isLoading ? null : _generateAndShowPdf,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: _buildActionButton(
                  icon: Icons.print,
                  label: 'Print PDF',
                  color: Colors.blue,
                  onPressed: _isLoading ? null : _printPdf,
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.sm),

          // Thermal & Share Actions Row
          Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  icon: Icons.receipt,
                  label: 'Thermal',
                  color: Colors.green,
                  onPressed: _isLoading ? null : _printThermal,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: _buildActionButton(
                  icon: Icons.share,
                  label: 'Share',
                  color: Colors.indigo,
                  onPressed: _isLoading ? null : _shareReceipt,
                ),
              ),
            ],
          ),

          if (_isLoading) ...[
            const SizedBox(height: AppSpacing.md),
            const LinearProgressIndicator(color: AppColors.primary),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Processing receipt...',
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.grey),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback? onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(
        label,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.sm,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 2,
      ),
    );
  }

  Future<void> _generateAndShowPdf() async {
    setState(() => _isLoading = true);

    try {
      final pdfBytes = await _pdfService.generatePdfReceipt(
        order: widget.order,
        paymentMethod: widget.paymentMethod,
        amountPaid: widget.amountPaid,
        change: widget.change,
      );

      if (mounted) {
        await _printShareService.showPrintPreview(
          pdfBytes,
          'Receipt #${widget.order.id}',
        );
      }
    } catch (e) {
      if (mounted) {
        _showErrorSnackBar('Failed to generate PDF: $e');
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _printPdf() async {
    setState(() => _isLoading = true);

    try {
      final pdfBytes = await _pdfService.generatePdfReceipt(
        order: widget.order,
        paymentMethod: widget.paymentMethod,
        amountPaid: widget.amountPaid,
        change: widget.change,
      );

      final success = await _printShareService.printPdf(pdfBytes);

      if (mounted) {
        if (success) {
          _showSuccessSnackBar('PDF sent to printer successfully');
        } else {
          _showErrorSnackBar('Failed to print PDF');
        }
      }
    } catch (e) {
      if (mounted) {
        _showErrorSnackBar('Failed to print PDF: $e');
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _printThermal() async {
    setState(() => _isLoading = true);

    try {
      final thermalData = await _pdfService.generateThermalReceipt(
        order: widget.order,
        paymentMethod: widget.paymentMethod,
        amountPaid: widget.amountPaid,
        change: widget.change,
      );

      final success = await _printShareService.printThermal(thermalData);

      if (mounted) {
        if (success) {
          _showSuccessSnackBar('Thermal receipt sent to printer');
        } else {
          _showErrorSnackBar('Failed to print thermal receipt');
        }
      }
    } catch (e) {
      if (mounted) {
        _showErrorSnackBar('Failed to print thermal receipt: $e');
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _shareReceipt() async {
    setState(() => _isLoading = true);

    try {
      // Show options for sharing
      await _showShareOptions();
    } catch (e) {
      if (mounted) {
        _showErrorSnackBar('Failed to share receipt: $e');
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _showShareOptions() async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Share Receipt'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('How would you like to share this receipt?'),
            const SizedBox(height: AppSpacing.md),
            ListTile(
              leading: const Icon(Icons.picture_as_pdf, color: Colors.red),
              title: const Text('Share as PDF'),
              onTap: () => Navigator.pop(context, 'pdf'),
            ),
            ListTile(
              leading: const Icon(Icons.receipt, color: Colors.green),
              title: const Text('Share as Text'),
              onTap: () => Navigator.pop(context, 'text'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );

    if (result != null) {
      if (result == 'pdf') {
        await _sharePdfFile();
      } else if (result == 'text') {
        await _shareTextReceipt();
      }
    }
  }

  Future<void> _sharePdfFile() async {
    try {
      final pdfBytes = await _pdfService.generatePdfReceipt(
        order: widget.order,
        paymentMethod: widget.paymentMethod,
        amountPaid: widget.amountPaid,
        change: widget.change,
      );

      final fileName =
          'receipt_${widget.order.id}_${DateTime.now().millisecondsSinceEpoch}';
      final success = await _printShareService.sharePdfFile(pdfBytes, fileName);

      if (mounted) {
        if (success) {
          _showSuccessSnackBar('PDF receipt shared successfully');
        } else {
          _showErrorSnackBar('Failed to share PDF receipt');
        }
      }
    } catch (e) {
      if (mounted) {
        _showErrorSnackBar('Failed to generate PDF for sharing: $e');
      }
    }
  }

  Future<void> _shareTextReceipt() async {
    try {
      final thermalData = await _pdfService.generateThermalReceipt(
        order: widget.order,
        paymentMethod: widget.paymentMethod,
        amountPaid: widget.amountPaid,
        change: widget.change,
      );

      final success = await _printShareService.shareText(thermalData);

      if (mounted) {
        if (success) {
          _showSuccessSnackBar('Text receipt shared successfully');
        } else {
          _showErrorSnackBar('Failed to share text receipt');
        }
      }
    } catch (e) {
      if (mounted) {
        _showErrorSnackBar('Failed to generate text receipt for sharing: $e');
      }
    }
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 4),
      ),
    );
  }
}
