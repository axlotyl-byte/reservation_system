import '../domain/models/order_model.dart';


abstract class OrderRemoteDataSource {
  Future<List<OrderModel>> getAllOrders();
  Future<OrderModel> getOrderById(String id);
  Future<List<OrderModel>> getCustomerOrders(String customerId);
  Future<void> placeOrder(OrderModel order);
  Future<void> updateOrder(OrderModel order);
  Future<void> deleteOrder(String id);
}
