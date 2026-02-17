import 'package:flutter/material.dart';
import 'package:restoapp/core/theme/app_colors.dart';
import 'package:restoapp/core/theme/app_spacing.dart';

class CashierStatsBar extends StatelessWidget {
  final int totalReadyOrders;
  final double totalPendingRevenue;
  final DateTime lastUpdated;

  const CashierStatsBar({
    super.key,
    required this.totalReadyOrders,
    required this.totalPendingRevenue,
    required this.lastUpdated,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey, width: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title and Last Updated
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Payment Overview',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade800,
                ),
              ),
              Text(
                'Updated: ${_formatLastUpdated()}',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.md),

          // Stats Cards
          Row(
            children: [
              // Ready Orders Card
              Expanded(
                child: _StatCard(
                  icon: Icons.receipt_long,
                  iconColor: AppColors.warning,
                  title: 'Ready Orders',
                  value: totalReadyOrders.toString(),
                  subtitle: totalReadyOrders == 1
                      ? 'order awaiting payment'
                      : 'orders awaiting payment',
                ),
              ),

              const SizedBox(width: AppSpacing.md),

              // Pending Revenue Card
              Expanded(
                child: _StatCard(
                  icon: Icons.attach_money,
                  iconColor: AppColors.success,
                  title: 'Pending Revenue',
                  value: '\$${totalPendingRevenue.toStringAsFixed(2)}',
                  subtitle: 'total amount to collect',
                ),
              ),

              const SizedBox(width: AppSpacing.md),

              // Average Order Value Card
              Expanded(
                child: _StatCard(
                  icon: Icons.trending_up,
                  iconColor: AppColors.primary,
                  title: 'Avg Order Value',
                  value: totalReadyOrders > 0
                      ? '\$${(totalPendingRevenue / totalReadyOrders).toStringAsFixed(2)}'
                      : '\$0.00',
                  subtitle: 'average per order',
                ),
              ),

              const SizedBox(width: AppSpacing.md),

              // Quick Action Button
              Container(
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: totalReadyOrders > 0
                        ? () {
                            // Quick process first order
                            // This could trigger a callback to parent
                          }
                        : null,
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.sm),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.payment, color: Colors.white, size: 24),
                          const SizedBox(height: 4),
                          Text(
                            'Quick\nPayment',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatLastUpdated() {
    final now = DateTime.now();
    final difference = now.difference(lastUpdated);

    if (difference.inSeconds < 60) {
      return 'just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${lastUpdated.day}/${lastUpdated.month} ${lastUpdated.hour}:${lastUpdated.minute.toString().padLeft(2, '0')}';
    }
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String value;
  final String subtitle;

  const _StatCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.value,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 80,
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200, width: 1),
      ),
      child: Row(
        children: [
          // Icon
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: iconColor, size: 18),
          ),

          const SizedBox(width: AppSpacing.sm),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Colors.grey.shade800,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  subtitle,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.grey.shade500,
                    fontSize: 10,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
