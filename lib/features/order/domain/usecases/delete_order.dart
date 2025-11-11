import 'package:dartz/dartz.dart';
import 'package:reservation_system/features/user/domain/entities/core/errors/failure.dart';
import '../repositories/order_repository.dart';

class DeleteOrder {
  final OrderRepository repository;
  DeleteOrder(this.repository);

  Future<Either<Failure, void>> call(String orderId) {
    return repository.deleteOrder(orderId);
  }
}
