import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:restoapp/core/di/injection.dart';
import 'package:restoapp/core/theme/app_colors.dart';
import 'package:restoapp/core/theme/app_spacing.dart';
import 'package:restoapp/domain/entities/menu.dart';
import 'package:restoapp/domain/entities/category.dart';
import 'package:restoapp/presentation/blocs/menu/menu_bloc.dart';
import 'package:restoapp/presentation/pages/admin/widgets/menu_form_dialog.dart';

/// Menu management page for admin.
class MenuManagementPage extends StatelessWidget {
  const MenuManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MenuBloc>()..add(const MenuLoadAll()),
      child: const MenuManagementView(),
    );
  }
}

class MenuManagementView extends StatefulWidget {
  const MenuManagementView({super.key});

  @override
  State<MenuManagementView> createState() => _MenuManagementViewState();
}

class _MenuManagementViewState extends State<MenuManagementView> {
  final TextEditingController _searchController = TextEditingController();
  int? _selectedCategoryId;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Menu Management'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<MenuBloc>().add(const MenuLoadAll());
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showMenuFormDialog(context),
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Add Menu', style: TextStyle(color: Colors.white)),
      ),
      body: BlocConsumer<MenuBloc, MenuState>(
        listener: (context, state) {
          if (state is MenuOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.success,
              ),
            );
          } else if (state is MenuError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.error,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is MenuLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          if (state is MenuLoaded) {
            return Column(
              children: [
                // Search and Filter Bar
                _buildSearchAndFilterBar(context, state.categories),
                // Menu List
                Expanded(
                  child: state.menus.isEmpty
                      ? _buildEmptyState()
                      : _buildMenuList(context, state.menus, state.categories),
                ),
              ],
            );
          }

          return const Center(child: Text('Failed to load menus'));
        },
      ),
    );
  }

  Widget _buildSearchAndFilterBar(
    BuildContext context,
    List<Category> categories,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      color: AppColors.surface,
      child: Column(
        children: [
          // Search Field
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search menus...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        context.read<MenuBloc>().add(const MenuSearch(''));
                      },
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.border),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
            ),
            onChanged: (value) {
              context.read<MenuBloc>().add(MenuSearch(value));
            },
          ),
          const SizedBox(height: AppSpacing.sm),
          // Category Filter
          SizedBox(
            height: 36,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildCategoryChip(context, null, 'All'),
                ...categories.map(
                  (cat) => _buildCategoryChip(context, cat.id, cat.name),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(
    BuildContext context,
    int? categoryId,
    String label,
  ) {
    final isSelected = _selectedCategoryId == categoryId;
    return Padding(
      padding: const EdgeInsets.only(right: AppSpacing.xs),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            _selectedCategoryId = selected ? categoryId : null;
          });
          if (categoryId != null && selected) {
            context.read<MenuBloc>().add(MenuLoadByCategory(categoryId));
          } else {
            context.read<MenuBloc>().add(const MenuLoadAll());
          }
        },
        selectedColor: AppColors.primary.withValues(alpha: 0.2),
        checkmarkColor: AppColors.primary,
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.restaurant_menu,
            size: 64,
            color: AppColors.textSecondary.withValues(alpha: 0.5),
          ),
          const SizedBox(height: AppSpacing.md),
          const Text(
            'No menus found',
            style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppSpacing.sm),
          const Text(
            'Add a new menu to get started',
            style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuList(
    BuildContext context,
    List<Menu> menus,
    List<Category> categories,
  ) {
    final currencyFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.md),
      itemCount: menus.length,
      itemBuilder: (context, index) {
        final menu = menus[index];
        final category = categories.firstWhere(
          (c) => c.id == menu.categoryId,
          orElse: () => const Category(id: 0, name: 'Unknown'),
        );

        return Card(
          margin: const EdgeInsets.only(bottom: AppSpacing.sm),
          child: ListTile(
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: menu.imageUrl != null && menu.imageUrl!.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        menu.imageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.restaurant,
                          color: AppColors.primary,
                        ),
                      ),
                    )
                  : const Icon(Icons.restaurant, color: AppColors.primary),
            ),
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    menu.name,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: menu.isActive
                        ? AppColors.success.withValues(alpha: 0.1)
                        : AppColors.error.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    menu.isActive ? 'Active' : 'Inactive',
                    style: TextStyle(
                      fontSize: 11,
                      color: menu.isActive
                          ? AppColors.success
                          : AppColors.error,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  category.name,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  currencyFormat.format(menu.price),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            trailing: PopupMenuButton<String>(
              onSelected: (value) {
                switch (value) {
                  case 'edit':
                    _showMenuFormDialog(context, menu: menu);
                    break;
                  case 'toggle':
                    context.read<MenuBloc>().add(
                      MenuToggleStatus(
                        menuId: menu.id,
                        isActive: !menu.isActive,
                      ),
                    );
                    break;
                  case 'delete':
                    _showDeleteConfirmation(context, menu);
                    break;
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(Icons.edit, size: 20),
                      SizedBox(width: 8),
                      Text('Edit'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'toggle',
                  child: Row(
                    children: [
                      Icon(
                        menu.isActive ? Icons.visibility_off : Icons.visibility,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(menu.isActive ? 'Deactivate' : 'Activate'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete, size: 20, color: AppColors.error),
                      SizedBox(width: 8),
                      Text('Delete', style: TextStyle(color: AppColors.error)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showMenuFormDialog(BuildContext context, {Menu? menu}) {
    final menuBloc = context.read<MenuBloc>();
    final state = menuBloc.state;
    List<Category> categories = [];
    if (state is MenuLoaded) {
      categories = state.categories;
    }

    showDialog(
      context: context,
      builder: (dialogContext) => MenuFormDialog(
        menu: menu,
        categories: categories,
        onSave: (savedMenu) {
          if (menu != null) {
            menuBloc.add(MenuUpdate(savedMenu));
          } else {
            menuBloc.add(MenuCreate(savedMenu));
          }
        },
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, Menu menu) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Menu'),
        content: Text('Are you sure you want to delete "${menu.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              context.read<MenuBloc>().add(MenuDelete(menu.id));
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
