import 'package:dartz/dartz.dart';
import '../entities/user.dart';
import 'package:reservation_system/features/user/domain/entities/core/errors/failure.dart';
import '../repositories/user_repository.dart';

class RegisterUser {
  final UserRepository repository;
  RegisterUser(this.repository);

  Future<Either<Failure, User>> call(User user, String password) {
    return repository.registerUser(user, password);
  }
}
