import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:restoapp/core/error/failures.dart';
import 'package:restoapp/domain/entities/user.dart';
import 'package:restoapp/domain/repositories/auth_repository.dart';

/// Use case for getting current authenticated user.
@injectable
class GetCurrentUserUseCase {
  final AuthRepository _repository;

  GetCurrentUserUseCase(this._repository);

  /// Execute get current user.
  Future<Either<Failure, User?>> call() {
    return _repository.getCurrentUser();
  }
}
