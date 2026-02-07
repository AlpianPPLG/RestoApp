import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import 'package:restoapp/core/di/injection.dart';
import 'package:restoapp/core/theme/app_colors.dart';
import 'package:restoapp/core/theme/app_spacing.dart';
import 'package:restoapp/core/router/route_names.dart';
import 'package:restoapp/domain/entities/user.dart';
import 'package:restoapp/presentation/blocs/admin/admin_bloc.dart';
import 'package:restoapp/presentation/blocs/auth/auth_bloc.dart';
import 'package:restoapp/presentation/widgets/common/app_bar_widget.dart';
import 'package:restoapp/presentation/pages/admin/widgets/stats_card.dart';
import 'package:restoapp/presentation/pages/admin/widgets/quick_action_card.dart';

/// Admin Dashboard page.
class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AdminBloc>()..add(const AdminLoadDashboard()),
      child: const AdminDashboardView(),
    );
  }
}

class AdminDashboardView extends StatelessWidget {
  const AdminDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    // Get current user from AuthBloc if available
    User? currentUser;
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      currentUser = authState.user;
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(title: 'Admin Dashboard', user: currentUser),
      body: BlocConsumer<AdminBloc, AdminState>(
        listener: (context, state) {
          if (state is AdminError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.error,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AdminLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          if (state is AdminLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<AdminBloc>().add(const AdminRefreshDashboard());
              },
              color: AppColors.primary,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Welcome Message
                    _buildWelcomeSection(context, currentUser),
                    const SizedBox(height: AppSpacing.lg),

                    // Stats Cards
                    _buildStatsSection(context, state),
                    const SizedBox(height: AppSpacing.lg),

                    // Quick Actions
                    _buildQuickActionsSection(context),
                    const SizedBox(height: AppSpacing.lg),

                    // Today's Summary
                    _buildTodaySummary(context, state),
                  ],
                ),
              ),
            );
          }

          // Initial or error state - show reload button
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.dashboard_outlined,
                  size: 64,
                  color: AppColors.textSecondary.withValues(alpha: 0.5),
                ),
                const SizedBox(height: AppSpacing.md),
                const Text(
                  'Failed to load dashboard',
                  style: TextStyle(color: AppColors.textSecondary),
                ),
                const SizedBox(height: AppSpacing.md),
                ElevatedButton.icon(
                  onPressed: () {
                    context.read<AdminBloc>().add(const AdminLoadDashboard());
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retry'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildWelcomeSection(BuildContext context, User? user) {
    final now = DateTime.now();
    String greeting;
    if (now.hour < 12) {
      greeting = 'Good Morning';
    } else if (now.hour < 17) {
      greeting = 'Good Afternoon';
    } else {
      greeting = 'Good Evening';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          greeting,
          style: const TextStyle(fontSize: 14, color: AppColors.textSecondary),
        ),
        Text(
          user?.fullName ?? user?.username ?? 'Admin',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildStatsSection(BuildContext context, AdminLoaded state) {
    final currencyFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Overview',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: AppSpacing.sm,
          crossAxisSpacing: AppSpacing.sm,
          childAspectRatio: 1.5,
          children: [
            StatsCard(
              title: 'Total Menus',
              value: state.totalMenus.toString(),
              subtitle: '${state.activeMenus} active',
              icon: Icons.restaurant_menu,
              color: AppColors.primary,
            ),
            StatsCard(
              title: 'Total Tables',
              value: state.totalTables.toString(),
              subtitle: '${state.availableTables} available',
              icon: Icons.table_restaurant,
              color: AppColors.info,
            ),
            StatsCard(
              title: "Today's Orders",
              value: state.todayOrders.toString(),
              subtitle: '${state.pendingOrders} pending',
              icon: Icons.receipt_long,
              color: AppColors.warning,
            ),
            StatsCard(
              title: "Today's Revenue",
              value: currencyFormat.format(state.todayRevenue),
              subtitle: 'Completed orders',
              icon: Icons.payments,
              color: AppColors.success,
              isCompact: true,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickActionsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Actions',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: AppSpacing.sm,
          crossAxisSpacing: AppSpacing.sm,
          childAspectRatio: 2.0,
          children: [
            QuickActionCard(
              title: 'Menu Management',
              icon: Icons.restaurant_menu,
              color: AppColors.primary,
              onTap: () => context.goNamed(RouteNames.menuManagement),
            ),
            QuickActionCard(
              title: 'Table Management',
              icon: Icons.table_restaurant,
              color: AppColors.info,
              onTap: () => context.goNamed(RouteNames.tableManagement),
            ),
            QuickActionCard(
              title: 'User Management',
              icon: Icons.people,
              color: AppColors.success,
              onTap: () => context.goNamed(RouteNames.userManagement),
            ),
            QuickActionCard(
              title: 'Settings',
              icon: Icons.settings,
              color: AppColors.textSecondary,
              onTap: () => context.goNamed(RouteNames.settings),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTodaySummary(BuildContext context, AdminLoaded state) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Today's Summary",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                DateFormat('EEEE, d MMMM yyyy').format(DateTime.now()),
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: _buildSummaryItem(
                  icon: Icons.receipt,
                  label: 'Orders',
                  value: state.todayOrders.toString(),
                ),
              ),
              Container(width: 1, height: 40, color: AppColors.border),
              Expanded(
                child: _buildSummaryItem(
                  icon: Icons.pending_actions,
                  label: 'Pending',
                  value: state.pendingOrders.toString(),
                ),
              ),
              Container(width: 1, height: 40, color: AppColors.border),
              Expanded(
                child: _buildSummaryItem(
                  icon: Icons.table_restaurant,
                  label: 'Available Tables',
                  value: state.availableTables.toString(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Icon(icon, color: AppColors.primary, size: 24),
        const SizedBox(height: AppSpacing.xs),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
