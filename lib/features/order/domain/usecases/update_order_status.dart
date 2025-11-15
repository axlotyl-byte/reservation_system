import 'package:dartz/dartz.dart';
import 'package:reservation_system/features/user/domain/entities/core/errors/failure.dart';
import '../entities/order.dart'as order_entity;
import '../repositories/order_repository.dart';

class UpdateOrder {
  final OrderRepository repository;

  UpdateOrder(this.repository);

  Future<Either<Failure, order_entity.Order>> call(order_entity.Order order) async {
    return await repository.updateOrder(order);
  }
}
