import 'package:flutter/material.dart';
import 'package:restoapp/core/theme/app_spacing.dart';
import 'package:restoapp/domain/entities/enums.dart';
import 'package:restoapp/domain/entities/order.dart';
import 'package:restoapp/presentation/widgets/kitchen/kitchen_order_card.dart';

class OrderQueueWidget extends StatelessWidget {
  final List<Order> orders;
  final List<Order> lateOrders;
  final Function(int orderId, OrderStatus status) onStatusUpdate;
  final Function(int orderItemId, OrderItemStatus status) onItemStatusUpdate;

  const OrderQueueWidget({
    super.key,
    required this.orders,
    required this.lateOrders,
    required this.onStatusUpdate,
    required this.onItemStatusUpdate,
  });

  @override
  Widget build(BuildContext context) {
    // Sort orders by priority: late orders first, then by creation time
    final sortedOrders = List<Order>.from(orders);
    sortedOrders.sort((a, b) {
      // Late orders first
      final aIsLate = lateOrders.contains(a);
      final bIsLate = lateOrders.contains(b);

      if (aIsLate && !bIsLate) return -1;
      if (!aIsLate && bIsLate) return 1;

      // Then by status priority (pending > processing > delivered)
      final statusPriority = {
        OrderStatus.pending: 3,
        OrderStatus.processing: 2,
        OrderStatus.delivered: 1,
        OrderStatus.completed: 0,
        OrderStatus.cancelled: -1,
      };

      final aPriority = statusPriority[a.status] ?? 0;
      final bPriority = statusPriority[b.status] ?? 0;

      if (aPriority != bPriority) {
        return bPriority.compareTo(aPriority);
      }

      // Finally by creation time (oldest first)
      if (a.createdAt != null && b.createdAt != null) {
        return a.createdAt!.compareTo(b.createdAt!);
      }

      return 0;
    });

    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final order = sortedOrders[index];
        final isLate = lateOrders.contains(order);

        return Padding(
          padding: EdgeInsets.only(
            bottom: index < sortedOrders.length - 1 ? AppSpacing.md : 0,
          ),
          child: KitchenOrderCard(
            order: order,
            isLate: isLate,
            onStatusUpdate: onStatusUpdate,
            onItemStatusUpdate: onItemStatusUpdate,
          ),
        );
      }, childCount: sortedOrders.length),
    );
  }
}
