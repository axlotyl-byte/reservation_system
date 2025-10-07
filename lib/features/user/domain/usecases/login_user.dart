import 'package:dartz/dartz.dart';
import 'package:reservation_system/features/user/domain/entities/core/errors/failure.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';

class LoginUser {
  final UserRepository repository;
  LoginUser(this.repository);

  Future<Either<Failure, User>> call(String email, String password) {
    return repository.loginUser(email, password);
  }
}
