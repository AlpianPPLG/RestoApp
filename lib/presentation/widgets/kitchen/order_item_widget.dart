import 'package:flutter/material.dart';
import 'package:restoapp/core/theme/app_colors.dart';
import 'package:restoapp/core/theme/app_spacing.dart';
import 'package:restoapp/domain/entities/enums.dart';
import 'package:restoapp/domain/entities/order_item.dart';

class OrderItemWidget extends StatelessWidget {
  final OrderItem item;
  final Function(int orderItemId, OrderItemStatus status) onStatusUpdate;

  const OrderItemWidget({
    super.key,
    required this.item,
    required this.onStatusUpdate,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: _getStatusBackgroundColor(),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _getStatusColor().withOpacity(0.3), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Item Header
          Row(
            children: [
              // Quantity Badge
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    '${item.quantity}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: AppSpacing.sm),

              // Item Name
              Expanded(
                child: Text(
                  item.menuName ?? 'Unknown Menu',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              // Status Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatusColor(),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _getStatusText(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          // Special Notes
          if (item.specialNotes != null && item.specialNotes!.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.xs),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  Icon(Icons.note, size: 14, color: Colors.grey.shade600),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      item.specialNotes!,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.grey.shade700,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],

          // Action Buttons
          if (item.status != OrderItemStatus.served) ...[
            const SizedBox(height: AppSpacing.sm),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: _buildActionButtons(),
            ),
          ],
        ],
      ),
    );
  }

  List<Widget> _buildActionButtons() {
    switch (item.status) {
      case OrderItemStatus.pending:
        return [
          _buildStatusButton(
            label: 'Start',
            icon: Icons.play_arrow,
            color: AppColors.primary,
            status: OrderItemStatus.cooking,
          ),
        ];

      case OrderItemStatus.cooking:
        return [
          _buildStatusButton(
            label: 'Ready',
            icon: Icons.check,
            color: AppColors.success,
            status: OrderItemStatus.served,
          ),
        ];

      case OrderItemStatus.served:
        return [];
    }
  }

  Widget _buildStatusButton({
    required String label,
    required IconData icon,
    required Color color,
    required OrderItemStatus status,
  }) {
    return GestureDetector(
      onTap: () => onStatusUpdate(item.id, status),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: Colors.white),
            const SizedBox(width: 4),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor() {
    switch (item.status) {
      case OrderItemStatus.pending:
        return AppColors.warning;
      case OrderItemStatus.cooking:
        return AppColors.primary;
      case OrderItemStatus.served:
        return AppColors.success;
    }
  }

  Color _getStatusBackgroundColor() {
    switch (item.status) {
      case OrderItemStatus.pending:
        return AppColors.warning.withOpacity(0.1);
      case OrderItemStatus.cooking:
        return AppColors.primary.withOpacity(0.1);
      case OrderItemStatus.served:
        return AppColors.success.withOpacity(0.1);
    }
  }

  String _getStatusText() {
    switch (item.status) {
      case OrderItemStatus.pending:
        return 'Pending';
      case OrderItemStatus.cooking:
        return 'Cooking';
      case OrderItemStatus.served:
        return 'Ready';
    }
  }
}
