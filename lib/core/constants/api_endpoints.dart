/// API endpoint constants.
class ApiEndpoints {
  ApiEndpoints._();

  // Auth
  static const String login = '/auth/login';
  static const String logout = '/auth/logout';
  static const String register = '/auth/register';

  // Categories
  static const String categories = '/categories';

  // Menus
  static const String menus = '/menus';
  static String menuById(int id) => '/menus/$id';
  static String menuStatus(int id) => '/menus/$id/status';

  // Tables
  static const String tables = '/tables';
  static String tableById(int id) => '/tables/$id';
  static String tableStatus(int id) => '/tables/$id/status';

  // Orders
  static const String orders = '/orders';
  static String orderById(int id) => '/orders/$id';
  static String orderStatus(int id) => '/orders/$id/status';

  // Order Items
  static String orderItemStatus(int id) => '/order-items/$id/status';

  // Payments
  static const String payments = '/payments';
  static String processPayment(int orderId) => '/orders/$orderId/payment';

  // Transactions
  static const String transactionHistory = '/transactions/history';

  // Users
  static const String users = '/users';
  static String userById(int id) => '/users/$id';
  static String userPassword(int id) => '/users/$id/password';

  // Inventories
  static const String inventories = '/inventories';
  static String inventoryByMenuId(int menuId) => '/inventories/$menuId';

  // Dashboard / Stats
  static const String dashboardStats = '/dashboard/stats';
  static const String salesChart = '/dashboard/sales-chart';
}
