import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restoapp/core/theme/app_colors.dart';
import 'package:restoapp/core/theme/app_spacing.dart';
import 'package:restoapp/core/di/injection.dart';
import 'package:restoapp/domain/entities/menu.dart';
import 'package:restoapp/presentation/blocs/waiter/cart_bloc.dart';
import 'package:restoapp/presentation/blocs/waiter/new_order_bloc.dart';
import 'package:restoapp/presentation/blocs/waiter/waiter_table_bloc.dart';
import 'package:restoapp/presentation/widgets/waiter/cart_bottom_sheet.dart';
import 'package:restoapp/presentation/widgets/waiter/category_tabs_widget.dart';
import 'package:restoapp/presentation/widgets/waiter/menu_grid_widget.dart';
import 'package:restoapp/presentation/widgets/waiter/table_info_card.dart';

class NewOrderPage extends StatelessWidget {
  const NewOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              getIt<NewOrderBloc>()..add(const NewOrderLoadData()),
        ),
        BlocProvider(create: (context) => getIt<CartBloc>()),
      ],
      child: const _NewOrderView(),
    );
  }
}

class _NewOrderView extends StatefulWidget {
  const _NewOrderView();

  @override
  State<_NewOrderView> createState() => _NewOrderViewState();
}

class _NewOrderViewState extends State<_NewOrderView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Set selected table from WaiterTableBloc if available
    final waiterTableState = context.read<WaiterTableBloc>().state;
    if (waiterTableState is WaiterTableLoaded &&
        waiterTableState.selectedTable != null) {
      context.read<CartBloc>().add(
        CartSetTable(table: waiterTableState.selectedTable!),
      );
    }
  }

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
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'New Order',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        actions: [
          BlocBuilder<CartBloc, CartState>(
            builder: (context, cartState) {
              return IconButton(
                onPressed: cartState.isNotEmpty
                    ? () => _showCartBottomSheet(context)
                    : null,
                icon: Stack(
                  children: [
                    const Icon(Icons.shopping_cart),
                    if (cartState.totalItems > 0)
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 16,
                            minHeight: 16,
                          ),
                          child: Text(
                            '${cartState.totalItems}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                ),
                tooltip: 'View Cart (${cartState.totalItems})',
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // Table Info Card
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: BlocBuilder<CartBloc, CartState>(
                builder: (context, cartState) {
                  if (cartState.selectedTable != null) {
                    return TableInfoCard(table: cartState.selectedTable!);
                  }
                  return Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.orange.shade200),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.warning_amber, color: Colors.orange),
                        SizedBox(width: 8),
                        Text(
                          'No table selected. Please go back and select a table.',
                          style: TextStyle(color: Colors.orange),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),

          const Divider(height: 1),

          // Search Bar
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              AppSpacing.sm,
              AppSpacing.md,
              AppSpacing.md,
            ),
            child: TextField(
              controller: _searchController,
              onChanged: (query) {
                context.read<NewOrderBloc>().add(
                  NewOrderSearchChanged(query: query),
                );
              },
              decoration: InputDecoration(
                hintText: 'Search menu...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          _searchController.clear();
                          context.read<NewOrderBloc>().add(
                            const NewOrderSearchChanged(query: ''),
                          );
                        },
                        icon: const Icon(Icons.clear),
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppColors.primary),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
          ),

          const Divider(height: 1),

          // Category Tabs
          BlocBuilder<NewOrderBloc, NewOrderState>(
            builder: (context, state) {
              if (state is NewOrderLoaded && state.categories.isNotEmpty) {
                return CategoryTabsWidget(
                  categories: state.categories,
                  selectedCategoryId: state.selectedCategoryId,
                  onCategoryTap: (categoryId) {
                    context.read<NewOrderBloc>().add(
                      NewOrderCategorySelected(categoryId: categoryId),
                    );
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),

          // Menu Grid
          Expanded(
            child: BlocBuilder<NewOrderBloc, NewOrderState>(
              builder: (context, state) {
                if (state is NewOrderLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is NewOrderError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.xl),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 64,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(height: AppSpacing.md),
                          Text(
                            'Failed to Load Menu',
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
                              context.read<NewOrderBloc>().add(
                                const NewOrderLoadData(),
                              );
                            },
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                if (state is NewOrderLoaded) {
                  if (state.filteredMenus.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.xl),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.restaurant_menu_outlined,
                              size: 64,
                              color: Colors.grey.shade400,
                            ),
                            const SizedBox(height: AppSpacing.md),
                            Text(
                              state.searchQuery.isNotEmpty
                                  ? 'No menu found'
                                  : 'No menu available',
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(color: Colors.grey.shade600),
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            Text(
                              state.searchQuery.isNotEmpty
                                  ? 'Try different search terms'
                                  : 'Please contact admin to add menu items',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: Colors.grey.shade500),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<NewOrderBloc>().add(const NewOrderRefresh());
                      // Wait a bit for the refresh to complete
                      await Future.delayed(const Duration(milliseconds: 500));
                    },
                    child: MenuGridWidget(
                      menus: state.filteredMenus,
                      onMenuTap: (menu) => _handleMenuTap(context, menu),
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
      // Floating Cart Button
      floatingActionButton: BlocBuilder<CartBloc, CartState>(
        builder: (context, cartState) {
          if (cartState.isEmpty) return const SizedBox.shrink();

          return FloatingActionButton.extended(
            onPressed: () => _showCartBottomSheet(context),
            backgroundColor: AppColors.primary,
            icon: const Icon(Icons.shopping_cart),
            label: Text(
              '${cartState.totalItems} items - Rp ${_formatPrice(cartState.totalAmount)}',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          );
        },
      ),
    );
  }

  void _handleMenuTap(BuildContext context, Menu menu) {
    // Check if menu is active and has stock
    if (!menu.isActive) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('This menu item is currently unavailable'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    if (menu.remainingStock != null && menu.remainingStock! <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('This menu item is out of stock'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Add to cart
    context.read<CartBloc>().add(CartAddItem(menu: menu));

    // Show success feedback
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${menu.name} added to cart'),
        backgroundColor: AppColors.success,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _showCartBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BlocProvider.value(
        value: context.read<CartBloc>(),
        child: const CartBottomSheet(),
      ),
    );
  }

  String _formatPrice(double price) {
    return price
        .toStringAsFixed(0)
        .replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }
}
