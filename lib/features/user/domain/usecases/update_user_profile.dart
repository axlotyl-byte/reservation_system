import 'package:dartz/dartz.dart';
import 'package:reservation_system/features/user/domain/entities/core/errors/failure.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';

class UpdateUserProfile {
  final UserRepository repository;
  UpdateUserProfile(this.repository);

  Future<Either<Failure, User>> call(User updatedUser) {
    return repository.updateUserProfile(updatedUser);
  }
} 