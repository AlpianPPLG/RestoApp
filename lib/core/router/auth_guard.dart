import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:restoapp/core/di/injection.dart';
import 'package:restoapp/domain/entities/enums.dart';
import 'package:restoapp/domain/repositories/auth_repository.dart';
import 'package:restoapp/core/router/route_names.dart';

/// Authentication guard for protecting routes.
class AuthGuard {
  final AuthRepository _authRepository = getIt<AuthRepository>();

  /// Check if user is authenticated.
  Future<bool> isAuthenticated() async {
    return await _authRepository.isLoggedIn();
  }

  /// Get current user role.
  Future<UserRole?> getCurrentUserRole() async {
    final result = await _authRepository.getCurrentUser();
    return result.fold(
      (failure) => null,
      (user) => user?.role,
    );
  }

  /// Redirect logic for protected routes.
  Future<String?> redirectLogic(
    BuildContext context,
    GoRouterState state,
  ) async {
    final isLoggedIn = await isAuthenticated();

    // If not logged in and trying to access protected route
    if (!isLoggedIn && state.matchedLocation != RoutePaths.login) {
      return RoutePaths.login;
    }

    // If logged in and trying to access login page
    if (isLoggedIn && state.matchedLocation == RoutePaths.login) {
      final role = await getCurrentUserRole();
      return _getDefaultRouteForRole(role);
    }

    return null; // No redirect needed
  }

  /// Check if user has required role for route.
  Future<bool> hasRole(List<UserRole> allowedRoles) async {
    final role = await getCurrentUserRole();
    if (role == null) return false;
    return allowedRoles.contains(role);
  }

  /// Get default route based on user role.
  String _getDefaultRouteForRole(UserRole? role) {
    switch (role) {
      case UserRole.admin:
        return RoutePaths.adminDashboard;
      case UserRole.waiter:
        return RoutePaths.waiterDashboard;
      case UserRole.kitchen:
        return RoutePaths.kitchenDashboard;
      case UserRole.cashier:
        return RoutePaths.cashierDashboard;
      default:
        return RoutePaths.login;
    }
  }
}
