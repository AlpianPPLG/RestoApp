import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:restoapp/core/di/injection.dart';
import 'package:restoapp/core/theme/app_colors.dart';
import 'package:restoapp/core/theme/app_spacing.dart';
import 'package:restoapp/domain/entities/restaurant_table.dart';
import 'package:restoapp/domain/entities/enums.dart';
import 'package:restoapp/presentation/blocs/table/table_bloc.dart';
import 'package:restoapp/presentation/pages/admin/widgets/table_form_dialog.dart';

/// Table management page for admin.
class TableManagementPage extends StatelessWidget {
  const TableManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<TableBloc>()..add(const TableLoadAll()),
      child: const TableManagementView(),
    );
  }
}

class TableManagementView extends StatelessWidget {
  const TableManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Table Management'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<TableBloc>().add(const TableLoadAll());
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showTableFormDialog(context),
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Add Table', style: TextStyle(color: Colors.white)),
      ),
      body: BlocConsumer<TableBloc, TableState>(
        listener: (context, state) {
          if (state is TableOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.success,
              ),
            );
          } else if (state is TableError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.error,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is TableLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          if (state is TableLoaded) {
            return Column(
              children: [
                // Status Summary Bar
                _buildStatusSummary(state),
                // Table Grid
                Expanded(
                  child: state.tables.isEmpty
                      ? _buildEmptyState()
                      : _buildTableGrid(context, state.tables),
                ),
              ],
            );
          }

          return const Center(child: Text('Failed to load tables'));
        },
      ),
    );
  }

  Widget _buildStatusSummary(TableLoaded state) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      color: AppColors.surface,
      child: Row(
        children: [
          _buildStatusChip('Total', state.totalCount, AppColors.textSecondary),
          const SizedBox(width: AppSpacing.sm),
          _buildStatusChip(
            'Available',
            state.availableCount,
            AppColors.tableAvailable,
          ),
          const SizedBox(width: AppSpacing.sm),
          _buildStatusChip(
            'Occupied',
            state.occupiedCount,
            AppColors.tableOccupied,
          ),
          const SizedBox(width: AppSpacing.sm),
          _buildStatusChip(
            'Reserved',
            state.reservedCount,
            AppColors.tableReserved,
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(String label, int count, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(
            '$label: $count',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.table_restaurant,
            size: 64,
            color: AppColors.textSecondary.withValues(alpha: 0.5),
          ),
          const SizedBox(height: AppSpacing.md),
          const Text(
            'No tables found',
            style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppSpacing.sm),
          const Text(
            'Add a new table to get started',
            style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildTableGrid(BuildContext context, List<RestaurantTable> tables) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: AppSpacing.md,
          mainAxisSpacing: AppSpacing.md,
          childAspectRatio: 1.2,
        ),
        itemCount: tables.length,
        itemBuilder: (context, index) {
          final table = tables[index];
          return _buildTableCard(context, table);
        },
      ),
    );
  }

  Widget _buildTableCard(BuildContext context, RestaurantTable table) {
    Color statusColor;
    switch (table.status) {
      case TableStatus.available:
        statusColor = AppColors.tableAvailable;
        break;
      case TableStatus.occupied:
        statusColor = AppColors.tableOccupied;
        break;
      case TableStatus.reserved:
        statusColor = AppColors.tableReserved;
        break;
    }

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: statusColor.withValues(alpha: 0.5), width: 2),
      ),
      child: InkWell(
        onTap: () => _showTableOptions(context, table),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Table Icon
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.table_restaurant,
                  size: 32,
                  color: statusColor,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              // Table Number
              Text(
                'Table ${table.tableNumber}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              // Capacity
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.people,
                    size: 14,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${table.capacity} seats',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              // Status Badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  table.status.displayName,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showTableOptions(BuildContext context, RestaurantTable table) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (bottomContext) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.table_restaurant,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    'Table ${table.tableNumber}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Divider(height: AppSpacing.lg),

              // Status Options
              const Text(
                'Change Status',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: [
                  Expanded(
                    child: _buildStatusButton(
                      context,
                      table,
                      TableStatus.available,
                      'Available',
                      AppColors.tableAvailable,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: _buildStatusButton(
                      context,
                      table,
                      TableStatus.reserved,
                      'Reserved',
                      AppColors.tableReserved,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: _buildStatusButton(
                      context,
                      table,
                      TableStatus.occupied,
                      'Occupied',
                      AppColors.tableOccupied,
                    ),
                  ),
                ],
              ),
              const Divider(height: AppSpacing.lg),

              // Action Buttons
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Edit Table'),
                onTap: () {
                  Navigator.of(bottomContext).pop();
                  _showTableFormDialog(context, table: table);
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete, color: AppColors.error),
                title: const Text(
                  'Delete Table',
                  style: TextStyle(color: AppColors.error),
                ),
                onTap: () {
                  Navigator.of(bottomContext).pop();
                  _showDeleteConfirmation(context, table);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusButton(
    BuildContext context,
    RestaurantTable table,
    TableStatus status,
    String label,
    Color color,
  ) {
    final isSelected = table.status == status;
    return OutlinedButton(
      onPressed: isSelected
          ? null
          : () {
              Navigator.of(context).pop();
              context.read<TableBloc>().add(
                TableUpdateStatus(tableId: table.id, status: status),
              );
            },
      style: OutlinedButton.styleFrom(
        backgroundColor: isSelected ? color.withValues(alpha: 0.1) : null,
        side: BorderSide(color: color),
        foregroundColor: color,
      ),
      child: Text(label, style: const TextStyle(fontSize: 12)),
    );
  }

  void _showTableFormDialog(BuildContext context, {RestaurantTable? table}) {
    showDialog(
      context: context,
      builder: (dialogContext) => TableFormDialog(
        table: table,
        onSave: (savedTable) {
          if (table != null) {
            context.read<TableBloc>().add(TableUpdate(savedTable));
          } else {
            context.read<TableBloc>().add(TableCreate(savedTable));
          }
        },
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, RestaurantTable table) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Table'),
        content: Text(
          'Are you sure you want to delete "Table ${table.tableNumber}"?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              context.read<TableBloc>().add(TableDelete(table.id));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
