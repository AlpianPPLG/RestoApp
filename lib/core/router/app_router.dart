import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:restoapp/core/router/route_names.dart';
import 'package:restoapp/presentation/pages/splash/splash_page.dart';
import 'package:restoapp/presentation/pages/auth/login_page.dart';
import 'package:restoapp/presentation/pages/auth/register_page.dart';
import 'package:restoapp/presentation/pages/admin/admin_dashboard_page.dart';
import 'package:restoapp/presentation/pages/admin/menu_management_page.dart';
import 'package:restoapp/presentation/pages/admin/table_management_page.dart';
import 'package:restoapp/presentation/pages/admin/user_management_page.dart';

/// Application router configuration using GoRouter.
class AppRouter {
  AppRouter._();

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: RoutePaths.splash,
    debugLogDiagnostics: true,
    routes: [
      // Splash
      GoRoute(
        path: RoutePaths.splash,
        name: RouteNames.splash,
        builder: (context, state) => const SplashPage(),
      ),

      // Login
      GoRoute(
        path: RoutePaths.login,
        name: RouteNames.login,
        builder: (context, state) => const LoginPage(),
      ),

      // Register
      GoRoute(
        path: RoutePaths.register,
        name: RouteNames.register,
        builder: (context, state) => const RegisterPage(),
      ),

      // Admin routes
      GoRoute(
        path: RoutePaths.adminDashboard,
        name: RouteNames.adminDashboard,
        builder: (context, state) => const AdminDashboardPage(),
        routes: [
          GoRoute(
            path: 'menus',
            name: RouteNames.menuManagement,
            builder: (context, state) => const MenuManagementPage(),
          ),
          GoRoute(
            path: 'tables',
            name: RouteNames.tableManagement,
            builder: (context, state) => const TableManagementPage(),
          ),
          GoRoute(
            path: 'users',
            name: RouteNames.userManagement,
            builder: (context, state) => const UserManagementPage(),
          ),
          GoRoute(
            path: 'settings',
            name: RouteNames.settings,
            builder: (context, state) =>
                const _PlaceholderPage(title: 'Settings'),
          ),
        ],
      ),

      // Waiter routes
      GoRoute(
        path: RoutePaths.waiterDashboard,
        name: RouteNames.waiterDashboard,
        builder: (context, state) =>
            const _PlaceholderPage(title: 'Waiter Dashboard'),
      ),
      GoRoute(
        path: RoutePaths.newOrder,
        name: RouteNames.newOrder,
        builder: (context, state) {
          final tableId = state.pathParameters['tableId']!;
          return _PlaceholderPage(title: 'New Order - Table $tableId');
        },
      ),

      // Kitchen routes
      GoRoute(
        path: RoutePaths.kitchenDashboard,
        name: RouteNames.kitchenDashboard,
        builder: (context, state) =>
            const _PlaceholderPage(title: 'Kitchen Display'),
      ),

      // Cashier routes
      GoRoute(
        path: RoutePaths.cashierDashboard,
        name: RouteNames.cashierDashboard,
        builder: (context, state) =>
            const _PlaceholderPage(title: 'Cashier POS'),
      ),

      // Receipt
      GoRoute(
        path: RoutePaths.receipt,
        name: RouteNames.receipt,
        builder: (context, state) {
          final orderId = state.pathParameters['orderId']!;
          return _PlaceholderPage(title: 'Receipt #$orderId');
        },
      ),
    ],
    errorBuilder: (context, state) =>
        Scaffold(body: Center(child: Text('Page not found: ${state.uri}'))),
  );
}

/// Temporary placeholder page during development.
class _PlaceholderPage extends StatelessWidget {
  final String title;

  const _PlaceholderPage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text(title, style: Theme.of(context).textTheme.headlineMedium),
      ),
    );
  }
}
