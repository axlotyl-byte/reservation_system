import 'package:dartz/dartz.dart';
import 'package:reservation_system/features/user/domain/entities/core/errors/failure.dart';
import '../entities/order.dart'as order_entity;
import '../repositories/order_repository.dart';

class GetAllOrders {
  final OrderRepository repository;

  GetAllOrders(this.repository);

  Future<Either<Failure, List<order_entity.Order>>> call() async {
    return await repository.getAllOrders();
  }
}
