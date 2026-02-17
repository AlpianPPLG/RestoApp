import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restoapp/core/theme/app_colors.dart';
import 'package:restoapp/core/theme/app_spacing.dart';
import 'package:restoapp/core/di/injection.dart';
import 'package:restoapp/presentation/blocs/kitchen/kitchen_bloc.dart';
import 'package:restoapp/presentation/widgets/kitchen/kitchen_stats_bar.dart';
import 'package:restoapp/presentation/widgets/kitchen/order_queue_widget.dart';

class KitchenDashboardPage extends StatelessWidget {
  const KitchenDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<KitchenBloc>()
        ..add(const KitchenLoadOrders())
        ..add(const KitchenStartAutoRefresh()),
      child: const _KitchenDashboardView(),
    );
  }
}

class _KitchenDashboardView extends StatelessWidget {
  const _KitchenDashboardView();

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
              'Kitchen Display',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            BlocBuilder<KitchenBloc, KitchenState>(
              builder: (context, state) {
                if (state is KitchenLoaded) {
                  return Text(
                    '${state.orders.length} orders in queue',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.white70,
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
        actions: [
          BlocBuilder<KitchenBloc, KitchenState>(
            builder: (context, state) {
              return IconButton(
                onPressed: state is KitchenLoaded && state.isRefreshing
                    ? null
                    : () {
                        context.read<KitchenBloc>().add(const KitchenRefresh());
                      },
                icon: AnimatedRotation(
                  turns: state is KitchenLoaded && state.isRefreshing
                      ? 1.0
                      : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: const Icon(Icons.refresh),
                ),
                tooltip: 'Refresh Orders',
              );
            },
          ),

          // Sound toggle button
          IconButton(
            onPressed: () {
              // TODO: Toggle sound alerts
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Sound alerts toggled'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
            icon: const Icon(Icons.volume_up),
            tooltip: 'Toggle Sound Alerts',
          ),

          const SizedBox(width: 8),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<KitchenBloc>().add(const KitchenRefresh());
          await Future.delayed(const Duration(milliseconds: 500));
        },
        child: CustomScrollView(
          slivers: [
            // Stats Bar
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: BlocBuilder<KitchenBloc, KitchenState>(
                  builder: (context, state) {
                    if (state is KitchenLoaded) {
                      return KitchenStatsBar(
                        pendingOrders: state.pendingOrders,
                        cookingOrders: state.cookingOrders,
                        readyOrders: state.readyOrders,
                        lateOrdersCount: state.lateOrders.length,
                        lastUpdated: state.lastUpdated,
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),

            // Error Banner
            BlocBuilder<KitchenBloc, KitchenState>(
              builder: (context, state) {
                if (state is KitchenLoaded && state.error != null) {
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
                              context.read<KitchenBloc>().add(
                                const KitchenRefresh(),
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

            // Order Queue
            BlocBuilder<KitchenBloc, KitchenState>(
              builder: (context, state) {
                if (state is KitchenLoading) {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(AppSpacing.xl),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  );
                }

                if (state is KitchenError) {
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
                              'Failed to Load Orders',
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
                                context.read<KitchenBloc>().add(
                                  const KitchenLoadOrders(),
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

                if (state is KitchenLoaded) {
                  if (state.orders.isEmpty) {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(AppSpacing.xl),
                          child: Column(
                            children: [
                              Icon(
                                Icons.restaurant_outlined,
                                size: 64,
                                color: Colors.grey.shade400,
                              ),
                              const SizedBox(height: AppSpacing.md),
                              Text(
                                'No Orders in Queue',
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(color: Colors.grey.shade600),
                              ),
                              const SizedBox(height: AppSpacing.sm),
                              Text(
                                'All caught up! 🎉',
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
                    sliver: OrderQueueWidget(
                      orders: state.orders,
                      lateOrders: state.lateOrders,
                      onStatusUpdate: (orderId, status) {
                        context.read<KitchenBloc>().add(
                          KitchenUpdateOrderStatus(
                            orderId: orderId,
                            status: status,
                          ),
                        );
                      },
                      onItemStatusUpdate: (orderItemId, status) {
                        context.read<KitchenBloc>().add(
                          KitchenUpdateItemStatus(
                            itemId: orderItemId,
                            status: status,
                          ),
                        );
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
}
