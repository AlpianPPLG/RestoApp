/// Application configuration constants.
///
/// Contains feature flags, polling intervals, and general app settings.
class AppConfig {
  AppConfig._();

  static const String appName = 'RestoApp';
  static const String appVersion = '1.0.0';

  // Feature flags
  static const bool enableCustomerMode = false;
  static const bool enableOfflineMode = false;
  static const bool enablePushNotifications = false;

  // Polling intervals
  static const Duration tableRefreshInterval = Duration(seconds: 10);
  static const Duration kitchenRefreshInterval = Duration(seconds: 5);
  static const Duration orderRefreshInterval = Duration(seconds: 10);

  // Session
  static const Duration sessionTimeout = Duration(minutes: 30);

  // Pagination
  static const int defaultPageSize = 20;

  // Late order warning threshold
  static const Duration lateOrderThreshold = Duration(minutes: 20);
}
