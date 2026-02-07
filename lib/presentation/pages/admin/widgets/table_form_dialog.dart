import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:restoapp/core/theme/app_colors.dart';
import 'package:restoapp/core/theme/app_spacing.dart';
import 'package:restoapp/domain/entities/restaurant_table.dart';
import 'package:restoapp/domain/entities/enums.dart';

/// Dialog for creating or editing a table.
class TableFormDialog extends StatefulWidget {
  final RestaurantTable? table;
  final Function(RestaurantTable) onSave;

  const TableFormDialog({super.key, this.table, required this.onSave});

  @override
  State<TableFormDialog> createState() => _TableFormDialogState();
}

class _TableFormDialogState extends State<TableFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _tableNumberController;
  late TextEditingController _capacityController;
  TableStatus _selectedStatus = TableStatus.available;

  bool get isEditing => widget.table != null;

  @override
  void initState() {
    super.initState();
    _tableNumberController = TextEditingController(
      text: widget.table?.tableNumber ?? '',
    );
    _capacityController = TextEditingController(
      text: widget.table?.capacity.toString() ?? '4',
    );
    _selectedStatus = widget.table?.status ?? TableStatus.available;
  }

  @override
  void dispose() {
    _tableNumberController.dispose();
    _capacityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 350,
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    isEditing ? 'Edit Table' : 'Add New Table',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const Divider(),
              const SizedBox(height: AppSpacing.md),

              // Table Number Field
              TextFormField(
                controller: _tableNumberController,
                decoration: const InputDecoration(
                  labelText: 'Table Number *',
                  hintText: 'e.g., A1, T01, 1',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.table_restaurant),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Table number is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.md),

              // Capacity Field
              TextFormField(
                controller: _capacityController,
                decoration: const InputDecoration(
                  labelText: 'Capacity *',
                  hintText: 'Number of seats',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.people),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Capacity is required';
                  }
                  final capacity = int.tryParse(value);
                  if (capacity == null || capacity <= 0) {
                    return 'Please enter a valid capacity';
                  }
                  if (capacity > 20) {
                    return 'Maximum capacity is 20';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.md),

              // Status Selection
              const Text(
                'Status',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: TableStatus.values.map((status) {
                  final isSelected = _selectedStatus == status;
                  Color color;
                  switch (status) {
                    case TableStatus.available:
                      color = AppColors.tableAvailable;
                      break;
                    case TableStatus.occupied:
                      color = AppColors.tableOccupied;
                      break;
                    case TableStatus.reserved:
                      color = AppColors.tableReserved;
                      break;
                  }

                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: ChoiceChip(
                        label: Text(
                          status.displayName,
                          style: TextStyle(
                            fontSize: 12,
                            color: isSelected ? Colors.white : color,
                          ),
                        ),
                        selected: isSelected,
                        onSelected: (selected) {
                          if (selected) {
                            setState(() {
                              _selectedStatus = status;
                            });
                          }
                        },
                        selectedColor: color,
                        backgroundColor: color.withValues(alpha: 0.1),
                        side: BorderSide(color: color),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: AppSpacing.lg),

              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  ElevatedButton(
                    onPressed: _handleSave,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                    ),
                    child: Text(isEditing ? 'Update' : 'Create'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleSave() {
    if (_formKey.currentState?.validate() ?? false) {
      final table = RestaurantTable(
        id: widget.table?.id ?? 0,
        tableNumber: _tableNumberController.text.trim(),
        capacity: int.parse(_capacityController.text),
        status: _selectedStatus,
        createdAt: widget.table?.createdAt,
      );

      widget.onSave(table);
      Navigator.of(context).pop();
    }
  }
}
