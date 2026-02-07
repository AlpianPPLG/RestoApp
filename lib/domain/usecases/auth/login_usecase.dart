import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:restoapp/core/error/failures.dart';
import 'package:restoapp/domain/entities/user.dart';
import 'package:restoapp/domain/repositories/auth_repository.dart';

/// Use case for user login.
@injectable
class LoginUseCase {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  /// Execute login with username and password.
  Future<Either<Failure, User>> call({
    required String username,
    required String password,
  }) {
    return _repository.login(
      username: username,
      password: password,
    );
  }
}
