import 'package:dartz/dartz.dart';
import 'package:reservation_system/features/user/domain/entities/core/errors/failure.dart';
import '../entities/order.dart'as order_entity;
import '../repositories/order_repository.dart';

class PlaceOrder {
  final OrderRepository repository;

  PlaceOrder(this.repository);

  Future<Either<Failure, order_entity.Order>> call(Order order) async {
    return await repository.placeOrder(order);
  }
}
