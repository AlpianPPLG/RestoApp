import 'package:flutter/material.dart';
import 'package:restoapp/core/theme/app_spacing.dart';
import 'package:restoapp/domain/entities/restaurant_table.dart';
import 'package:restoapp/presentation/widgets/waiter/table_card_widget.dart';

class TableGridWidget extends StatelessWidget {
  final List<RestaurantTable> tables;
  final Function(RestaurantTable) onTableTap;

  const TableGridWidget({
    super.key,
    required this.tables,
    required this.onTableTap,
  });

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.2,
        crossAxisSpacing: AppSpacing.md,
        mainAxisSpacing: AppSpacing.md,
      ),
      delegate: SliverChildBuilderDelegate((context, index) {
        final table = tables[index];
        return TableCardWidget(table: table, onTap: () => onTableTap(table));
      }, childCount: tables.length),
    );
  }
}
