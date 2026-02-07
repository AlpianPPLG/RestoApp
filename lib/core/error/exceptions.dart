/// Custom exception classes for the application.
library;

/// Base exception class.
class AppException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;

  const AppException({required this.message, this.statusCode, this.data});

  @override
  String toString() => 'AppException: $message (code: $statusCode)';
}

/// Exception thrown when a server error occurs.
class ServerException extends AppException {
  const ServerException({required super.message, super.statusCode, super.data});
}

/// Exception thrown when there is no internet connection.
class NetworkException extends AppException {
  const NetworkException({
    super.message = 'Tidak ada koneksi internet',
    super.statusCode,
  });
}

/// Exception thrown when authentication fails.
class AuthException extends AppException {
  const AuthException({
    super.message = 'Autentikasi gagal',
    super.statusCode = 401,
  });
}

/// Exception thrown when user is not authorized.
class UnauthorizedException extends AppException {
  const UnauthorizedException({
    super.message = 'Anda tidak memiliki akses',
    super.statusCode = 403,
  });
}

/// Exception thrown when a resource is not found.
class NotFoundException extends AppException {
  const NotFoundException({
    super.message = 'Data tidak ditemukan',
    super.statusCode = 404,
  });
}

/// Exception thrown when there is a cache error.
class CacheException extends AppException {
  const CacheException({super.message = 'Gagal mengakses cache'});
}

/// Exception thrown when validation fails.
class ValidationException extends AppException {
  final Map<String, List<String>>? errors;

  const ValidationException({
    super.message = 'Validasi gagal',
    super.statusCode = 422,
    this.errors,
  });
}
