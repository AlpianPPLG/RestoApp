/// App-wide constants.
class AppConstants {
  AppConstants._();

  // Storage keys
  static const String authTokenKey = 'auth_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userDataKey = 'user_data';
  static const String themeKey = 'theme_mode';

  // Numeric limits
  static const int maxQuantity = 99;
  static const int minQuantity = 1;
  static const double minPaymentAmount = 0;

  // UI
  static const double borderRadius = 12.0;
  static const double cardElevation = 2.0;
  static const double buttonHeight = 48.0;

  // Restaurant info (default)
  static const String restaurantName = 'RESTAUS';
  static const String restaurantTagline = 'Restaurant & Cafe';
  static const String restaurantAddress = 'Jl. Contoh No. 123';
}
