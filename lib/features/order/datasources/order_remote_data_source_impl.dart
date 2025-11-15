import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reservation_system/features/order/domain/models/order_model.dart';
import 'order_remote_data_source.dart';

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final FirebaseFirestore firestore;

  OrderRemoteDataSourceImpl(this.firestore);

  CollectionReference get orderCollection => firestore.collection('orders');

  @override
  Future<List<OrderModel>> getAllOrders() async {
    final snapshot = await orderCollection.get();
    return snapshot.docs.map((doc) => OrderModel.fromSnapshot(doc)).toList();
  }

  @override
  Future<OrderModel> getOrderById(String id) async {
    final doc = await orderCollection.doc(id).get();
    if (!doc.exists) {
      throw Exception('Order not found');
    }
    return OrderModel.fromSnapshot(doc);
  }

  @override
  Future<List<OrderModel>> getCustomerOrders(String customerId) async {
    final snapshot =
        await orderCollection.where('customerId', isEqualTo: customerId).get();
    return snapshot.docs.map((doc) => OrderModel.fromSnapshot(doc)).toList();
  }

  @override
  Future<void> placeOrder(OrderModel order) async {
    await orderCollection.doc(order.id).set(order.toJson());
  }

  @override
  Future<void> updateOrder(OrderModel order) async {
    await orderCollection.doc(order.id).update(order.toJson());
  }

  @override
  Future<void> deleteOrder(String id) async {
    await orderCollection.doc(id).delete();
  }
}
