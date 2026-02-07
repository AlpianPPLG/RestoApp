import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:restoapp/core/error/failures.dart';
import 'package:restoapp/domain/entities/user.dart';
import 'package:restoapp/domain/entities/enums.dart';
import 'package:restoapp/domain/repositories/auth_repository.dart';

/// Use case for user registration.
@injectable
class RegisterUseCase {
  final AuthRepository _repository;

  RegisterUseCase(this._repository);

  /// Execute registration with user details.
  Future<Either<Failure, User>> call({
    required String username,
    required String password,
    required String fullName,
    required UserRole role,
  }) {
    return _repository.register(
      username: username,
      password: password,
      fullName: fullName,
      role: role,
    );
  }
}
