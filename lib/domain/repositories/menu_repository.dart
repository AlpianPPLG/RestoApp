import 'package:restoapp/domain/entities/category.dart';
import 'package:restoapp/domain/entities/menu.dart';
import 'package:restoapp/domain/entities/inventory.dart';

/// Menu repository interface.
abstract class MenuRepository {
  /// Get all categories.
  Future<List<Category>> getCategories();

  /// Get all menus, optionally filtered by category.
  Future<List<Menu>> getMenus({int? categoryId});

  /// Get a single menu by ID.
  Future<Menu> getMenuById(int id);

  /// Create a new menu item.
  Future<Menu> createMenu(Menu menu);

  /// Update an existing menu item.
  Future<Menu> updateMenu(Menu menu);

  /// Toggle menu active status.
  Future<void> toggleMenuStatus(int id, bool isActive);

  /// Delete a menu item.
  Future<void> deleteMenu(int id);

  /// Get inventory for a menu item.
  Future<Inventory> getInventory(int menuId);

  /// Update inventory stock.
  Future<void> updateInventory(int menuId, int remainingStock);
}
