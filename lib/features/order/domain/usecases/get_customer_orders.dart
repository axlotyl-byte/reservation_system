import 'package:dartz/dartz.dart';
import 'package:reservation_system/features/user/domain/entities/core/errors/failure.dart';
import '../entities/order.dart'as order_entity;
import '../repositories/order_repository.dart';

class GetCustomerOrders {
  final OrderRepository repository;

  GetCustomerOrders(this.repository);

  Future<Either<Failure, List<order_entity.Order>>> call(String customerId) async {
    return await repository.getCustomerOrders(customerId);
  }
}
