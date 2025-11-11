import 'package:dartz/dartz.dart';
import 'package:reservation_system/features/user/domain/entities/core/errors/failure.dart';
import 'package:reservation_system/features/order/domain/entities/order.dart' as order_entity;


abstract class OrderRepository {
  Future<Either<Failure, List<order_entity.Order>>> getAllOrders();
  Future<Either<Failure, List<order_entity.Order>>> getCustomerOrders(String customerId);
  Future<Either<Failure, order_entity.Order>> getOrderById(String id);
  Future<Either<Failure, order_entity.Order>> placeOrder(Order order);
  Future<Either<Failure, order_entity.Order>> updateOrder(Order order);
  Future<Either<Failure, void>> deleteOrder(String id);
}
