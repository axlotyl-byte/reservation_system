import 'package:dartz/dartz.dart';
import 'package:reservation_system/features/user/domain/entities/core/errors/failure.dart';
import '../entities/user.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> registerUser(User user, String password);
  Future<Either<Failure, User>> loginUser(String email, String password);
  Future<Either<Failure, User>> getUserProfile(String userId);
  Future<Either<Failure, User>> updateUserProfile(User user);
}
