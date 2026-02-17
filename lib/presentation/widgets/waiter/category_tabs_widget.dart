import 'package:flutter/material.dart';
import 'package:restoapp/core/theme/app_colors.dart';
import 'package:restoapp/core/theme/app_spacing.dart';
import 'package:restoapp/domain/entities/category.dart';

class CategoryTabsWidget extends StatelessWidget {
  final List<Category> categories;
  final int? selectedCategoryId;
  final Function(int?) onCategoryTap;

  const CategoryTabsWidget({
    super.key,
    required this.categories,
    required this.selectedCategoryId,
    required this.onCategoryTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        child: Row(
          children: [
            // All Categories Tab
            _CategoryTab(
              label: 'All',
              icon: Icons.restaurant,
              isSelected: selectedCategoryId == null,
              onTap: () => onCategoryTap(null),
            ),
            const SizedBox(width: AppSpacing.sm),

            // Category Tabs
            ...categories.map(
              (category) => Padding(
                padding: const EdgeInsets.only(right: AppSpacing.sm),
                child: _CategoryTab(
                  label: category.name,
                  icon: _getCategoryIcon(category.name),
                  isSelected: selectedCategoryId == category.id,
                  onTap: () => onCategoryTap(category.id),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String categoryName) {
    final name = categoryName.toLowerCase();

    if (name.contains('makanan') || name.contains('food')) {
      return Icons.lunch_dining;
    } else if (name.contains('minuman') ||
        name.contains('drink') ||
        name.contains('beverage')) {
      return Icons.local_drink;
    } else if (name.contains('dessert') || name.contains('sweet')) {
      return Icons.cake;
    } else if (name.contains('snack') || name.contains('camilan')) {
      return Icons.cookie;
    } else if (name.contains('appetizer') || name.contains('pembuka')) {
      return Icons.emoji_food_beverage;
    }

    return Icons.restaurant;
  }
}

class _CategoryTab extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryTab({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? AppColors.primary : Colors.grey.shade300,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 16,
                color: isSelected ? Colors.white : Colors.grey.shade600,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey.shade700,
                  fontSize: 13,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
