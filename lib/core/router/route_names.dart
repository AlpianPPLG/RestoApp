/// Route name constants.
class RouteNames {
  RouteNames._();

  // Auth
  static const String splash = 'splash';
  static const String login = 'login';
  static const String register = 'register';

  // Admin
  static const String adminDashboard = 'admin-dashboard';
  static const String menuManagement = 'menu-management';
  static const String tableManagement = 'table-management';
  static const String userManagement = 'user-management';
  static const String settings = 'settings';

  // Waiter
  static const String waiterDashboard = 'waiter-dashboard';
  static const String newOrder = 'new-order';

  // Kitchen
  static const String kitchenDashboard = 'kitchen-dashboard';

  // Cashier
  static const String cashierDashboard = 'cashier-dashboard';

  // Customer
  static const String tableSelection = 'table-selection';
  static const String customerMenu = 'customer-menu';
  static const String customerCart = 'customer-cart';
  static const String orderStatus = 'order-status';

  // Receipt
  static const String receipt = 'receipt';
}

/// Route path constants.
class RoutePaths {
  RoutePaths._();

  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';

  // Admin
  static const String adminDashboard = '/admin';
  static const String menuManagement = '/admin/menus';
  static const String tableManagement = '/admin/tables';
  static const String userManagement = '/admin/users';
  static const String settings = '/admin/settings';

  // Waiter
  static const String waiterDashboard = '/waiter';
  static const String newOrder = '/waiter/order/new/:tableId';

  // Kitchen
  static const String kitchenDashboard = '/kitchen';

  // Cashier
  static const String cashierDashboard = '/cashier';

  // Customer
  static const String tableSelection = '/customer/tables';
  static const String customerMenu = '/customer/menu';
  static const String customerCart = '/customer/cart';
  static const String orderStatus = '/customer/order/:orderId';

  // Receipt
  static const String receipt = '/receipt/:orderId';
}
