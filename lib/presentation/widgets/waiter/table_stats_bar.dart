import 'package:flutter/material.dart';
import 'package:restoapp/core/theme/app_colors.dart';
import 'package:restoapp/core/theme/app_spacing.dart';

class TableStatsBar extends StatelessWidget {
  final int availableTables;
  final int occupiedTables;
  final int reservedTables;
  final DateTime lastUpdated;

  const TableStatsBar({
    super.key,
    required this.availableTables,
    required this.occupiedTables,
    required this.reservedTables,
    required this.lastUpdated,
  });

  @override
  Widget build(BuildContext context) {
    final totalTables = availableTables + occupiedTables + reservedTables;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Title and Last Updated
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Table Overview',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
              Text(
                'Updated ${_formatLastUpdated()}',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.grey.shade600),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.md),

          // Stats Row
          Row(
            children: [
              Expanded(
                child: _StatItem(
                  icon: Icons.check_circle,
                  color: AppColors.success,
                  label: 'Available',
                  count: availableTables,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: _StatItem(
                  icon: Icons.table_restaurant,
                  color: AppColors.warning,
                  label: 'Occupied',
                  count: occupiedTables,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: _StatItem(
                  icon: Icons.schedule,
                  color: AppColors.info,
                  label: 'Reserved',
                  count: reservedTables,
                ),
              ),
            ],
          ),

          if (totalTables > 0) ...[
            const SizedBox(height: AppSpacing.md),

            // Progress Bar
            Container(
              height: 6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: Colors.grey.shade200,
              ),
              child: Row(
                children: [
                  if (availableTables > 0)
                    Expanded(
                      flex: availableTables,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: AppColors.success,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(3),
                            bottomLeft: Radius.circular(3),
                          ),
                        ),
                      ),
                    ),
                  if (occupiedTables > 0)
                    Expanded(
                      flex: occupiedTables,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.warning,
                          borderRadius: occupiedTables == totalTables
                              ? BorderRadius.circular(3)
                              : BorderRadius.zero,
                        ),
                      ),
                    ),
                  if (reservedTables > 0)
                    Expanded(
                      flex: reservedTables,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: AppColors.info,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(3),
                            bottomRight: Radius.circular(3),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _formatLastUpdated() {
    final now = DateTime.now();
    final difference = now.difference(lastUpdated);

    if (difference.inSeconds < 30) {
      return 'now';
    } else if (difference.inMinutes < 1) {
      return '${difference.inSeconds}s ago';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else {
      return '${lastUpdated.hour}:${lastUpdated.minute.toString().padLeft(2, '0')}';
    }
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final int count;

  const _StatItem({
    required this.icon,
    required this.color,
    required this.label,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.sm,
        horizontal: AppSpacing.xs,
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 16),
          ),
          const SizedBox(height: 4),
          Text(
            count.toString(),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.grey.shade600,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
