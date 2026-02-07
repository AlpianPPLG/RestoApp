import 'package:equatable/equatable.dart';

/// Base failure class.
///
/// In Clean Architecture, failures are used in the domain layer
/// to represent error states without depending on specific exceptions.
abstract class Failure extends Equatable {
  final String message;
  final int? statusCode;

  const Failure({required this.message, this.statusCode});

  @override
  List<Object?> get props => [message, statusCode];
}

/// Server failure.
class ServerFailure extends Failure {
  const ServerFailure({required super.message, super.statusCode});
}

/// Network failure (no internet).
class NetworkFailure extends Failure {
  const NetworkFailure({super.message = 'Tidak ada koneksi internet'});
}

/// Authentication failure.
class AuthFailure extends Failure {
  const AuthFailure({
    super.message = 'Autentikasi gagal',
    super.statusCode = 401,
  });
}

/// Cache failure.
class CacheFailure extends Failure {
  const CacheFailure({super.message = 'Gagal mengakses cache'});
}

/// Validation failure.
class ValidationFailure extends Failure {
  final Map<String, List<String>>? errors;

  const ValidationFailure({
    super.message = 'Validasi gagal',
    super.statusCode = 422,
    this.errors,
  });

  @override
  List<Object?> get props => [message, statusCode, errors];
}

/// Unknown failure.
class UnknownFailure extends Failure {
  const UnknownFailure({
    super.message = 'Terjadi kesalahan yang tidak diketahui',
  });
}
