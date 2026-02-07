import 'package:injectable/injectable.dart';

import 'package:restoapp/core/error/exceptions.dart';
import 'package:restoapp/domain/entities/category.dart';
import 'package:restoapp/domain/entities/inventory.dart';
import 'package:restoapp/domain/entities/menu.dart';
import 'package:restoapp/domain/repositories/menu_repository.dart';
import 'package:restoapp/data/datasources/remote/menu_remote_datasource.dart';

/// Concrete implementation of [MenuRepository].
@Injectable(as: MenuRepository)
class MenuRepositoryImpl implements MenuRepository {
  final MenuRemoteDataSource _remoteDataSource;

  MenuRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<Category>> getCategories() async {
    try {
      final data = await _remoteDataSource.getCategories();
      return data
          .map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      if (e is AppException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<Menu>> getMenus({int? categoryId}) async {
    try {
      final data = await _remoteDataSource.getMenus(categoryId: categoryId);
      return data.map((e) => Menu.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      if (e is AppException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<Menu> getMenuById(int id) async {
    try {
      final data = await _remoteDataSource.getMenuById(id);
      return Menu.fromJson(data);
    } catch (e) {
      if (e is AppException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<Menu> createMenu(Menu menu) async {
    try {
      final data = await _remoteDataSource.createMenu(menu.toJson());
      return Menu.fromJson(data);
    } catch (e) {
      if (e is AppException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<Menu> updateMenu(Menu menu) async {
    try {
      final data = await _remoteDataSource.updateMenu(menu.id, menu.toJson());
      return Menu.fromJson(data);
    } catch (e) {
      if (e is AppException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> toggleMenuStatus(int id, bool isActive) async {
    try {
      await _remoteDataSource.toggleMenuStatus(id, isActive);
    } catch (e) {
      if (e is AppException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> deleteMenu(int id) async {
    try {
      await _remoteDataSource.deleteMenu(id);
    } catch (e) {
      if (e is AppException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<Inventory> getInventory(int menuId) async {
    try {
      final data = await _remoteDataSource.getInventory(menuId);
      return Inventory.fromJson(data);
    } catch (e) {
      if (e is AppException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> updateInventory(int menuId, int remainingStock) async {
    try {
      await _remoteDataSource.updateInventory(menuId, remainingStock);
    } catch (e) {
      if (e is AppException) rethrow;
      throw ServerException(message: e.toString());
    }
  }
}
