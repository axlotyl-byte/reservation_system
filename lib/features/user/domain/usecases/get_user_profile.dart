import 'package:dartz/dartz.dart';
import 'package:reservation_system/features/user/domain/entities/core/errors/failure.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';

class GetUserProfile {
  final UserRepository repository;
  GetUserProfile(this.repository);

  Future<Either<Failure, User>> call(String userId) {
    return repository.getUserProfile(userId);
  }
}
