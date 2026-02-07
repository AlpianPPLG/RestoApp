import 'package:logger/logger.dart';

/// Application-wide logger service.
/// 
/// Usage:
/// ```dart
/// AppLogger.info('User logged in', tag: 'Auth');
/// AppLogger.error('Failed to fetch data', error: e, tag: 'API');
/// ```
class AppLogger {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 80,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
  );

  /// Log debug message
  static void debug(String message, {String? tag, dynamic data}) {
    _logger.d(_formatMessage(message, tag, data));
  }

  /// Log info message
  static void info(String message, {String? tag, dynamic data}) {
    _logger.i(_formatMessage(message, tag, data));
  }

  /// Log warning message
  static void warning(String message, {String? tag, dynamic data}) {
    _logger.w(_formatMessage(message, tag, data));
  }

  /// Log error message
  static void error(
    String message, {
    String? tag,
    dynamic error,
    StackTrace? stackTrace,
  }) {
    _logger.e(
      _formatMessage(message, tag, null),
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Log fatal/critical error
  static void fatal(
    String message, {
    String? tag,
    dynamic error,
    StackTrace? stackTrace,
  }) {
    _logger.f(
      _formatMessage(message, tag, null),
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Format log message with tag
  static String _formatMessage(String message, String? tag, dynamic data) {
    final buffer = StringBuffer();
    
    if (tag != null) {
      buffer.write('[$tag] ');
    }
    
    buffer.write(message);
    
    if (data != null) {
      buffer.write(' | Data: $data');
    }
    
    return buffer.toString();
  }

  /// Log API request
  static void apiRequest(String method, String url, {dynamic data}) {
    info(
      'API Request: $method $url',
      tag: 'API',
      data: data,
    );
  }

  /// Log API response
  static void apiResponse(String method, String url, int statusCode) {
    info(
      'API Response: $method $url - Status: $statusCode',
      tag: 'API',
    );
  }

  /// Log API error
  static void apiError(String method, String url, dynamic error) {
    AppLogger.error(
      'API Error: $method $url',
      tag: 'API',
      error: error,
    );
  }

  /// Log authentication events
  static void auth(String event, {String? username, dynamic data}) {
    info(
      'Auth: $event${username != null ? " - User: $username" : ""}',
      tag: 'AUTH',
      data: data,
    );
  }

  /// Log navigation events
  static void navigation(String from, String to) {
    debug('Navigation: $from → $to', tag: 'NAV');
  }

  /// Log BLoC events
  static void blocEvent(String blocName, String event, {dynamic data}) {
    debug('BLoC Event: $blocName.$event', tag: 'BLOC', data: data);
  }

  /// Log BLoC state changes
  static void blocState(String blocName, String state, {dynamic data}) {
    debug('BLoC State: $blocName → $state', tag: 'BLOC', data: data);
  }

  /// Log user actions
  static void userAction(String action, {dynamic data}) {
    info('User Action: $action', tag: 'USER', data: data);
  }
}
