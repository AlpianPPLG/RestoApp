import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:restoapp/core/error/failures.dart';
import 'package:restoapp/domain/repositories/auth_repository.dart';

/// Use case for user logout.
@injectable
class LogoutUseCase {
  final AuthRepository _repository;

  LogoutUseCase(this._repository);

  /// Execute logout.
  Future<Either<Failure, void>> call() {
    return _repository.logout();
  }
}
