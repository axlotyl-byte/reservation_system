import 'package:dartz/dartz.dart' hide Order;
import 'package:reservation_system/features/user/domain/entities/core/errors/failure.dart';
import 'package:reservation_system/features/order/domain/entities/order.dart';
import 'package:reservation_system/features/order/domain/repositories/order_repository.dart';
import '../datasources/order_remote_data_source.dart';
import '../domain/models/order_model.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource remoteDataSource;

  OrderRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<Order>>> getAllOrders() async {
    try {
      final orders = await remoteDataSource.getAllOrders();
      return Right(orders.cast<Order>());
    } catch (e) {
      return Left(ServerFailure(e.toString())); // Remove 'message:'
    }
  }

  @override
  Future<Either<Failure, Order>> getOrderById(String id) async {
    try {
      final order = await remoteDataSource.getOrderById(id);
      return Right(order);
    } catch (e) {
      return Left(ServerFailure(e.toString())); // Remove 'message:'
    }
  }

  @override
  Future<Either<Failure, List<Order>>> getCustomerOrders(
      String customerId) async {
    try {
      final orders = await remoteDataSource.getCustomerOrders(customerId);
      return Right(orders.cast<Order>());
    } catch (e) {
      return Left(ServerFailure(e.toString())); // Remove 'message:'
    }
  }

  @override
  Future<Either<Failure, Order>> placeOrder(Order order) async {
    try {
      final orderModel = OrderModel.fromEntity(order);
      await remoteDataSource.placeOrder(orderModel);
      return Right(orderModel);
    } catch (e) {
      return Left(ServerFailure(e.toString())); // Remove 'message:'
    }
  }

  @override
  Future<Either<Failure, Order>> updateOrder(Order order) async {
    try {
      final orderModel = OrderModel.fromEntity(order);
      await remoteDataSource.updateOrder(orderModel);
      return Right(orderModel);
    } catch (e) {
      return Left(ServerFailure(e.toString())); // Remove 'message:'
    }
  }

  @override
  Future<Either<Failure, void>> deleteOrder(String id) async {
    try {
      await remoteDataSource.deleteOrder(id);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString())); // Remove 'message:'
    }
  }
}
