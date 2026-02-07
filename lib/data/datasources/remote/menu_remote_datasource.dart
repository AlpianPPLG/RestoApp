import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:restoapp/core/constants/api_endpoints.dart';

/// Remote data source for menus and categories.
@injectable
class MenuRemoteDataSource {
  final Dio _dio;

  MenuRemoteDataSource(this._dio);

  Future<List<dynamic>> getCategories() async {
    final response = await _dio.get(ApiEndpoints.categories);
    return response.data['data'] as List<dynamic>;
  }

  Future<List<dynamic>> getMenus({int? categoryId}) async {
    final queryParams = <String, dynamic>{};
    if (categoryId != null) {
      queryParams['category_id'] = categoryId;
    }
    final response = await _dio.get(
      ApiEndpoints.menus,
      queryParameters: queryParams,
    );
    return response.data['data'] as List<dynamic>;
  }

  Future<Map<String, dynamic>> getMenuById(int id) async {
    final response = await _dio.get(ApiEndpoints.menuById(id));
    return response.data['data'] as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> createMenu(Map<String, dynamic> data) async {
    final response = await _dio.post(ApiEndpoints.menus, data: data);
    return response.data['data'] as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> updateMenu(
    int id,
    Map<String, dynamic> data,
  ) async {
    final response = await _dio.put(ApiEndpoints.menuById(id), data: data);
    return response.data['data'] as Map<String, dynamic>;
  }

  Future<void> toggleMenuStatus(int id, bool isActive) async {
    await _dio.patch(
      ApiEndpoints.menuStatus(id),
      data: {'is_active': isActive},
    );
  }

  Future<void> deleteMenu(int id) async {
    await _dio.delete(ApiEndpoints.menuById(id));
  }

  Future<Map<String, dynamic>> getInventory(int menuId) async {
    final response = await _dio.get(ApiEndpoints.inventoryByMenuId(menuId));
    return response.data['data'] as Map<String, dynamic>;
  }

  Future<void> updateInventory(int menuId, int remainingStock) async {
    await _dio.patch(
      ApiEndpoints.inventoryByMenuId(menuId),
      data: {'remaining_stock': remainingStock},
    );
  }
}
