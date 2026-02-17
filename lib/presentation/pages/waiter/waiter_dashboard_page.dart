import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:restoapp/core/theme/app_colors.dart';
import 'package:restoapp/core/theme/app_spacing.dart';
import 'package:restoapp/core/di/injection.dart';
import 'package:restoapp/domain/entities/enums.dart';
import 'package:restoapp/domain/entities/restaurant_table.dart';
import 'package:restoapp/presentation/blocs/waiter/waiter_table_bloc.dart';
import 'package:restoapp/presentation/widgets/waiter/table_grid_widget.dart';
import 'package:restoapp/presentation/widgets/waiter/table_stats_bar.dart';

class WaiterDashboardPage extends StatelessWidget {
  const WaiterDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<WaiterTableBloc>()
        ..add(const WaiterTableLoadAll())
        ..add(const WaiterTableStartAutoRefresh()),
      child: const _WaiterDashboardView(),
    );
  }
}

class _WaiterDashboardView extends StatelessWidget {
  const _WaiterDashboardView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Selamat Datang,',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
            Text(
              'Waiter Dashboard',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        actions: [
          BlocBuilder<WaiterTableBloc, WaiterTableState>(
            builder: (context, state) {
              return IconButton(
                onPressed: state is WaiterTableLoaded && state.isRefreshing
                    ? null
                    : () {
                        context.read<WaiterTableBloc>().add(
                          const WaiterTableRefresh(),
                        );
                      },
                icon: AnimatedRotation(
                  turns: state is WaiterTableLoaded && state.isRefreshing
                      ? 1.0
                      : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: const Icon(Icons.refresh),
                ),
                tooltip: 'Refresh Tables',
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<WaiterTableBloc>().add(const WaiterTableRefresh());
          // Wait a bit for the refresh to complete
          await Future.delayed(const Duration(milliseconds: 500));
        },
        child: CustomScrollView(
          slivers: [
            // Stats Bar
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: BlocBuilder<WaiterTableBloc, WaiterTableState>(
                  builder: (context, state) {
                    if (state is WaiterTableLoaded) {
                      return TableStatsBar(
                        availableTables: state.availableTables,
                        occupiedTables: state.occupiedTables,
                        reservedTables: state.reservedTables,
                        lastUpdated: state.lastUpdated,
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),

            // Error Banner
            BlocBuilder<WaiterTableBloc, WaiterTableState>(
              builder: (context, state) {
                if (state is WaiterTableLoaded && state.error != null) {
                  return SliverToBoxAdapter(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(
                        AppSpacing.md,
                        0,
                        AppSpacing.md,
                        AppSpacing.md,
                      ),
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.red.shade200),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.warning_amber,
                            color: Colors.red.shade600,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              state.error!,
                              style: TextStyle(
                                color: Colors.red.shade700,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              context.read<WaiterTableBloc>().add(
                                const WaiterTableRefresh(),
                              );
                            },
                            icon: const Icon(Icons.refresh),
                            iconSize: 18,
                            color: Colors.red.shade600,
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return const SliverToBoxAdapter(child: SizedBox.shrink());
              },
            ),

            // Table Grid
            BlocBuilder<WaiterTableBloc, WaiterTableState>(
              builder: (context, state) {
                if (state is WaiterTableLoading) {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(AppSpacing.xl),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  );
                }

                if (state is WaiterTableError) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.xl),
                        child: Column(
                          children: [
                            Icon(
                              Icons.error_outline,
                              size: 64,
                              color: Colors.grey.shade400,
                            ),
                            const SizedBox(height: AppSpacing.md),
                            Text(
                              'Failed to Load Tables',
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(color: Colors.grey.shade600),
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            Text(
                              state.message,
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: Colors.grey.shade500),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: AppSpacing.md),
                            ElevatedButton(
                              onPressed: () {
                                context.read<WaiterTableBloc>().add(
                                  const WaiterTableLoadAll(),
                                );
                              },
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }

                if (state is WaiterTableLoaded) {
                  if (state.tables.isEmpty) {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(AppSpacing.xl),
                          child: Column(
                            children: [
                              Icon(
                                Icons.table_restaurant_outlined,
                                size: 64,
                                color: Colors.grey.shade400,
                              ),
                              const SizedBox(height: AppSpacing.md),
                              Text(
                                'No Tables Found',
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(color: Colors.grey.shade600),
                              ),
                              const SizedBox(height: AppSpacing.sm),
                              Text(
                                'Please contact admin to add tables',
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(color: Colors.grey.shade500),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }

                  return SliverPadding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.md,
                      0,
                      AppSpacing.md,
                      AppSpacing.md,
                    ),
                    sliver: TableGridWidget(
                      tables: state.tables,
                      onTableTap: (table) {
                        _handleTableTap(context, table);
                      },
                    ),
                  );
                }

                return const SliverToBoxAdapter(child: SizedBox.shrink());
              },
            ),

            // Bottom Padding
            const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xl)),
          ],
        ),
      ),
    );
  }

  void _handleTableTap(BuildContext context, RestaurantTable table) {
    // Only allow creating order for available tables
    if (table.status == TableStatus.available) {
      // Select table and navigate to new order page
      context.read<WaiterTableBloc>().add(WaiterTableSelect(table: table));

      // Navigate to new order page
      context.push('/waiter/new-order');
    } else {
      // Show info dialog for occupied/reserved tables
      _showTableInfoDialog(context, table);
    }
  }

  void _showTableInfoDialog(BuildContext context, RestaurantTable table) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Table ${table.tableNumber}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow('Status', _getStatusText(table.status)),
            if (table.currentOrderId != null) ...[
              const SizedBox(height: 8),
              _buildInfoRow('Order ID', '#${table.currentOrderId}'),
            ],
            if (table.orderCreatedAt != null) ...[
              const SizedBox(height: 8),
              _buildInfoRow(
                'Order Time',
                _formatDateTime(table.orderCreatedAt!),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
          if (table.status == TableStatus.occupied &&
              table.currentOrderId != null)
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Navigate to order details (when implemented)
                // context.push('/orders/${table.currentOrderId}');
              },
              child: const Text('View Order'),
            ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            '$label:',
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }

  String _getStatusText(TableStatus status) {
    switch (status) {
      case TableStatus.available:
        return 'Available';
      case TableStatus.occupied:
        return 'Occupied';
      case TableStatus.reserved:
        return 'Reserved';
    }
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes} mins ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours} hours ago';
    } else {
      return '${dateTime.day}/${dateTime.month} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
    }
  }
}
