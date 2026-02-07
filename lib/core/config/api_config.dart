/// API configuration for different environments.
class ApiConfig {
  ApiConfig._();

  // ============================================
  // CONFIGURATION - Change based on your setup
  // ============================================

  /// Set to true if using Android Emulator
  /// Set to false if using Physical Device
  static const bool useEmulator = false;

  // Your computer's WiFi IP address (for physical device)
  // Get this by running: ipconfig (Windows) or ifconfig (Mac/Linux)
  static const String wifiIpAddress = '192.168.253.1';

  // Backend server port
  static const int serverPort = 3000;

  // ============================================
  // AUTO-GENERATED URLs (Don't modify)
  // ============================================

  /// Development base URL for physical device
  static String get physicalDeviceUrl =>
      'http://$wifiIpAddress:$serverPort/api';

  /// Development base URL for Android emulator
  static const String emulatorUrl = 'http://10.0.2.2:3000/api';

  /// Development base URL for iOS simulator
  static const String iosSimulatorUrl = 'http://localhost:3000/api';

  /// Production base URL
  static const String prodBaseUrl = 'https://your-server.com/api';

  // Current environment
  static const bool isProduction = false;

  /// Get the base URL based on current environment and device type.
  static String get baseUrl {
    if (isProduction) return prodBaseUrl;
    return useEmulator ? emulatorUrl : physicalDeviceUrl;
  }

  // Timeouts
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);

  // ============================================
  // HELPER INFO
  // ============================================

  /// Print current configuration (for debugging)
  static void printConfig() {
    // ignore: avoid_print
    print('=================================');
    // ignore: avoid_print
    print('API Configuration');
    // ignore: avoid_print
    print('=================================');
    // ignore: avoid_print
    print('Environment: ${isProduction ? "Production" : "Development"}');
    // ignore: avoid_print
    print('Device Type: ${useEmulator ? "Emulator" : "Physical Device"}');
    // ignore: avoid_print
    print('Base URL: $baseUrl');
    // ignore: avoid_print
    print('WiFi IP: $wifiIpAddress');
    // ignore: avoid_print
    print('=================================');
  }
}
